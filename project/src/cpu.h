
#ifndef CPU_H
#define CPU_H

#include <QObject>
#include <QAbstractListModel>
#include "types.h"

namespace Lighthouse {

    class CPU : public QAbstractListModel
    {
        Q_OBJECT
        Q_PROPERTY(int summaryValue READ getSummaryValue NOTIFY summaryValueChanged)
        Q_PROPERTY(int temperature READ getTemperature NOTIFY temperatureChanged)
    public:
        enum ProcessRoles {
            CPUUsageRole = Qt::UserRole + 1
        };

        explicit CPU(QObject *parent = 0);

        QHash<int, QByteArray> roleNames() const;
        Qt::ItemFlags flags(const QModelIndex & index) const;
        QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;
        QVariant headerData(int section, Qt::Orientation orientation, int role = Qt::DisplayRole) const;
        int rowCount(const QModelIndex & parent = QModelIndex()) const;

        int getSummaryValue() const;
        int getTemperature() const;
    private:
        IntList fUsage;
        int fTotalUsage;
        int fTemperature;
    public slots:
        void setUsage(const IntList& usage);
        void setTemperature(int degrees);
    signals:
        void usageChanged();
        void summaryValueChanged();
        void temperatureChanged();
    };

}

#endif // CPU_H
