
#include "cpu.h"
#include <QtDebug>

namespace Lighthouse {

    CPU::CPU(QObject *parent) : QAbstractListModel(parent), fUsage() {
        fTotalUsage = 0;
        fTemperature = 0;
    }

    QHash<int, QByteArray> CPU::roleNames() const {
        QHash<int, QByteArray> roles;
        roles[CPUUsageRole] = "cpuUsage";
        return roles;
    }

    Qt::ItemFlags CPU::flags(const QModelIndex & index __attribute__ ((unused)) ) const {
        return Qt::ItemIsEnabled;
    }

    QVariant CPU::data(const QModelIndex & index, int role) const {
        const int row = index.row();
        if ( row >= 0 && (row + 1) < fUsage.size() ) {
            switch ( role ) {
                case CPUUsageRole: return fUsage.at(row + 1);
            }
        }

        return tr("Data") + "[" + QString::number(index.row()) + "," + QString::number(index.column()) + "]: " + QString::number(role);
    }

    QVariant CPU::headerData(int section __attribute__ ((unused)), Qt::Orientation orientation __attribute__ ((unused)), int role __attribute__ ((unused)) ) const {
        return tr("Description");
    }

    int CPU::rowCount(const QModelIndex & parent __attribute__ ((unused)) ) const {
        return fUsage.size() > 0 ? fUsage.size() - 1 : 0;
    }

    int CPU::getSummaryValue() const {
       return fTotalUsage;
    }

    int CPU::getTemperature() const {
        return fTemperature;
    }

    void CPU::setUsage(const IntList& usage) {
        int usize = usage.size();
        if ( usize > 0 && fTotalUsage != usage.at(0) ) {
            fTotalUsage = usage.at(0);
            emit summaryValueChanged();
        }

        fUsage = usage;
        emit dataChanged(createIndex(0, 0), createIndex(usize - 1, 0));
    }

    void CPU::setTemperature(int degrees) {
        if ( fTemperature != degrees ) {
            fTemperature = degrees;
            emit temperatureChanged();
        }
    }

}
