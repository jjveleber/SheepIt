import Game 1.0
import Score 1.0
import QtQuick 2.2
import QtQuick.Layouts 1.1
import QtQuick.Particles 2.0


Rectangle {
    width: 1440
    height: 1080

    focus: true;
    Keys.onPressed: { if (event.key == Qt.Key_Escape) Qt.quit(); }

    Game {
        id: game
        yourScore {
            scoreIndex: 1
        }

        highScore {
            scoreIndex: 100
        }
    }

    Image {
        anchors.fill: parent
        source: "qrc:/pics/Background"
        fillMode: Image.Tile
    }

    FontLoader {
        id: myFont
        source: "qrc:/fonts/myfont"
    }

    Image {
        id: sheepLogo
        source: "qrc:/pics/sheep288"
        anchors.verticalCenter: sheepItLable.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 100
        smooth: true
    }
    Image {
        id: sheepLogoShadow
        source: "qrc:/pics/sheep288"
        anchors.verticalCenter: sheepItLable.verticalCenter
        anchors.left: sheepLogo.left
        anchors.top: sheepLogo.top
        anchors.leftMargin: 10
        anchors.topMargin: 10
        opacity: 0.25
        smooth: true
    }

    Text {
        id:sheepItLable
        font.family: myFont.name
        font.pixelSize: 150 * (parent.width/1440)
        color: "#fffee4"
        text: "Sheep It!"
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: 50
        anchors.rightMargin: 100
    }

    Text {
        id:highScoreLable
        font.family: myFont.name
        font.pixelSize: 150 * (parent.width/1440)
        text: "High Score:"
        color: "#a01e01"
        anchors.left: parent.left
        anchors.top: sheepItLable.bottom
        anchors.topMargin: 20
        anchors.leftMargin: 50
        anchors.rightMargin: 50
        anchors.bottomMargin: 50
    }

    Text {
        id:highScoreText
        font: highScoreLable.font
        color: "#a01e01"
        text: game.highScore.scoreString
        anchors.left: highScoreLable.right
        anchors.verticalCenter: highScoreLable.verticalCenter
        anchors.leftMargin: 20
    }

    Text {
        id:yourScoreLable
        font: highScoreLable.font
        text: "Your Score:"
        anchors.left: highScoreLable.left
        anchors.top: highScoreLable.bottom
        anchors.topMargin: 25
    }

    Text {
        id:yourScoreText
        font: yourScoreLable.font
        text: game.yourScore.scoreString
        anchors.left: yourScoreLable.right
        anchors.verticalCenter: yourScoreLable.verticalCenter
        anchors.leftMargin: 20

    }

    MouseArea {
        id:yourScoreTextMouseArea
        anchors.fill: yourScoreText
        onClicked: {
            youScoredAnimation.start();
        }
    }

    Text {
        id:yourNewScoreText
        font: yourScoreLable.font
        text: game.yourScore.nextScoreString
        anchors.left: yourScoreText.left
        y: 0
        opacity: 0.0

    }

    SequentialAnimation {
        id:youScoredAnimation
        SequentialAnimation {
            ParallelAnimation {
                YAnimator {
                    id:yourNewScoreYAni
                    target: yourNewScoreText;
                    from: 0
                    to: yourScoreText.y
                    easing.type: Easing.InBack;
                    duration: 500
                }
                OpacityAnimator {
                    target: yourNewScoreText
                    from: 0.1
                    to: 1
                    easing.type: Easing.Linear;
                    duration: 500
                }
                ScaleAnimator {
                    target: yourNewScoreText
                    from: 0
                    to: 1
                    easing.type: Easing.OutBounce;
                    duration: 300
                }

            }
            ScriptAction {
                script: {
                    shootingStarEmitter.burst(750);
                    shootingStarBurst.pulse(300);
                }
            }
            ParallelAnimation {
                PropertyAnimation {
                    target:yourNewScoreText
                    property: "text"
                    to: yourScoreText.text
                    duration: 0
                }

                PropertyAnimation {
                    target:yourScoreText
                    property: "text"
                    to: yourNewScoreText.text
                    duration: 0
                }
            }

            ScaleAnimator {
                target: yourNewScoreText
                from: 1
                to: 0
                easing.type: Easing.OutBounce;
                duration: 300
            }

            OpacityAnimator {
                target: yourNewScoreText
                from: 1
                to: 0
                easing.type: Easing.Linear;
                duration: 0
            }

            YAnimator {
                target: yourNewScoreText;
                to: 0
                easing.type: Easing.Linear;
                duration: 0
            }

        }
        running: false
    }



    Row { // The "Row" type lays out its child items in a horizontal line
            spacing: 20 // Places 20px of space between items
            anchors.bottom: parent.bottom
            anchors.topMargin: 25
            anchors.bottomMargin: 50
            anchors.horizontalCenter: parent.horizontalCenter

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


    ParticleSystem {
        id:yourScoreStarParticles
        anchors.fill: parent
        paused: false

        // Shooting star particles
        ImageParticle {
            source: "qrc:/pics/GoldStartParticle"
            color: "#ffefaf"
            colorVariation: 1.0
            alpha: 0
            entryEffect: ImageParticle.Scale
            rotationVariation: 180
            rotationVelocity: 90
            rotationVelocityVariation: 90
            autoRotation: true
        }

        Emitter {
            id: shootingStarEmitter
            emitRate: 100
            lifeSpan: 2000
            x: yourScoreText.x
            y: yourScoreText.y
            width: yourScoreText.width
            height: yourScoreText.height
            velocity: PointDirection {xVariation: 50; yVariation: 50;}
            acceleration: PointDirection {xVariation: 120; yVariation: 120;}
            size: 32
            sizeVariation: 16
            shape: EllipseShape {
                fill: true
            }
            enabled: false
        }
        Emitter {
            id: shootingStarBurst
            emitRate: shootingStarEmitter.emitRate * 2
            lifeSpan: 100
            x: yourScoreText.x
            y: yourScoreText.y
            width: yourScoreText.width
            height: yourScoreText.height
            velocity: PointDirection {xVariation: 60; yVariation: 60;}
            acceleration: PointDirection {xVariation: 40; yVariation: 40;}
            size: 24
            sizeVariation: 16
            shape: EllipseShape {
                fill: true
            }
            enabled: false
        }


    }
}
