import QtQuick 2.0
import Sailfish.Silica 1.0

Page {

    PullDownMenu {
        MenuItem {
            text: qsTr("Show Task 8")
            onClicked: pageStack.push(Qt.resolvedUrl("TenPage.qml"))
        }
    }

    SilicaWebView {
        id: webView
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            bottom: tf1.top
        }
        url: "https://www.youtube.com/"
    }
    TextField {
        id: tf1
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        text: "https://www.youtube.com/"
        label: webView.title
        EnterKey.onClicked: webView.url = text
    }
}
