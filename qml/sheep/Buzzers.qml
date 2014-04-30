import QtQuick 2.0

Row { // The "Row" type lays out its child items in a horizontal line
    spacing: 20 // Places 20px of space between items
    Buzzer{
        id: blueButton
        imgSrc: "qrc:/pics/BlueButton"
    }

    Buzzer{
        id: orangeButton
        imgSrc: "qrc:/pics/OrangeButton"
    }

    Buzzer{
        id: purpleButton
        imgSrc: "qrc:/pics/PurpleButton"
    }

    Buzzer{
        id: greenButton
        imgSrc: "qrc:/pics/GreenButton"
    }
}
