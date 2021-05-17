
#include "monitor.h"
#include <QDebug>
#include <QFile>
#include <QTextStream>
#include <QStringList>
#include <QDir>
#include <QProcess>

namespace Lighthouse {
    const int CPU_FLAGS_ACTIVE = 1;
    const int CPU_FLAGS_INACTIV = 2;
    const int CPU_PART_COUNT = 10;
    const int CPU_PART_DEF[CPU_PART_COUNT] = {0, 1, 1, 1, 2, 2, 0, 0, 0, 0};

    Monitor::Monitor() : fSettings(), fProcMap(), fAppNameMap(),
        fTemperatureFile("/sys/class/thermal/thermal_zone0/temp")
    {
        fDBus = new QDBusInterface("com.nokia.dsme", "/com/nokia/dsme/request", "com.nokia.dsme.request", QDBusConnection::systemBus(), this);
        static QDBusConnection mceSignalconn = QDBusConnection::systemBus();
        mceSignalconn.connect("com.nokia.mce", "/com/nokia/mce/signal", "com.nokia.mce.signal", "display_status_ind", this, SLOT(handleDisplayStatus(const QDBusMessage&)));

        fInterval = fSettings.value("proc/interval", 2).toInt();
        fCoverPage = 0;
        fQuit = false;
        fUptime = 0;
        fTicksPerSecond = sysconf(_SC_CLK_TCK);
        fPaused = false;
        fApplicationActive = false;
        fProcessDetails = 0;
    }

    Monitor::~Monitor() {
        delete fDBus;
        fQuit = true;
        wait(2000);
    }

    int Monitor::getInterval() const {
        return fInterval;
    }

    void Monitor::setInterval(int interval) {
        if ( fInterval != interval ) {
            fInterval = interval;
            fSettings.setValue("proc/interval", interval);

            emit intervalChanged(interval);
        }
    }

    void Monitor::setPaused(bool paused) {
        fPaused = paused;
        if ( !fPaused ) {
            fPauser.wakeAll();
        }
    }

    bool Monitor::getPaused() const {
        return fPaused;
    }

    void Monitor::setCoverPage(int page) {
        if ( page < 0 ) {
            page = 2;
        } else if ( page > 2 ) {
            page = 0;
        }
        if ( fCoverPage != page ) {
            fCoverPage = page;
            emit coverPageChanged(page);
        }
    }

    int Monitor::getCoverPage() const {
        return fCoverPage;
    }

    static const QString COVER_IMAGE_CPU = Monitor::tr("cpu", "cover label");
    static const QString COVER_IMAGE_MEMORY = Monitor::tr("memory", "cover label");
    static const QString COVER_IMAGE_UNKNOWN = Monitor::tr("unknown", "cover label");

    const QString& Monitor::getCoverImageLeft() const {
        switch ( fCoverPage ) {
            case 1: return COVER_IMAGE_CPU;
            case 2: return COVER_IMAGE_MEMORY;
        }

        return COVER_IMAGE_UNKNOWN;
    }

    const QString& Monitor::getCoverImageRight() const {
        switch ( fCoverPage ) {
            case 0: return COVER_IMAGE_MEMORY;
            case 2: return COVER_IMAGE_CPU;
        }

        return COVER_IMAGE_UNKNOWN;
    }

    static const QString COVER_LABEL_CPU = Monitor::tr("CPU");
    static const QString COVER_LABEL_MEMORY = Monitor::tr("Memory");
    static const QString COVER_LABEL_UNKNOWN = Monitor::tr("Unknown", "Cover label in summary page");

    const QString& Monitor::getCoverLabel() const {
        switch ( fCoverPage ) {
            case 0: return COVER_LABEL_CPU;
            case 1: return COVER_LABEL_MEMORY;
        }

        return COVER_LABEL_UNKNOWN;
    }

    QString Monitor::getUptime() const {
        return getUptimeString(fUptime);
    }

    IntList Monitor::getCPUUsage() const {
        return fCPUUsage;
    }

    void Monitor::reboot() {
        fDBus->call("req_reboot");
    }

    void Monitor::shutdown() {
        fDBus->call("req_shutdown");
    }

    void Monitor::setProcessDetails(int active) {
        fProcessDetails = active;
    }

    void Monitor::setApplicationActive(bool active) {
        fApplicationActive = active;
    }

    void Monitor::run() {
        updateApplicationMap("/usr/share/applications");
        procProcessorCount();
        fCPUActiveTicks.resize(fCPUCount + 1); // room for "total"
        fCPUTotalTicks.resize(fCPUCount + 1); // room for "total"

        fCPUUsage.clear();
        for ( int i = 0; i <= fCPUCount; i++ ) {
            fCPUActiveTicks[i] = 0;
            fCPUTotalTicks[i] = 0;
            fCPUUsage.append(0.0f);
        }

        unsigned long iteration = 0;

        QStringList filters;
        QString fileName;
        while (!fQuit) {
            if ( !fPaused ) {
                procCPUActivity();
                procMemory();
                procTemperature();

                if ( fApplicationActive || iteration == 0 ) {
                    procUptime();
                    if ( fProcessDetails != 0 || iteration == 0 ) {
                        procProcesses();
                    } else {
                        procProcessCount();
                    }
                }
                iteration++;
                sleep(fInterval);
            } else {
                fPauser.wait(&fMutex);
            }
        }
    }

    void Monitor::procProcessorCount() {
        CPUCountHandler handler(fCPUCount);
        QString path = QStringLiteral("/proc/cpuinfo");
        if ( fProcReader.readProcFile(path, handler, 255, -1) != 0 ) {
            qCritical() << "Error reading processor count\n";
        }
    }

    void Monitor::procCPUActivity() {
        CPUUsageHandler handler(fCPUUsage, fCPUActiveTicks, fCPUTotalTicks);
        QString path = QStringLiteral("/proc/stat");
        if ( fProcReader.readProcFile(path, handler, fCPUCount + 1, -1) == 0 ) {
            emit CPUUsageChanged(fCPUUsage);
        }
    }

    void Monitor::procMemory() {
        unsigned long free = 0;
        MemoryHandler handler(fTotalMemory, free);

        QString path = QStringLiteral("/proc/meminfo");
        if ( fProcReader.readProcFile(path, handler, 4, -1) == 0 ) {
            emit memoryChanged(fTotalMemory, free);
        }
    }

    void Monitor::procUptime() {
        UptimeHandler handler(fUptime, fUpidle);
        QString path = QStringLiteral("/proc/uptime");
        if ( fProcReader.readProcFile(path, handler, 1, -1) == 0 ) {
            emit uptimeChanged(getUptime());
        } else {
            qCritical() << "Unable to read meminfo\n";
        }
    }

    void Monitor::procProcessCount() {
        const int count = fProcReader.getProcList().size();
        emit processCountChanged(count);
    }

    pid_t Monitor::getNextPID(QStringListIterator& iterator, int iteration) {
        if ( fProcessDetails > 0 ) {
            return iteration == 0 ? fProcessDetails : 0;
        }

        return iterator.hasNext() ? iterator.next().toInt() : 0;
    }

    void Monitor::procProcesses() {
        PIDList deletes;
        PIDList adds;
        unsigned long long totalTicks = 0;

        if ( fCPUTotalTicks.size() > 0 ) {
            totalTicks = fCPUTotalTicks[0];
        }

        ProcessStatHandler statHandler(fProcMap, totalTicks);
        ProcessStatMHandler statMHandler(fProcMap, fTotalMemory);
        ProcessCmdLineHandler cmdLineHandler(fProcMap, fAppNameMap);

        QStringList procList = fProcReader.getProcList();
        QStringListIterator slIterator(procList);
        pid_t pid;
        int iteration = 0;

        while ( (pid = getNextPID(slIterator, iteration)) != 0 ) {
            iteration++;
            const QString pidStr = QString::number(pid);
            QString pathStatM("/proc/" + pidStr + "/statm");
            QString pathCmdLine("/proc/" + pidStr + "/cmdline");
            QString pathStat("/proc/" + pidStr + "/stat");

            if ( !fProcMap.contains(pid) ) {
                fProcMap[pid];
                adds.append(pid);
            }

            const QString oldName = fProcMap.value(pid).getStatName();
            if ( fProcReader.readProcFile(pathStat, statHandler, 1, pid) != 0 ) {
                qCritical() << "Error reading process stat file " << pid << "\n";
                continue;
            }

            if ( !oldName.isEmpty() && oldName != fProcMap.value(pid).getStatName() ) {
                fProcMap.remove(pid);
                fProcMap[pid];
                deletes.append(pid);
                adds.append(pid);
                if ( fProcReader.readProcFile(pathStat, statHandler, 1, pid) != 0 ) {
                    qCritical() << "Error reading process stat file " << pid << "\n";
                    continue;
                }
            }

            if ( fProcReader.readProcFile(pathStatM, statMHandler, 1, pid) != 0 ) {
                qCritical() << "Error reading process mstat file " << pid << "\n";
                continue;
            }

            if ( fProcMap.value(pid).getNameState() == 0 ) {
                if ( fProcReader.readProcFile(pathCmdLine, cmdLineHandler, 1, pid) != 0 ) {
                    qCritical() << "Error reading process cmdline file " << pid << "\n";
                    continue;
                }
            }
        }

        QMapIterator<pid_t, ProcInfo> iterator(fProcMap);
        while ( iterator.hasNext() ) {
            iterator.next();
            const pid_t pid = iterator.key();
            const QString pidStr = QString::number(pid);
            QString pathStat("/proc/" + pidStr + "/stat");

            if ( !QFile::exists(pathStat) ) {
                fProcMap.remove(pid);
                deletes.append(pid);
            }
        }

        emit processChanged(&fProcMap, adds, deletes);
    }

    void Monitor::procTemperature() {
        if ( fTemperatureFile.isOpen() || fTemperatureFile.open(QFile::ReadOnly) ) {
            fTemperatureFile.reset();
            QByteArray content = fTemperatureFile.readAll();
            QString value = QString(content).replace("\n", "").left(2);
            emit temperatureChanged(value.toInt());
        }
    }

    void Monitor::updateAppName(const QString& fileName) {
        const QString fullName = "/usr/share/applications/" + fileName;
        if ( !QFile::exists(fullName) ) {
            qWarning() << "File not found: " << fullName << "\n";
            return;
        }

        QSettings desktop(fullName, QSettings::IniFormat);
        desktop.setIniCodec("UTF-8");
        const QString appName = desktop.value("Desktop Entry/Name", "Unknown").toString();
        if ( appName == "Unknown" ) {
            return;
        }

        QString baseName(fileName);
        if ( fileName.startsWith("apkd_launcher") ) { // android name needs cleanup
            baseName.replace("apkd_launcher_", "");
            const int n = baseName.indexOf('-');
            baseName.remove(n, baseName.length() - n);
            baseName.replace("_", ".");
        } else { // sailfish just has .desktop at the end
            baseName.replace(".desktop", "");
        }

        fAppNameMap[baseName] = appName;
    }

    void Monitor::updateApplicationMap(const QString& path) {
        QDir apps(path); // "/usr/share/applications"
        QStringList filters;
        filters << "*.desktop";
        apps.setNameFilters(filters);

        const QStringList files = apps.entryList();
        QStringListIterator iterator(files);
        fAppNameMap.clear();
        while ( iterator.hasNext() ) {
            const QString& fileName = iterator.next();
            updateAppName(fileName);
        }
    }


    void Monitor::handleDisplayStatus(const QDBusMessage& msg)
    {
        QList<QVariant> args = msg.arguments();
        const QString status = args.at(0).toString();
        setPaused(status == "off");
    }

}
