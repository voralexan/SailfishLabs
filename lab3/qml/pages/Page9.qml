import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: page

    // The effective value will be restricted by ApplicationWindow.allowedOrientations
    allowedOrientations: Orientation.All

    SilicaFlickable {
            anchors.fill: parent
            contentHeight: column.height
            PullDownMenu {
                MenuItem {
                    text: "Задача 1"
                    onClicked: tf1.text = text
                }
                MenuItem {
                    text: "Задача 2"
                    onClicked: tf1.text = text
                }
                MenuItem {
                    text: "Задача 3"
                    onClicked: tf1.text = text
                }
            }

                Column {
                    id: column
                    width: page.width
                    spacing: Theme.paddingLarge
                    TextField {
                        id: tf1
                        text: "..."
                    }
                }

            PushUpMenu {
                MenuItem {
                    text: "Задача 1"
                    onClicked: tf1.text = text
                }
                MenuItem {
                    text: "Задача 2"
                    onClicked: tf1.text = text
                }
                MenuItem {
                    text: "Задача 3"
                    onClicked: tf1.text = text
                }
            }

    }
}
