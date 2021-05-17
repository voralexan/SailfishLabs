import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.XmlListModel 2.0

Page {
    function loadCurs() {
        var xhr = new XMLHttpRequest();
        xhr.open("GET", "http://www.cbr.ru/scripts/XML_daily.asp", true);
    //    xhr.setRequestHeader(Accept-Language, en);
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                model1.xml = xhr.responseText;
            }
        }
        xhr.send();
    }

    XmlListModel {
        id: model1
     //   source: "http://www.cbr.ru/scripts/XML_daily.asp"

        query: "/ValCurs/Valute"
        XmlRole {
            name: "Code"
            query: "CharCode/string()"
        }
        XmlRole {
            name: "Value"
            query: "Value/string()"
        }

    }
    SilicaListView {
        anchors.fill: parent
        header: PageHeader {title: "Курсы валют" }
        model: model1
        delegate: Column {
            Label {
                text: Code
            }
            Label {
                text: Value
            }
        }
    }

    Component.onCompleted: loadCurs()
}

