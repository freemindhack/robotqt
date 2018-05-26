import QtQuick 2.9
import QtQuick.Controls 2.2

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    color: "#ff00ff00";
    title: qsTr("Scroll")

    ScrollView {
        anchors.fill: parent

        ListView {
            width: parent.width
            model: 20

            ColorAnimation {
                from: "green"
                to: "black"
                duration: 200
            }
            delegate: ItemDelegate {                
                text: "Item  set\n 122" + (index + 1)
                width: parent.width
            }
            Button{
               text: "ceshi"
               width: parent.width
            }
        }
    }
}
