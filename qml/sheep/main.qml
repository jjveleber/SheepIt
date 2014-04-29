import Game 1.0
import Score 1.0
import QtQuick 2.2
import QtQuick.Layouts 1.1
import QtQuick.Particles 2.0


Rectangle {
    width: 1440
    height: 1080

    focus: true;
    Keys.onPressed: { if (event.key === Qt.Key_Escape) Qt.quit(); }

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
   }

   Buzzers {
       id: buzzers
       anchors.bottom: parent.bottom
       anchors.topMargin: 25
       anchors.bottomMargin: 50
       anchors.horizontalCenter: parent.horizontalCenter
   }
}
