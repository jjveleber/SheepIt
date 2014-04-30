import QtQuick 2.0

Text {
    FontLoader {
        id: myFont
        source: "qrc:/fonts/myfont"
    }

    font.family: myFont.name;
    font.pixelSize: 150 * (parent.width/1440)
}

