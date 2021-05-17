import QtQuick 2.0
import Sailfish.Silica 1.0
import Nemo.Configuration 1.0

Page {
    id: page

    // The effective value will be restricted by ApplicationWindow.allowedOrientations
    allowedOrientations: Orientation.All

    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        anchors.fill: parent

        ConfigurationValue {
            id: textsetting
            key: "/lab/textsetting"
            defaultValue: "Default"
        }
        ConfigurationValue {
            id: flag
            key: "/lab/flagsetting"
            defaultValue: false
        }


        // Tell SilicaFlickable the height of its content.
        contentHeight: column.height

        // Place our content in a Column.  The PageHeader is always placed at the top
        // of the page, followed by our content.
        Column {
            id: column

            width: page.width
            spacing: Theme.paddingLarge

            Column {
                TextField {
                    id: tf1
                    text: textsetting.value
                }
                Button {
                    text: "Применить"
                    onClicked: textsetting.value = tf1.text
                }
            }
            Column {
                TextSwitch {
                    id: ts1
                    text: "флаг"
                    checked: flag.value
                }
                Button {
                    text: "Применить"
                    onClicked: flag.value = ts1.checked
                }
            }
        }
    }
}
