
#ifndef LINEHANDLER_H
#define LINEHANDLER_H

#include <QString>
#include "types.h"

namespace Lighthouse {

    class LineHandler
    {
    public:
        virtual int onLine(QString& line, int i) = 0;
    };

    class UptimeHandler: public LineHandler
    {
    public:
        UptimeHandler(qreal& uptime, qreal& upidle);
        int onLine(QString& line, int i);
    private:
        qreal& fUptime;
        qreal& fUpidle;
    };

    class MemoryHandler: public LineHandler
    {
    public:
        MemoryHandler(unsigned long& total, unsigned long& free);
        int onLine(QString& line, int i);
    private:
        unsigned long& fTotal;
        unsigned long& fFree;
    };

    class CPUCountHandler: public LineHandler
    {
    public:
        CPUCountHandler(int& count);
        int onLine(QString& line, int i);
    private:
        int& fCount;
    };

    class CPUUsageHandler: public LineHandler
    {
    public:
        CPUUsageHandler(IntList& usage, QLLVector& activeTicks, QLLVector& totalTicks);
        int onLine(QString& line, int i);
    private:
        IntList& fCPUUsage;
        QLLVector& fCPUActiveTicks;
        QLLVector& fCPUTotalTicks;

        unsigned long long parseCPUParts(QStringList &parts, int flags);
    };

    class ProcessStatHandler: public LineHandler
    {
    public:
        ProcessStatHandler(ProcMap& procMap, unsigned long long totalTicks);
        int onLine(QString& line, int i);
    private:
        unsigned long long fTotalTicks;
        ProcMap& fProcMap;
    };

    class ProcessStatMHandler: public LineHandler
    {
    public:
        ProcessStatMHandler(ProcMap& procMap, unsigned long totalMemory);
        int onLine(QString& line, int i);
    private:
        unsigned long fTotalMemory;
        ProcMap& fProcMap;
    };

    class ProcessCmdLineHandler: public LineHandler
    {
    public:
        ProcessCmdLineHandler(ProcMap& procMap, AppNameMap& appNameMap);
        int onLine(QString& line, int i);
    private:
        ProcMap& fProcMap;
        AppNameMap& fAppNameMap;
    };


}

#endif // LINEHANDLER_H
