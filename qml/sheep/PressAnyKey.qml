import QtQuick 2.2

Rectangle {
    id: me
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.verticalCenter: parent.verticalCenter
    anchors.margins: height / 1.3
    height: 100

    radius: 10
    color: "#FFC500"
    Text {
        FontLoader {
            id: myFont
            source: "qrc:/fonts/myfont"
        }
        anchors.centerIn: parent
        anchors.margins: 20
        font.pixelSize: parent.height / 1.3
        font.family: myFont.name;
        text: "Press Any Button To Start"
        color: "black"
    }


    states: [
        State {
            name: "visible"
        },
        State {
            name: "hidden"
        }

    ]

    transitions: [
        Transition {
            from: "*"
            to: "hidden"
            animations: OpacityAnimator {
                target: me
                from: 1
                to: 0
                duration: 250
            }
        },
        Transition {
            from: "*"
            to: "visible"
            animations: OpacityAnimator {
                target: me
                from: 0
                to: 1
                duration: 250
            }
        }
    ]

    SequentialAnimation{
        running: true
        loops: Animation.Infinite
        ScaleAnimator {
            target: me
            from: 1
            to: 0.9
            easing.type: Easing.InSine;
            duration: 300
        }
        ScaleAnimator {
            target: me
            from: 0.9
            to: 1
            easing.type: Easing.OutSine;
            duration: 300
        }
    }
}

