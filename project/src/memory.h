
#ifndef MEMORY_H
#define MEMORY_H

#include <QObject>

namespace Lighthouse {

    class Memory : public QObject
    {
        Q_OBJECT
        Q_PROPERTY(unsigned long free READ getFree NOTIFY freeChanged)
        Q_PROPERTY(unsigned long total READ getTotal NOTIFY totalChanged)
        Q_PROPERTY(int summaryValue READ getSummaryValue NOTIFY summaryValueChanged)
    public:
        explicit Memory(QObject *parent = 0);

        unsigned long long getFree() const;
        unsigned long long getTotal() const;
        int getSummaryValue() const;
    private:
        unsigned long fFree;
        unsigned long fTotal;
    signals:
        void freeChanged(int free);
        void totalChanged(int total);
        void summaryValueChanged(int value);
    public slots:
        void setMemory(unsigned long total, unsigned long free);
    };

}

#endif // MEMORY_H
