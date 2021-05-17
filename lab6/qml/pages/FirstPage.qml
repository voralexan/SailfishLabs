import QtQuick 2.0
import Sailfish.Silica 1.0
import ClassCounter 1.0

Page {
    id: page

    // The effective value will be restricted by ApplicationWindow.allowedOrientations
    allowedOrientations: Orientation.All

    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        anchors.fill: parent

        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {
            MenuItem {
                text: qsTr("Show Page 2")
                onClicked: pageStack.push(Qt.resolvedUrl("SecondPage.qml"))
            }
        }

        // Tell SilicaFlickable the height of its content.
        contentHeight: column.height

        // Place our content in a Column.  The PageHeader is always placed at the top
        // of the page, followed by our content.
        Column {
            id: column
            y: +500
            width: page.width
            spacing: Theme.paddingLarge
            Column {
                y:500
                spacing: 10
                width: parent.width
                ClassCounter {
                    id: counter
                    count: 0
                    onMySignal: text.text = counter.getCount()
                }
                Label {
                    id: text
                    y: 100
                    text: counter.getCount()
                    font.pixelSize: 80
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                Button {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "Увеличить"
                    onClicked: counter.add()
                }
                Button {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "Сбросить"
                    onClicked: counter.reset()
                }
            }
        }
    }
}
