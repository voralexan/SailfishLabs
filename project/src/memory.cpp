
#include "memory.h"
#include <QDebug>

namespace Lighthouse {

    Memory::Memory(QObject *parent) :
        QObject(parent)
    {
        fTotal = 0;
        fFree = 0;
    }

    unsigned long long Memory::getFree() const {
        return fFree;
    }

    unsigned long long Memory::getTotal() const {
        return fTotal;
    }

    int Memory::getSummaryValue() const {
        return 100 - qRound((qreal)fFree / (qreal)fTotal * 100.0f);
    }

    void Memory::setMemory(unsigned long total, unsigned long free) {
        int changed = 0;
        if ( fTotal != total ) {
            fTotal = total;
            emit totalChanged(total);
            changed++;
        }

        if ( fFree != free ) {
            fFree = free;
            emit freeChanged(free);
            changed++;
        }

        if ( changed > 0 ) {
            emit summaryValueChanged(getSummaryValue());
        }
    }

}
