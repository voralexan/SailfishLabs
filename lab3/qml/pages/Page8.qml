import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: page

    // The effective value will be restricted by ApplicationWindow.allowedOrientations
    allowedOrientations: Orientation.All

    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        anchors.fill: parent

        ListModel {
                id: taskModel
                ListElement {name: "Задача 1"}
                ListElement {name: "Задача 2"}
                ListElement {name: "Задача 3"}
                ListElement {name: "Задача 4"}
            }


        // Place our content in a Column.  The PageHeader is always placed at the top
        // of the page, followed by our content.



                SlideshowView {
                    id: ssv
                    model: taskModel
                    anchors.centerIn: parent
                    height: width
                    itemHeight: width
                    itemWidth: width
                    delegate: Rectangle {
                        color: "transparent"
                        width: ssv.itemWidth
                        height: ssv.itemHeight
                        Text {
                            anchors.centerIn: parent
                            text: name
                        }
                    }
                }


    }
}
