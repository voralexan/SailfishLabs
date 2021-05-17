
#include "procreader.h"
#include <QDir>
#include <QFile>
#include <QTextStream>
#include <QDebug>

namespace Lighthouse {

    ProcReader::ProcReader() : fProcNameFilter()
    {
        fProcNameFilter << "[0-9]*";
    }

    int ProcReader::readProcFile(const QString& path, LineHandler& handler, int count, int index) const {
        QFile file(path);
        if ( !file.open(QIODevice::ReadOnly) ) {
            qCritical() << "Unable to open proc file " << path << "\n";
            return -1;
        }

        QTextStream stream(&file);
        QString line = stream.readLine(4096);
        int c = 0;
        int i;
        while ( !line.isNull() && c < count ) {
            i = c;
            if ( index >= 0 ) {
                i = index;
            }

            int n = handler.onLine(line, i);
            if ( n < 0 ) {
                return n;
            } else if ( n == 100 ) { // skip rest, we're done
                break;
            }
            line = stream.readLine(4096);
            c++;
        }

        return 0;
    }

    int ProcReader::getProcCount() const {
        QDir dir("/proc");
        dir.setFilter(QDir::Dirs);
        dir.setNameFilters(fProcNameFilter);

        return dir.count();
    }

    const QStringList ProcReader::getProcList() const {
        QDir dir("/proc");
        dir.setSorting(QDir::Name);
        dir.setFilter(QDir::Dirs);
        dir.setNameFilters(fProcNameFilter);

        return dir.entryList();
    }

}
