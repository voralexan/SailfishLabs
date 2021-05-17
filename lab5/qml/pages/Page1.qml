import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: page

    // The effective value will be restricted by ApplicationWindow.allowedOrientations
    allowedOrientations: Orientation.All


        // Place our content in a Column.  The PageHeader is always placed at the top
        // of the page, followed by our content.

        SilicaFlickable {
            anchors.fill: parent
            contentHeight: column.height

            Column {
                id: column
                anchors.fill: parent
                spacing: Theme.paddingLarge
                property int count : 0

                Item {
                    Timer {
                        interval: 2000; running: true; repeat: true
                        onTriggered: column.count = column.count + 1
                    }

                }
                Rectangle {
                    id: red
                    width: 200
                    height: 200
                    radius: 100
                    anchors.horizontalCenter: parent.horizontalCenter
                    state: "ON"
                    states: [
                        State {
                            name: "ON"
                            PropertyChanges {
                                target: red
                                color: "red"
                            }
                            when: (column.count%3 == 0)
                        },
                        State {
                            name: "OFF"
                            PropertyChanges {
                                target: red
                                color: "black"
                            }
                            when: (column.count%3 != 0)
                        }
                    ]
                }
                Rectangle {
                    id: yellow
                    width: 200
                    height: 200
                    radius: 100
                    anchors.horizontalCenter: parent.horizontalCenter
                    state: "OFF"
                    states: [
                        State {
                            name: "ON"
                            PropertyChanges {
                                target: yellow
                                color: "yellow"
                            }
                            when: (column.count%3 == 1)
                        },
                        State {
                            name: "OFF"
                            PropertyChanges {
                                target: yellow
                                color: "black"
                            }
                            when: (column.count%3 != 1)
                        }
                    ]
                }
                Rectangle {
                    id: green
                    width: 200
                    height: 200
                    radius: 100
                    anchors.horizontalCenter: parent.horizontalCenter
                    state: "OFF"
                    states: [
                        State {
                            name: "ON"
                            PropertyChanges {
                                target: green
                                color: "green"
                            }
                            when: (column.count%3 == 2)
                        },
                        State {
                            name: "OFF"
                            PropertyChanges {
                                target: green
                                color: "black"
                            }
                            when: (column.count%3 != 2)
                        }
                    ]
                }

/*
                Image {
                id: personImg
                source: "image://theme/icon-m-person"

                state: "left"

                states: [
                State {
                name: "left"
                PropertyChanges {
                target: personImg
                x: 0
                }
                when: (green.state == "OFF")
                },
                State {
                name: "right"
                extend: "left"
                PropertyChanges {
                target: personImg
                x: 650
                }
                when: (green.state == "ON")
                }
                ]

                transitions: [
                Transition {
                from: "left"
                to: "right"
                SequentialAnimation {
                NumberAnimation {
                property: "x"
                from: 0
                to: 650
                duration: 2000
                }
                NumberAnimation {
                property: "x"
                from: 650
                to: 0
                duration: 2000
                }
                }
                }
                ]
                }*/





            }

        }


}
