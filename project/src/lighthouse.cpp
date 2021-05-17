
#ifdef QT_QML_DEBUG
#include <QtQuick>
#endif

#include "sailfishapp.h"
#include <QObject>
#include <QString>
#include <QQuickView>
#include <QQmlContext>
#include <QGuiApplication>
#include <QFileSystemWatcher>
#include "types.h"
#include "monitor.h"
#include "cpu.h"
#include "memory.h"
#include "process.h"

using namespace Lighthouse;

int main(int argc, char *argv[])
{
    int result = 0;
    qRegisterMetaType< IntList >( "IntList" );
    qRegisterMetaType< PIDList >( "PIDList" );
    qRegisterMetaType< ProcMap >( "ProcMap" );

    QGuiApplication *app = SailfishApp::application(argc, argv);
    Monitor monitor;
    CPU cpu;
    Process process;
    Memory memory;
    QFileSystemWatcher appsWatch;
    appsWatch.addPath("/usr/share/applications");

    QQuickView *view = SailfishApp::createView();

    QObject::connect(&monitor, &Monitor::CPUUsageChanged,
                     &cpu, &CPU::setUsage);
    QObject::connect(&monitor, &Monitor::temperatureChanged,
                     &cpu, &CPU::setTemperature);
    QObject::connect(&monitor, &Monitor::memoryChanged,
                     &memory, &Memory::setMemory);
    QObject::connect(&monitor, &Monitor::processChanged,
                     &process, &Process::setProcesses);
    QObject::connect(&monitor, &Monitor::processCountChanged,
                     &process, &Process::setProcessCount);
    QObject::connect(&appsWatch, &QFileSystemWatcher::directoryChanged,
                     &monitor, &Monitor::updateApplicationMap);

    QString qml = QString("qml/%1.qml").arg(ANAME);
    view->rootContext()->setContextProperty("cpu", &cpu);
    view->rootContext()->setContextProperty("memory", &memory);
    view->rootContext()->setContextProperty("monitor", &monitor);
    view->rootContext()->setContextProperty("process", &process);
    view->setSource(SailfishApp::pathTo(qml));
    view->show();

    monitor.start(); // start thread after all receivers are connected

    result = app->exec();

    delete view;
    delete app;

    return result;
}

