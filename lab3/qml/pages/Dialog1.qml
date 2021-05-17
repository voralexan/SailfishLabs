import QtQuick 2.0
import Sailfish.Silica 1.0

Dialog {
    property alias textFieldValue: tf.text
    Column {
        width: parent.width
        DialogHeader {}
        TextField {
            id: tf
            width: parent.width
        }
    }
}
