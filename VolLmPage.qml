import QtQuick 2.12
import QtQuick.Controls 2.3
import QtQml 2.0

Rectangle{
    id: recLight
    anchors.top: parent.top
    width: root.width*945/1024
    height:  root.height*84/600
    color: "transparent"
    anchors.horizontalCenter: parent.horizontalCenter
    property string strName: ""
    property string logoPath: ""
    property string minPath: ""
    property string maxPath: ""
    //1: backlight  2: vol
    property int    model: 0
    property bool firstInit: true

    Component.onCompleted: {
        firstInit = false
        if(model==1)
        {
            slider.value = SystemSetting.getSysLight() / 100;
        }


    }

    Rectangle{
        anchors.fill: parent
        radius: 12
        opacity: 0.23
        color: "#B2CEFF"
    }

    Image {
        id: imgLogop
        width: 25
        height:  25

        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin:  root.width*29/1024

        source: logoPath
    }


    Text {
        id: lmText
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin:  root.width*66/1024
        font.pixelSize: 26

        text: qsTr(strName)
        color: "white"

    }

    Text {
        id: sliderValue

        text: qsTr(((slider.value * 100).toFixed(0)).toString()  + "%")
        color: "white"

        anchors.left: parent.left
        anchors.verticalCenter:parent.verticalCenter
        anchors.leftMargin:  root.width*420/1024
        font.pixelSize: 26
        onTextChanged: {
            var value = ((slider.value * 100).toFixed(0)).toString()
            if(model == 1){
                if(value < 10){
                    value = 5;
                }
                if(firstInit){

                }else{
                    SystemSetting.setSysLight(value)
                }
            }else if(model == 2){
              //  Sound.setSound(value)
                soundPlay.volume = value / 100
            }else{

            }

        }
    }

    Image{
        id: min
        width: 24
        height:  24
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin:    root.width*508/1024
        source: minPath

    }

    Slider{
        id: slider
        value: 0.5
        width:   root.width*314/1024
      //  height: 43
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin:   root.width*549/1024

        background: Rectangle{
            x: slider.leftPadding
            y: slider.topPadding + slider.availableHeight / 2 - height /2
            implicitHeight: 5
            implicitWidth: 200
            width: slider.availableWidth
            height:4 //implicitHeight
            radius: height/2
            color: "#bdbebf"

            Rectangle{
                width: slider.visualPosition * parent.width
                height: parent.height
                color: "#0080FF"
                radius: height / 2
            }
        }

        handle:Rectangle{
            x: slider.leftPadding + slider.visualPosition * (slider.availableWidth - width)
            y: slider.topPadding + slider.availableHeight / 2 - height / 2
            implicitWidth: 36//26
            implicitHeight: 36//26
            radius: 18//3
            color: slider.pressed? "#f0f0f0" : "#f6f6f6"
            border.color: "#bdbefb"
        }

    }

    Image{
        id: max
        width: 24
        height: 24
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: root.width*871/1024
        source: maxPath

    }


}
