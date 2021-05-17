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
                text: qsTr("Show Task 6")
                onClicked: pageStack.push(Qt.resolvedUrl("EigthPage.qml"))
            }
        }

        // Tell SilicaFlickable the height of its content.
        contentHeight: column.height

        // Place our content in a Column.  The PageHeader is always placed at the top
        // of the page, followed by our content.
        Column {
            id: column

            PageHeader {
                title: qsTr("Время")
            }
            width: page.width
            spacing: Theme.paddingLarge
            TextField {
                id: tf1
            }
            Button {
                text: "Открыть диалог"
                onClicked: {
                    var dialog = pageStack.push("Sailfish.Silica.TimePickerDialog", {hour: 12, minute: 30});
                    dialog.accepted.connect(function() {
                    tf1.text = dialog.hour + ": " + dialog.minute;
                    });
                }
            }
        }
    }
}
