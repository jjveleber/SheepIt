import Game 1.0
import Score 1.0
import QtQuick 2.2
import QtQuick.Layouts 1.1
import QtQuick.Particles 2.0
import QtQuick.Controls 1.1
import QtMultimedia 5.0


Rectangle {


    width: 1440
    height: 1080

    focus: true;
    Keys.onPressed: {
        if (event.key === Qt.Key_Escape) {
            game.close();
            Qt.quit();
        }
    }


    Game {
        id: game

        comPortName: "COM3"

        property bool isHighScore: false
        property bool waitingForPlayer: true


        onIsPlayBackChanged: {
            if(game.isPlayBack) {
                startPlayAnimation.start();
            }
        }

        onExternalButtonPressed: {
            buzzers.externalButtonMonitor.buttonPos = game.externalButton;
        }

        onGameOver: {
            gameOverSnd.play();
        }

        yourScore {
            scoreIndex: 0
            onScoreChanged: {
                isHighScore = false;
                scores.state = "playerScored";
            }
            onScoreReset: {
                scores.state = "reset"
            }
        }

        highScore {
            onScoreChanged: {
                isHighScore = true;
            }
        }
    }

    SoundEffect{
        id:gameOverSnd
        source: "qrc:/sndfx/gameover"
        onPlayingChanged: {
            if(!playing) {
                game.waitingForPlayer = true;
                anyKey.state = "visible";
            }
        }
    }

    SequentialAnimation {
        id: startPlayAnimation
        ScriptAction {
            script: {
                game.waitingForPlayer = false;
                anyKey.state = "hidden";
            }
        }
        PauseAnimation { duration: 1500 }
        ScriptAction {
            script: {
                buzzers.playBackAniQml = game.playBackAnimationQml;
                buzzers.playBackAni.start();
            }
        }
    }

    Image {
        anchors.fill: parent
        source: "qrc:/pics/Background"
        fillMode: Image.Tile
    }

    Text {
        id: cheatText
        text: game.cheatString
        font.pixelSize: 50
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width
        anchors.bottom: parent.bottom
        opacity: 0
        MouseArea {
            anchors.fill: parent
            onClicked: {
                cheatText.opacity = 0.75;
            }
        }
    }

   Header {
       id: header
       anchors.left: parent.left
       anchors.right: parent.right
       anchors.top: parent.top
       anchors.topMargin: 50
   }

   Buzzers {
       id: buzzers
       anchors.bottom: parent.bottom
       anchors.topMargin: 25
       anchors.bottomMargin: 35
       anchors.horizontalCenter: parent.horizontalCenter

       gameInstance: game
   }

   Scoring {
        id: scores
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: header.bottom

        gameInstance: game
   }

   PressAnyKey {
       id:anyKey
   }

}
