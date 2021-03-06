import Game 1.0
import QtQuick 2.2
import QtQuick.Layouts 1.1
import QtQuick.Particles 2.0
import QtMultimedia 5.0

Item {
    id:me

    property Game gameInstance

    Component.onCompleted: {
        yourScoreText.text = gameInstance.yourScore.scoreString(gameInstance.yourScore.scoreIndex);
        highScoreText.text = gameInstance.highScore.scoreString(gameInstance.highScore.scoreIndex);
    }

    SheepText {
        id:highScoreLable

        text: "High Score:"
        color: "#a01e01"
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.topMargin: 20
        anchors.leftMargin: 50
        anchors.rightMargin: 50
        anchors.bottomMargin: 50
    }

    SheepText {
        id:highScoreText
        color: "#a01e01"
        anchors.left: highScoreLable.right
        anchors.verticalCenter: highScoreLable.verticalCenter
        anchors.leftMargin: 20
    }

    SheepText {
        id:yourScoreLable

        text: "Your Score:"
        anchors.left: highScoreLable.left
        anchors.top: highScoreLable.bottom
        anchors.topMargin: 25
    }

    SheepText {
        id:yourScoreText
        anchors.left: yourScoreLable.right
        anchors.verticalCenter: yourScoreLable.verticalCenter
        anchors.leftMargin: 20

    }

    MouseArea {
        id:yourScoreTextMouseArea
        anchors.fill: yourScoreText
    }

    SheepText {
        id:yourNewScoreText
        anchors.left: yourScoreText.left
        opacity: 0.0

    }

    states: [
        State {
            name: "playerScored"
        },
        State {
            name: "reset"
        }

    ]

    transitions: [
        Transition {
            from: "*"
            to: "playerScored"
            animations: youScoredAnimation
        },
        Transition {
            from: "*"
            to: "reset"
            animations: resetGameAnimation
        }

    ]

    SequentialAnimation {
        id: resetGameAnimation
        running: false

        // TODO: end of game screen reset after play
        ScaleAnimator {
            target: yourScoreText
            from: 1
            to: 0
            easing.type: Easing.InBounce;
            duration: 300
        }
        PropertyAction {
            target: yourScoreText
            property: "text"
            value: "0"
        }
        ScaleAnimator {
            target: yourScoreText
            from: 0
            to: 1
            easing.type: Easing.OutBounce;
            duration: 300
        }
    }

    SoundEffect{
        id: slideSnd
        source: "qrc:/sndfx/whoosh"

    }

    SoundEffect{
        id: clunkSnd
        source: "qrc:/sndfx/clunk"

    }

    SoundEffect{
        id: chimeSnd
        source: "qrc:/sndfx/chime"

    }

    SoundEffect{
        id:highScoreYay1Snd
        source: "qrc:/sndfx/yay1"
    }

    SoundEffect{
        id:highScoreYay2Snd
        source: "qrc:/sndfx/yay2"
    }

    SequentialAnimation {
        id:youScoredAnimation
        running: false
        SequentialAnimation {
            ScriptAction {
                script: {
                    yourScoreText.text = gameInstance.yourScore.scoreString(gameInstance.yourScore.scoreIndex -1);
                    yourNewScoreText.text = gameInstance.yourScore.scoreString(gameInstance.yourScore.scoreIndex);
                }
            }
            ParallelAnimation {
                ScriptAction {
                    script: {
                        slideSnd.play();
                    }
                }

                YAnimator {
                    id:yourNewScoreYAni
                    target: yourNewScoreText;
                    from: -me.y
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
                    clunkSnd.play();
                    chimeSnd.play();
                    shootingStarEmitter.burst(750);
                    shootingStarBurst.pulse(300);
                }
            }
            ParallelAnimation {
                ScaleAnimator {
                    target: yourNewScoreText
                    from: 1
                    to: 0
                    easing.type: Easing.OutBounce;
                    duration: 300
                }

                ScriptAction {
                    script: {
                        yourScoreText.text = gameInstance.yourScore.scoreString(gameInstance.yourScore.scoreIndex);
                        highScoreText.text = gameInstance.highScore.scoreString(gameInstance.highScore.scoreIndex);
                        if(gameInstance.isHighScore) {
                            function randomNumber(from, to) {
                               return Math.floor(Math.random() * (to - from + 1) + from);
                            }
                            if(randomNumber(1,2) == 1) {
                                highScoreYay1Snd.play();
                            } else {
                                highScoreYay2Snd.play();
                            }
                        }

                        gameInstance.isPlayBack = true;
                    }
                }

            }
        }
        PropertyAction {
            target: me
            properties: "state"
            value: ""
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
