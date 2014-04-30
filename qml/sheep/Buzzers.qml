import Game 1.0
import QtQuick 2.0

Item {
    id: me
    height: childrenRect.height
    width: childrenRect.width
    property Game gameInstance

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
}
