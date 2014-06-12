import Game 1.0
import QtQuick 2.0

Item {
    id: me
    height: childrenRect.height
    width: childrenRect.width
    property Game gameInstance
    property alias playBackAni: playBackAnimation
    property string testAniQml: "
import QtQuick 2.0

SequentialAnimation {
    SequentialAnimation {
        NumberAnimation {
           target: blueButton
           properties: \"scale\"
           from: 1.0
           to: 1.2
           duration: 300
           easing.type: Easing.InOutQuad
        }
        NumberAnimation {
           target: blueButton
           properties: \"scale\"
           from: 1.2
           to: 1.0
           duration: 300
           easing.type: Easing.InOutQuad
        }
    }
    SequentialAnimation {
        NumberAnimation {
           target: orangeButton
           properties: \"scale\"
           from: 1.0
           to: 1.2
           duration: 300
           easing.type: Easing.InOutQuad
        }
        NumberAnimation {
           target: orangeButton
           properties: \"scale\"
           from: 1.2
           to: 1.0
           duration: 300
           easing.type: Easing.InOutQuad
        }
    }
    SequentialAnimation {
        NumberAnimation {
           target: purpleButton
           properties: \"scale\"
           from: 1.0
           to: 1.2
           duration: 300
           easing.type: Easing.InOutQuad
        }
        NumberAnimation {
           target: purpleButton
           properties: \"scale\"
           from: 1.2
           to: 1.0
           duration: 300
           easing.type: Easing.InOutQuad
        }
    }
    SequentialAnimation {
        NumberAnimation {
           target: greenButton
           properties: \"scale\"
           from: 1.0
           to: 1.2
           duration: 300
           easing.type: Easing.InOutQuad
        }
        NumberAnimation {
           target: greenButton
           properties: \"scale\"
           from: 1.2
           to: 1.0
           duration: 300
           easing.type: Easing.InOutQuad
        }
    }
}

";


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
                var ani = Qt.createQmlObject(testAniQml, buzzers, "testAniQml");
                ani.start();
            }
        }
    }



}
