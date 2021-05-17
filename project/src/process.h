
#ifndef PROCESS_H
#define PROCESS_H

#include <QObject>
#include <QVariantList>
#include <QAbstractListModel>
#include <QSettings>
#include "types.h"

namespace Lighthouse {

    class Process : public QAbstractListModel
    {
        Q_OBJECT
        // processes
        Q_PROPERTY(int selectedPID READ getSelectedPID WRITE selectPID NOTIFY selectedPIDChanged)
        Q_PROPERTY(int summaryValue READ getSummaryValue NOTIFY summaryValueChanged)
        Q_PROPERTY(int sortBy READ getSortBy NOTIFY sortByChanged)
        Q_PROPERTY(bool applicationsOnly READ getApplicationsOnly NOTIFY applicationsOnlyChanged)
        // details
        Q_PROPERTY(int selectedCPUUsage READ getSelectedCPUUsage NOTIFY selectedChanged)
        Q_PROPERTY(int selectedMemoryUsage READ getSelectedMemoryUsage NOTIFY selectedChanged)
        Q_PROPERTY(const QString selectedName READ getSelectedName NOTIFY selectedChanged)
        Q_PROPERTY(const QString selectedProcName READ getSelectedProcName NOTIFY selectedChanged)
        Q_PROPERTY(int selectedTick READ getSelectedTick NOTIFY selectedChanged)
    public:
        enum ProcessRoles {
            PIDRole = Qt::UserRole + 1,
            NameRole,
            CPUUsageRole,
            MemoryUsageRole
        };

        explicit Process(QObject *parent = 0);

        QHash<int, QByteArray> roleNames() const;
        Qt::ItemFlags flags(const QModelIndex & index) const;
        QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;
        QVariant headerData(int section, Qt::Orientation orientation, int role = Qt::DisplayRole) const;
        int rowCount(const QModelIndex & parent = QModelIndex()) const;
        int getSortBy() const;
        int getSummaryValue() const;
        bool getApplicationsOnly() const;
        int getSelectedPID() const;
        void selectPID(int pid);
        Q_INVOKABLE bool isKillable() const;
        Q_INVOKABLE void setSortBy(int sb);
        Q_INVOKABLE void nextApplicationsOnly();
        Q_INVOKABLE int killSelected();
    private:
        uid_t fUID;
        int fSortBy;
        int fSelectedPID;
        int fSelectedTick;
        const ProcMap* fProcMap;
        PIDList fProcKeys;
        PIDList fAppKeys;
        bool fApplicationsOnly;
        int fPageStatus;
        bool fApplicationActive;
        int fProcCount;
        bool fPauseUpdates;
        CPUComparer fCPUComparer;
        MemoryComparer fMemoryComparer;
        NameComparer fNameComparer;
        QSettings fSettings;

        void removeKeys(const PIDList &deletes, PIDList& list, bool really);
        void appendKeys(const PIDList &adds, PIDList& list, bool really, bool appsOnly);
        void sort(PIDList& list);
        const PIDList& getKeys() const;
        const BaseComparer* getComparer() const;
        void beginRR(bool really, int first, int last);
        void endRR(bool really);
        void beginIR(bool really, int first, int last);
        void endIR(bool really);

        const QString getSelectedName() const;
        const QString getSelectedProcName() const;
        int getSelectedCPUUsage() const;
        int getSelectedMemoryUsage() const;
        int getSelectedTick() const;
    signals:
        void summaryValueChanged();
        void sortByChanged();
        void selectedPIDChanged();
        void applicationsOnlyChanged();
        void selectedChanged();
    public slots:
        void setProcesses(const ProcMap* procMap, const PIDList& adds, const PIDList& deletes);
        void setProcessCount(int count);
    };

}

#endif // PROCESS_H
