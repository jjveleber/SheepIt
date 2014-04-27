import QtQuick 2.2

Item{

    width: 330
    height: 330
    property string imgSrc

    Rectangle {
        id:buzzer
        anchors.fill: parent
        color: "Transparent"

        Image {

           source: imgSrc
           smooth: true

        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent
        }

        states: State {
            name: "pressed"
            when: mouseArea.pressed
            PropertyChanges {
                target: buzzer
                scale: 1.2
            }
        }

        transitions:  Transition {
           NumberAnimation {
               properties: "scale"
               duration: 200
               easing.type: Easing.InOutQuad
           }
        }
    }
}
