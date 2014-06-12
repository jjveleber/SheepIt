import Game 1.0
import Score 1.0
import QtQuick 2.2
import QtQuick.Layouts 1.1
import QtQuick.Particles 2.0
import QtQuick.Controls 1.1


Rectangle {
    width: 1440
    height: 1080

    focus: true;
    Keys.onPressed: { if (event.key === Qt.Key_Escape) Qt.quit(); }


    Game {
        id: game

        Component.onCompleted: {
            game.resetGame();
            game.isPlayBack = true;
        }
        onIsPlayBackChanged: {
            console.debug("isPlayBack:", game.isPlayBack);
            if(game.isPlayBack) {
                buzzers.playBackAni.start();
            }
        }

        yourScore {
            scoreIndex: 0
            onScoreChanged: {
                scores.state = "playerScored";
            }
            onScoreReset: {
                scores.state = "reset"
            }
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

   Scoring {
        id: scores
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: header.bottom

        gameInstance: game
   }

   Buzzers {
       id: buzzers
       anchors.bottom: parent.bottom
       anchors.topMargin: 25
       anchors.bottomMargin: 35
       anchors.horizontalCenter: parent.horizontalCenter

       gameInstance: game
   }
}
