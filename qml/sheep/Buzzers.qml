import Game 1.0
import QtQuick 2.0

Item {
    id: me
    height: childrenRect.height
    width: childrenRect.width
    property Game gameInstance
    property alias playBackAni: playBackAnimation
    property string playBackAniQml
    property alias externalButtonMonitor: externalButtonMonitor


    Row { // The "Row" type lays out its child items in a horizontal line
        spacing: 20 // Places 20px of space between items
        Buzzer{
            id: blueButton
            imgSrc: "qrc:/pics/BlueButton"
            positionIndex: 0
            gameInstance: me.gameInstance
        }

        Buzzer{
            id: orangeButton
            imgSrc: "qrc:/pics/OrangeButton"
            positionIndex: 1
            gameInstance: me.gameInstance
        }

        Buzzer{
            id: purpleButton
            imgSrc: "qrc:/pics/PurpleButton"
            positionIndex: 2
            gameInstance: me.gameInstance
        }

        Buzzer{
            id: greenButton
            imgSrc: "qrc:/pics/GreenButton"
            positionIndex: 3
            gameInstance: me.gameInstance
        }
    }

    SequentialAnimation {
        id:playBackAnimation
        ScriptAction {
            script: {
                var ani = Qt.createQmlObject(playBackAniQml, buzzers, "playBackAniQml");
                ani.start();
            }
        }
    }

    Item {
        id:externalButtonMonitor
        property int buttonPos: -1
        onButtonPosChanged: {
            switch(buttonPos) {
            case 0:
                purpleButton.buzzerPressedAction.start();
                break;
            case 1:
                blueButton.buzzerPressedAction.start();
                break;
            case 2:
                orangeButton.buzzerPressedAction.start();
                break;
            case 3:
                greenButton.buzzerPressedAction.start();
                break;
             default:
                 break;
            }

            buttonPos = -1;


        }
    }



}
