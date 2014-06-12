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
           target: buzzer
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
           target: buzzer
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
           target: buzzer
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
           target: buzzer
           properties: \"scale\"
           from: 1.2
           to: 1.0
           duration: 300
           easing.type: Easing.InOutQuad
        }
    }
}
