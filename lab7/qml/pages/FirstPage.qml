import QtQuick 2.0
import Sailfish.Silica 1.0
import Request 1.0

Page {
    id: page
    allowedOrientations: Orientation.All

    Request {
        id: request
        onImageChanged: image.source = request.getImage()
        onRespondChanged: label.text = request.getRespond()

    }

    Column {
        width: parent.width
        height: parent.height
        spacing: 15
        Label {
            id: label
            font.pixelSize: 25
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Button {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Get-запрос"
            onClicked: {
                request.sendGetRequest();
            }
        }
        Label {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Тело POST запроса:"
        }
        TextField {
            id: textField
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Button {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Post-запрос"
            onClicked: {
                request.sendPostRequest(textField.text);
            }
        }
        Image {
            width: 150
            height: 150
            anchors.horizontalCenter: parent.horizontalCenter
            id: image
        }
        Button {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Получить картинку"
            onClicked: {
                request.sendImageRequest();
            }
        }
        Label {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Тело PUT запроса:"
        }
        TextField {
            id: textField2
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Button {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Put-запрос"
            onClicked: {
                request.sendPutRequest(textField2.text);
            }
        }
    }
}
