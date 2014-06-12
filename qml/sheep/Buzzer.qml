import Game 1.0
import QtQuick 2.2

Item{
    id: me
    width: 330
    height: 330
    property string imgSrc
    property int positionIndex: 0
    property Game gameInstance
    property alias playBackAni : playBackAnimation


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
//                me.state = "clicked";
                clickAnimation.start();
            }
        }
    }

//    states: [
//        State {
//            name: "clicked"
//        },
//        State {
//            name: "play"
//        }

//    ]

    transitions: [
//        Transition {
//            from: "*"
//            to: "clicked"
//            animations: SequentialAnimation {
//                animations: [bubbleAnimation, buzzerPressedAction]
//            }
//        },
        Transition {
            id: debugTransition
            from: "*"
            to: "*"
            animations: ScriptAction {
                script: {
                    console.debug("debugTransition...", "index:", positionIndex,  "state: " + me.state
                                  + " gameInstance.isPlayBack: " + gameInstance.isPlayBack
                                  + " gameInstance.playBackPosition: " + gameInstance.playBackPosition);
                }
            }
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
    }

    ScriptAction {
        id: buzzerPressedAction
        script: {
            game.buttonPressed(positionIndex);
        }
    }

    SequentialAnimation {
        id:clickAnimation
        animations: [bubbleAnimation, buzzerPressedAction]
    }

    SequentialAnimation {
        id:playBackAnimation
        animations: [bubbleAnimation]
        onRunningChanged: {
            console.debug("running", bubbleAnimation.running);
//            function getBuzzer(index) {
//                switch(index) {
//                case 0:
//                    return blueButton;
//                case 1:
//                    return orangeButton;
//                case 2:
//                    return purpleButton;
//                case 3:
//                    return greenButton;
//                }
//            }
//            if(!running) {
//                var pos = gameInstance.incrementPlayBackPosition();
//                if(pos >= 0) {
//                    var buzzer = getBuzzer(pos);
//                    console.debug("playback", buzzer.id);
//                    buzzer.playBackAni.start();
//                } else {
//                    console.debug("playback complete");
//                    gameInstance.isPlayBack = false;
//                }
//            }
        }
    }

}
