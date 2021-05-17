
import QtQuick 2.0
import Sailfish.Silica 1.0
import "../components"

Page {
    id: page

    allowedOrientations: Orientation.Portrait | Orientation.Landscape
                         | Orientation.LandscapeInverted

    function kiBToMiB(size){
        if (size < 100){
            return Math.round(size*10 / 1024) / 10;
        }else{
            return Math.round(size / 1024);
        }
    }

    Column {
        width: page.width
        spacing: Theme.paddingLarge
        PageHeader {
            title: qsTr("Memory Usage")
        }

        ProgressCircleBase {
            width: isPortrait ? parent.width /2 : parent.width / 3.5
            height: width
            anchors.horizontalCenter: parent.horizontalCenter
            value: 1 - (memory.free / memory.total)
            borderWidth: 2
            progressColor: Theme.highlightColor

            DoubleIndicator {
                topVal: kiBToMiB(memory.total - memory.free) + " "
                topUnit: "MiB"
                botVal: kiBToMiB(memory.total) + " "
                botUnit: "MiB"
            }
        }

        ProgressBar {
            minimumValue: 0
            maximumValue: 100
            value: (100 - memory.summaryValue)
            label: qsTr("%1 MiB free out of %2 MiB total").arg(kiBToMiB(memory.free)).arg(kiBToMiB(memory.total))
            anchors {
                left: parent.left
                right: parent.right
                margins: Theme.paddingLarge
            }
        }
    }
}
