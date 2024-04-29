import QtQuick 2.12
import Qt.labs.platform 1.1
import QtQuick.Controls 2.12
import QtQml 2.0
//import QtQuick.VirtualKeyboard 2.15

GeneralBgPage{
    id: wifiRoot
    iconPath: "./src/iconSerial"
    titleName: qsTr("串口测试")

    Rectangle{
        z:10
        id: baseSettingRec
        width: root.width*312/1024
        height: root.height*314/600
        anchors.left: parent.left
        anchors.top:parent.top
        anchors.leftMargin: root.width*37/1024
        anchors.topMargin: root.height*84/600
        color: "transparent"
        radius: 12
        property bool bOpenSerial: false

        Connections{
            target: SerialFunction

            onSerialDataSig:{
                comeBackStateEdit.text = comeBackStateEdit.text +"\n"+  data
             //   comeBackStateEdit.persistentSelection = true;
            }
            onWriteSig:{
                comeBackStateEdit.text = comeBackStateEdit.text +"\n"+  data
            }
            onOpenSerialSuccessful:{
                serialModel.bOpen = true;
                baseSettingRec.bOpenSerial = true;
                serialModel.btSource =  "./src/btCloseSerial"
                comeBackStateEdit.text = comeBackStateEdit.text +"\n"+  serialName

            }
            onOpenSerialFail:{
                serialModel.bOpen = false;
                baseSettingRec.bOpenSerial = false;
                serialModel.btSource =  "./src/btOpenSerial"
                comeBackStateEdit.text = comeBackStateEdit.text +"\n"+  info
            }

            onTipSig:{
                comeBackStateEdit.text = comeBackStateEdit.text +"\n"+  tip
            }
        }

        Rectangle{
            anchors.fill: parent
            color: "#82CEFF"
            opacity: 0.23
            radius: 12
        }

        Text {
            id: txtBaud
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: root.width*34/1024
            anchors.topMargin:  root.height*41/600
            font.pixelSize: root.height*18/600
            color: "white"
            text: qsTr("波特率")
        }

        Rectangle{
            id: recBaud
            z:6
            width: root.width*150/1024
            height: root.height*52/600
            anchors.verticalCenter: txtBaud.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: root.width*118/1024
            color: "#11234A"
            radius: 12
            DMenu{
                id: baudMenu
                anchors.top: recBaud.bottom
                visible: false
                listHeight: root.height*250/600
                showText: "9600"
                model:[1200, 2400, 4800, 9600, 19200, 38400, 57600, 115200]
            }
            Text {
                id: txtBaudChose
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin:  root.width*20/1024
                font.pixelSize: root.height*18/600
                color: "white"
                text: qsTr(baudMenu.showText)
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if(baseSettingRec.bOpenSerial){
                        baudMenu.visible = false;
                    }else{
                        if(baudMenu.visible){
                            baudMenu.visible = false;
                        }else{
                            baudMenu.visible = true;
                        }
                    }
                }
            }
        }

        Text {
            id: txtBit
            anchors.left: txtBaud.left
            anchors.top: parent.top
            anchors.topMargin:  root.height*110/600
            font.pixelSize: root.height*18/600
            color: "white"
            text: qsTr("数据位")
        }

        Rectangle{
            id: recBit
            width: root.width*150/1024
            height: root.height*52/600
            z:5
            anchors.verticalCenter: txtBit.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: root.width*118/1024
            color: "#11234A"
            radius: 12
            DMenu{
                id: bitMenu
                anchors.top: recBit.bottom
                visible: false
                listHeight: 120
                showText: "8"
                model:[5, 6, 7, 8]
            }

            Text {
                id: txtBitChose
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin:  root.width*20/1024
                font.pixelSize: root.height*18/600
                color: "white"
                text: qsTr(bitMenu.showText)
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if(baseSettingRec.bOpenSerial){
                        bitMenu.visible = false;
                    }else{
                        if(bitMenu.visible){
                            bitMenu.visible = false;
                        }else{
                            bitMenu.visible = true;
                        }
                    }
                }
            }


        }

        Text {
            id: txtCheck
            anchors.left: txtBaud.left
            anchors.top: parent.top
            anchors.topMargin: root.height*179/600
            font.pixelSize: root.height*18/600
            color: "white"
            text: qsTr("校验位")
        }

        Rectangle{
            id: recCheck
            width: root.width*150/1024
            height: root.height*52/600
            z:4
            anchors.verticalCenter: txtCheck.verticalCenter
            anchors.left: parent.left
         anchors.leftMargin: root.width*118/1024
            color: "#11234A"
            radius: 12
            DMenu{
                id: checkMenu
                anchors.top: recCheck.bottom
                visible: false
                listHeight: 150
                showText: "None"
                model:["None", "Odd", "Eyen Mark", "Space"]
            }
            Text {
                id: txtCheckChoose
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: root.width*20/1024
                font.pixelSize: root.height*18/600
                color: "white"
                text: qsTr(checkMenu.showText)
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if(baseSettingRec.bOpenSerial){
                        checkMenu.visible = false;
                    }else{
                        if(checkMenu.visible){
                            checkMenu.visible = false;
                        }else{
                            checkMenu.visible = true;
                        }
                    }
                }
            }


        }

        Text {
            id: txtStop
            anchors.left: txtBaud.left
            anchors.top: parent.top

            anchors.topMargin: root.height*250/600
            font.pixelSize: root.height*18/600
            color: "white"
            text: qsTr("停止位")
        }

        Rectangle{
            id: recStop
             width: root.width*150/1024
             height: root.height*52/600
            z:3
            anchors.verticalCenter: txtStop.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin:  root.width*118/1024
            color: "#11234A"
            radius: 12
            DMenu{
                id: stopMenu
                anchors.top: recStop.bottom
                visible: false
                listHeight: 100
                showText: "1"
                model:[1, 1.5, 2]

            }
            Text {
                id: txtStopChose
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin:  root.width*20/1024
                font.pixelSize: root.height*18/600
                color: "white"
                text: qsTr(stopMenu.showText)
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if(baseSettingRec.bOpenSerial){
                        stopMenu.visible = false;
                    }else{
                        if(stopMenu.visible){
                            stopMenu.visible = false;
                        }else{
                            stopMenu.visible = true;
                        }
                    }
                }
            }


        }

    }

    Rectangle{
        id:settingMask
        width: baseSettingRec.width
        height: baseSettingRec.height
        color: "black"
        opacity: 0.4
        visible: false
        z: 999
        anchors.left: baseSettingRec.left
        anchors.top: baseSettingRec.top
        MouseArea{
            anchors.fill: parent
        }
    }

    //模式485/232选择模式框
    Rectangle{
        id: modelRec
        width: root.width*312/1024
        height: root.height*164/600
        anchors.left: parent.left
        anchors.top:parent.top
        anchors.leftMargin: root.width*37/1024
        anchors.topMargin:  root.height*406/600
        color: "transparent"
        radius: 12
        Rectangle{
            anchors.fill: parent
            color: "#82CEFF"
            radius: 12
            opacity: 0.23
        }

        SerialModelPage{
            id: serialModel
        }

    }

    //返回状态框
    Rectangle{
        id: stateRec
        width: root.width*630/1024
        height: root.height*243/600
        anchors.left: parent.left
        anchors.top:parent.top
        anchors.leftMargin:  root.width*357/1024
        anchors.topMargin: root.height*84/600
        color: "transparent"
        radius: 12
        Rectangle{
            anchors.fill: parent
            color: "#82CEFF"
            radius: 12
            opacity: 0.23
        }

        Text {
            id: txtState
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 10
            color:"white"
            font.pixelSize: 20

            text: qsTr("状态")
        }

        ScrollView {
            id: textedit_1_view
            width: root.width*600/1024
            height: root.height*200/600
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.top: txtState.bottom
            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
            ScrollBar.vertical.policy: ScrollBar.AlwaysOn
            clip: true

            Text{
                id: comeBackStateEdit
                width: textedit_1_view.width
                color: "white"
                //鼠标选取文本默认为false
                //selectByMouse: true
                //键盘选取文本默认为true
                //selectByKeyboard: true
                //选中文本的颜色
                //selectedTextColor: "white"
                //选中文本背景色
                //selectionColor: "black"
                //截取超出部分
                //clip: true
                //默认Text.QtRendering看起来比较模糊
                renderType: Text.NativeRendering
                //文本换行，默认NoWrap
                wrapMode: TextEdit.Wrap
            }
        }

    }

    //键盘框
    Rectangle{
        id: keyBoardec
        width: root.width*630/1024
        height: root.height*235/600
        anchors.left: parent.left
        anchors.top:parent.top
        anchors.leftMargin:  root.width*357/1024
        anchors.topMargin: root.height*335/600
        color: "transparent"
        radius: 12
        Rectangle{
            anchors.fill: parent
            color: "#82CEFF"
            radius: 12
            opacity: 0.23
        }

        KeyBoardPage{
            id: keyboard
        }

    }

}
