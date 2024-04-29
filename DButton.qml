import QtQuick 2.12

//自定义主页按钮
Rectangle {
    id:buttonRoot
    width: root.width*0.0644;
    height: root.width*0.0644;
    color: "transparent";
    property int imageWidth: root.width*0.0644/2
    property int imageHeight: root.width*0.0644/2
    property string btName: ""
    property string btNameColor: "white"
    property string sourcePath: ""
    Image{
        id: btImage
        width: imageWidth
        height: imageHeight
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin:root.width*0.0644/20
        source: sourcePath
    }

    Text {
        id: txtName
        text: qsTr(btName)
        color: btNameColor
        anchors.horizontalCenter: btImage.horizontalCenter
        anchors.top: btImage.bottom
        font.pixelSize: 19
        font.family: ""
    }

}
