import Game 1.0
import QtQuick 2.2

Item{

    width: 330
    height: 330
    property string imgSrc
    property int positionIndex: 0
    property Game gameInstance

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
            onClicked: {
                buzzer.state = "clicked";
            }
        }

        states: [
            State {
                name: "clicked"
            }

        ]

        transitions: [
            Transition {
                to: "clicked"
                animations: bubbleAnimation
            }
        ]

        SequentialAnimation {
            id:bubbleAnimation
            NumberAnimation {
               target: buzzer
               properties: "scale"
               from: 1.0
               to: 1.2
               duration: 300
               easing.type: Easing.InOutQuad
            }
            NumberAnimation {
               target: buzzer
               properties: "scale"
               from: 1.2
               to: 1.0
               duration: 300
               easing.type: Easing.InOutQuad
            }
            ScriptAction {
                script: {
                    buzzer.state = "";
                    game.buttonPressed(positionIndex);
                }
            }
        }
    }
}
