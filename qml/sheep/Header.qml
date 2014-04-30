import QtQuick 2.0

Item {
    height: childrenRect.height
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

    SheepText {
        id:sheepItLable
        color: "#fffee4"
        text: "Sheep It!"
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: 100
    }

}
