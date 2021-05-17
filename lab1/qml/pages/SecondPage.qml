import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: page

    // The effective value will be restricted by ApplicationWindow.allowedOrientations
    allowedOrientations: Orientation.All

    SilicaListView {
        id: listView
        model: 20
        anchors.fill: parent
        header: PageHeader {
            title: qsTr("Nested Page")
        }
        delegate: BackgroundItem {
            id: delegate

            Label {
                x: Theme.horizontalPageMargin
                text: qsTr("Item") + " " + index
                anchors.verticalCenter: parent.verticalCenter
                color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
            }
            onClicked: console.log("Clicked " + index)
        }
        VerticalScrollDecorator {}
    }
/*
    Dialog {
        id: dialog;
        Column {
            anchors.fill: parent;
            id: column;
            width: parent.width;
            spacing: Theme.paddingMedium;
            DialogHeader {}
            Row {
                spacing: 160;
                x: 24;
                Label {
                    text: "First number:"
                }
                Label {
                    text: "Second number:"
                }
            }
            Row {
                width: parent.width;
                spacing: 24;
                TextField {
                    id: number1;
                    width: parent.width/2 - 12;
                }
                TextField {
                    id: number2;
                    width: parent.width/2 - 12;
                }
            }
            Button {
                width: parent.width;
                text: "Sum numbers";
                onClicked: {
                    console.log(parseInt(number1.text) + parseInt(number2.text));
                }
            }
        }
    }*/

}
