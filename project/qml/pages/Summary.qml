
import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: page
    allowedOrientations: Orientation.Portrait | Orientation.Landscape
                         | Orientation.LandscapeInverted

    SilicaFlickable {
        anchors.fill: parent

        contentHeight: column.height

        Column {
            id: column

            width: page.width
            spacing: Theme.paddingLarge
            PageHeader {
                title: qsTr("Summary")
            }

            Row {
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    margins: Theme.paddingLarge
                }

                Label {
                    color: Theme.primaryColor
                    text: qsTr("Uptime: ")
                }

                Label {
                    color: Theme.highlightColor
                    text: monitor.uptime
                }
            }

            Button {
                text: qsTr("CPUs: ") + cpu.summaryValue + "%"
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    margins: Theme.paddingLarge
                }
                onClicked: pageStack.push(Qt.resolvedUrl("CPU.qml"))
            }


            Button {
                text: qsTr("Memory: ") + memory.summaryValue + "%"
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    margins: Theme.paddingLarge
                }
                onClicked: pageStack.push(Qt.resolvedUrl("Memory.qml"))
            }

            Button {
                text: qsTr("Processes: ") + process.summaryValue
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    margins: Theme.paddingLarge
                }
                onClicked: pageStack.push(Qt.resolvedUrl("Process.qml"))
            }

        }
    }
}


