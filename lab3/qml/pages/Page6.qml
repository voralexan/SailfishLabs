import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    ListModel {
        id: lm1
        ListElement {name: "Задача 1"; date: "10.10.10";}
        ListElement {name: "Задача 2"; date: "11.11.11";}
        ListElement {name: "Задача 3"; date: "12.12.12";}
    }
   SilicaListView {
       anchors.fill: parent
       model: lm1
       header: PageHeader { title: "Tasks"}
       section {
           property: "date"
           delegate: SectionHeader {text: section}
       }
       delegate: Text {text: name}
   }
}
