import QtQuick 2.0
import Sailfish.Silica 1.0

Dialog {
    id: dialog;
    Column {
        property int sum: 6;
        anchors.fill: parent;
        id: column;
        width: parent.width;
        spacing: Theme.paddingMedium;
        DialogHeader {}
        Row {
            width: parent.width;
            spacing: 25;
            TextField {
                id: number1;
                width: parent.width/2 - 12.5;
            }
            TextField {
                id: number2;
                width: parent.width/2 - 12.5;
            }
        }

        Row {
            width: parent.width;
            spacing: 25;
            TextField {
                id: result;
                width: parent.width/2 - 12.5;
                x: parent.x/2;
                text: '0';
            }
        }

        Button {
            width: parent.width;
            text: "Сложить";
            onClicked: {
                console.log(parseInt(number1.text) + parseInt(number2.text));
                result.text = (parseInt(number1.text) + parseInt(number2.text)).toString();
               // result.text = toString(parseInt(number1.text.valueOf()));
            }
        }


    }
}
