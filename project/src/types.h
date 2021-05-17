
#ifndef TYPES_H
#define TYPES_H

#include <QObject>
#include <QString>
#include <QMap>

namespace Lighthouse {

    const QString ANAME = QStringLiteral("Lighthouse");
    const QString LNAME = QStringLiteral("harbour-lighthouse");
    typedef QList<int> IntList;
    typedef QList<pid_t> PIDList;
    typedef QVector<unsigned long long> QLLVector;
    typedef QMap<QString, QString> AppNameMap;

    class ProcInfo
    {
    public:
        ProcInfo();
        void updateStat(QString& stat, unsigned long long totalTicks);
        void updateMemory(QString& mem, unsigned long totalMemory);
        void updateApplicationName(QString& appName);
        void updateName(QString& appName);

        const QString& getName() const;
        const QString& getStatName() const;
        const QString& getProcName() const;
        pid_t getPID() const;
        int getCPUUsage() const;
        int getMemoryUsage() const;
        int getNameState() const;
        bool isApplication() const;

        bool operator ==(const ProcInfo& other) const;
    private:
        QString fApplicationName;
        QString fProcName;
        QString fStatName;
        QString fShowName;
        pid_t fPID;
        int fCPUUsage;
        int fMemoryUsage;
        QString fState;
        int fNameState;
        unsigned long fVmSize;
        unsigned long fVmRSS;
        unsigned long fSharedMem;
        unsigned long fSysTime;
        unsigned long fUserTime;
        unsigned long fTotalTicks;

        void setShowName(QString& source, int nameState);
    };

    typedef QMap<pid_t, ProcInfo> ProcMap;

    QString getUptimeString(qreal uptime);

    class BaseComparer {
    protected:
        const ProcMap* fProcMap;
    public:
        void setProcMap(const ProcMap* procMap);
        virtual bool operator()(const pid_t a, const pid_t b) const { return (a > b); }
    };

    class CPUComparer : public BaseComparer
    {
    public:
        bool operator()(const pid_t a, const pid_t b) const;
    };

    class MemoryComparer : public BaseComparer
    {
    public:
        bool operator()(const pid_t a, const pid_t b) const;
    };

    class NameComparer : public BaseComparer
    {
    public:
        bool operator()(const pid_t a, const pid_t b) const;
    };

}

#endif // TYPES_H
