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
                text: qsTr("Show Dialog")
                onClicked: pageStack.push(Qt.resolvedUrl("dialog.qml"))
            }
        }

        // Tell SilicaFlickable the height of its content.
        contentHeight: column.height

        // Place our content in a Column.  The PageHeader is always placed at the top
        // of the page, followed by our content.
        Column {
            id: column
            width: page.width
            property int sizeRect: 200
            spacing: Theme.paddingLarge

            Rectangle {
                width: page.width
                height: column.sizeRect * 2.4
                color: "transparent"
                Rectangle {
                    width: column.sizeRect
                    height: column.sizeRect
                    x: column.sizeRect/2
                    y: column.sizeRect/2
                    color: "red"
                    Rectangle {
                        width: column.sizeRect
                        height: column.sizeRect
                        x: column.sizeRect
                        y: column.sizeRect/2
                        color: "green"
                        Rectangle {
                            id: blueRect
                            width: column.sizeRect
                            height: column.sizeRect
                            x: column.sizeRect/2
                            y: -column.sizeRect/2
                            color: "blue"
                            Text {
                                text: "Square"
                                color: "white"
                                anchors.centerIn: blueRect
                            }
                        }
                    }
                }
            }

//            Rectangle {
//                width: parent.width
//                height: column.sizeRect + column.sizeRect/12
//                color: "transparent"

//                Row {
//                    anchors.horizontalCenter: parent.horizontalCenter
//                    anchors.verticalCenter: parent.verticalCenter
//                    spacing: column.sizeRect / 6;

//                    Rectangle {
//                        width: column.sizeRect;
//                        height: column.sizeRect
//                        color: "yellow"
//                    }
//                    Rectangle {
//                        width: column.sizeRect;
//                        height: column.sizeRect
//                        color: "green"
//                    }
//                    Rectangle {
//                        width: column.sizeRect;
//                        height: column.sizeRect
//                        color: "blue"
//                    }
//                }
//            }

//            Rectangle {
//                width: parent.width
//                height: column.sizeRect + column.sizeRect/12
//                color: "transparent"

//                Row {
//                    anchors.horizontalCenter: parent.horizontalCenter
//                    anchors.verticalCenter: parent.verticalCenter
//                    spacing: column.sizeRect / 6;

//                    Rectangle {
//                        width: column.sizeRect;
//                        height: column.sizeRect
//                        color: "magenta"
//                    }
//                    Rectangle {
//                        width: column.sizeRect;
//                        height: column.sizeRect
//                        color: "transparent"
//                    }
//                    Rectangle {
//                        width: column.sizeRect;
//                        height: column.sizeRect
//                        color: "yellow"
//                    }
//                }
//            }

            Rectangle {
                width: parent.width
                height: column.sizeRect * 3
                color: "transparent"

                Grid{
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    columns: 3
                    rows: 3
                    spacing: column.sizeRect / 6
                    Rectangle {
                        width: column.sizeRect;
                        height: column.sizeRect
                        color: "red"
                    }
                    Rectangle {
                        width: column.sizeRect;
                        height: column.sizeRect
                        color: "green"
                    }
                    Rectangle {
                        width: column.sizeRect;
                        height: column.sizeRect
                        color: "blue"
                    }
                    Rectangle {
                        width: column.sizeRect;
                        height: column.sizeRect
                        color: "magenta"
                    }
                    Rectangle {
                        width: column.sizeRect;
                        height: column.sizeRect
                        color: "transparent"
                    }
                    Rectangle {
                        width: column.sizeRect;
                        height: column.sizeRect
                        color: "black"
                    }

                }
            }

            Rectangle {
                width: parent.width
                height : column.sizeRect*1.5
                color: "transparent"
                Rectangle {
                    id: startRect
                    width: column.sizeRect*1.5
                    height: column.sizeRect*1.5
                    x: width/18
                    y: height/18
                    color: "black"
                    Rectangle {
                        width: parent.width
                        height: parent.height
                        color: parent.color
                        z: 1
                        transform: [Scale { xScale: 0.5; yScale: 1 }, Rotation { angle: 45}, Translate {x: column.sizeRect * 2.8} ]
                    }
                }
            }

            Rectangle {
                width: parent.width
                height: column.sizeRect * 4;
                color: "transparent"
                Rectangle {
                    id: flyBox;
                    y: 50;
                    anchors.horizontalCenter: parent.horizontalCenter;
                    width: 0;
                    height: 0;
                    color: "black";
                    SequentialAnimation {
                        loops: Animation.Infinite;
                        id: animation;
                        running: true
                        ParallelAnimation {
                            PropertyAnimation {
                                target: flyBox;
                                property: "y";
                                from: 50; to: page.width - column.sizeRect - 25; duration: 4000;
                            }
                            PropertyAnimation {
                                target: flyBox;
                                property: "width";
                                from: 0; to: column.sizeRect; duration: 4000;
                            }
                            PropertyAnimation {
                                target: flyBox;
                                property: "height";
                                from: 0; to: column.sizeRect; duration: 4000;
                            }
                        }
                        ParallelAnimation {
                            PropertyAnimation {
                                target: flyBox;
                                property: "y";
                                from: parent.width - column.sizeRect - 50; to: 50; duration: 4000;

                            }
                            PropertyAnimation {
                                target: flyBox;
                                property: "width";
                                from: column.sizeRect; to: 0; duration: 4000;
                            }
                            PropertyAnimation {
                                target: flyBox;
                                property: "height";
                                from: column.sizeRect; to: 0; duration: 4000;
                            }
                        }
                    }
                }
            }
       }
   }
}
