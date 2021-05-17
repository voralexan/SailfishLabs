import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.XmlListModel 2.0

Page {
    XmlListModel {
        id: model1
        source: "http://www.cbr.ru/scripts/XML_daily.asp"
        query: "/ValCurs/Valute"
        XmlRole {
            name: "Name"
            query: "Name/string()"
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
                text: Name
            }
            Label {
                text: Value
            }
        }
    }

//    Component.onCompleted: loadNews()
}
