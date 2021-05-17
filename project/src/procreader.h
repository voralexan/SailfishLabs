
#ifndef PROCREADER_H
#define PROCREADER_H

#include <QString>
#include <QStringList>
#include "linehandler.h"

namespace Lighthouse {

    class ProcReader
    {
    public:
        ProcReader();
        int readProcFile(const QString& path, LineHandler& handler, int count, int index) const;
        int getProcCount() const;
        const QStringList getProcList() const;
    private:
        QStringList fProcNameFilter;
    };

}

#endif // PROCREADER_H
