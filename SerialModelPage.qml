import QtQuick 2.12

Rectangle {
    id: serialModelRoot
    width: parent.width
    height: parent.height
    color:"transparent"

    //nSerialModel 0表示485 1表示232
    property int nSerialModel: 0
    property bool bOpen: false
    property alias btSource: btOpenSerial.source

    DRadioButton{
       id: bt485
       checked: true
       anchors.top: parent.top
       anchors.left: parent.left
       anchors.topMargin: root.height*30/600
       anchors.leftMargin: root.width*27/1024
      // anchors.leftMargin: 10
       txt:"RS485"
       font.pixelSize:  root.height*16/600
       onClicked: {
           settingMask.visible = false
            nSerialModel = 0;
       }
   }

    DRadioButton{
        id: bt232
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: root.height*30/600
        anchors.leftMargin: root.width*174/1024
       // anchors.leftMargin: 110
        txt:"RS232"
        font.pixelSize: root.height*16/600
        onClicked: {
            settingMask.visible = false
            nSerialModel = 1;
        }
    }



   //串口按钮
    Image {
        id: btOpenSerial
         width: root.width*95/1024
         height: root.height*38/600
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: root.width*30/1024
        anchors.topMargin: root.height*100/600
        source: "./src/btOpenSerial"
        MouseArea{
            anchors.fill: parent
            onClicked: {
                //判断是否打开串口通讯
                if(!bOpen){
                    if(nSerialModel === 2){
                        SerialFunction.runOpenSerial()
                    }else{
                        SerialFunction.setSerialModel(nSerialModel)
                        SerialFunction.runOpenSerial(baudMenu.showText, bitMenu.showText, checkMenu.showText, stopMenu.showText)
                    }
                }else{
                    bOpen = false;
                    baseSettingRec.bOpenSerial = false
                    btOpenSerial.source =  "./src/btOpenSerial"
                    SerialFunction.closeSerial();
                }
            }
        }
    }

    //清屏按钮
    Image {
        id: btCleanUp
        width: root.width*95/1024
        height: root.height*38/600
        anchors.left: parent.left
        anchors.top: btOpenSerial.top
        anchors.leftMargin: root.width*180/1024

        source: "./src/btCleanUp"
        MouseArea{
            anchors.fill: parent
            onPressed:{
                btCleanUp.source = "./src/btCleanUpPress"
            }
            onReleased: {
                btCleanUp.source = "./src/btCleanUp"
                comeBackStateEdit.text = ""
            }
        }
    }
}
