
import QtQuick 2.0
import Sailfish.Silica 1.0
import "../components"

Page {
    id: page
    allowedOrientations: Orientation.Portrait | Orientation.Landscape
                         | Orientation.LandscapeInverted
    onStatusChanged: {
        if ( status === PageStatus.Active ) {
            process.selectedPID = 0
            monitor.setProcessDetails( -1 ) // monitor all
        } else if ( status === PageStatus.Inactive ) {
            monitor.setProcessDetails( process.selectedPID )
        }
    }

    SilicaListView {
        id: listView
        header: PageHeader {
            title: process.applicationsOnly ? qsTr("Applications") : qsTr("Processes")
        }

        property int preSelectedPID : 0

        anchors.fill: parent
        spacing: 2
        model: process
        VerticalScrollDecorator {
            flickable: listView
        }

        delegate: ProcIndicator {
            procName: name
            cpuUse: cpuUsage
            memUse: memoryUsage

            onPressed: {
                listView.preSelectedPID = processID
            }
        }
    }
}
