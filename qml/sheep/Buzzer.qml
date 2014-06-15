import Game 1.0
import QtQuick 2.2
import QtMultimedia 5.0

Item{
    id: me
    width: 330
    height: 330
    property string imgSrc
    property int positionIndex: 0
    property Game gameInstance
    property alias buzzerPressedAction: clickAnimation

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
                clickAnimation.start();
            }
        }
    }

    SoundEffect{
        id: popSnd
        source: "qrc:/sndfx/pop"
    }

    ParallelAnimation {
        id: bubbleAnimation
        ScriptAction {
            script: {
                popSnd.play();
            }
        }
        SequentialAnimation {
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
        }
    }


    ScriptAction {
        id: buzzerPressedAction
        script: {
            if(gameInstance.waitingForPlayer) {
                gameInstance.resetGame();
                gameInstance.isPlayBack = true;
                boingSnd.play();
            } else {
                gameInstance.buttonPressed(positionIndex);
            }
        }
    }

    SoundEffect{
        id: boingSnd
        source: "qrc:/sndfx/boing"
    }

    SequentialAnimation {
        id:clickAnimation
        animations: [bubbleAnimation, buzzerPressedAction]
    }

    SequentialAnimation {
        id:playBackAnimation
        animations: [bubbleAnimation]
    }

}
