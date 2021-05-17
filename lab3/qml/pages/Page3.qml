import QtQuick 2.0
import Sailfish.Silica 1.0

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
                text: qsTr("Show Task 4")
                onClicked: pageStack.push(Qt.resolvedUrl("SixthPage.qml"))
            }
        }

        // Tell SilicaFlickable the height of its content.
        contentHeight: column.height

        // Place our content in a Column.  The PageHeader is always placed at the top
        // of the page, followed by our content.
        Column {
            id: column

            width: page.width
            spacing: Theme.paddingLarge
            TextField {
                id: tf1
                label: "Введите текст"
            }
            Button {
                text: "Открыть"
                onClicked: {
                var dialog = pageStack.push(Qt.resolvedUrl("Dialog1.qml"));
                dialog.accepted.connect(function() {
                tf1.text = dialog.textFieldValue;
                });
                }
            }
        }
    }
}
