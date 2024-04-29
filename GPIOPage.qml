import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.0
import QtQml 2.0

GeneralBgPage{
    id: wifiRoot
    iconPath: "./src/iconGPIO"
    titleName: "GPIO"

    property int nLevel : 0
    //   property int iOModel: 0
    // 0:输入 1：输出
    property int nIO    : 1

    property string strName    : "gpio11"
    
    Connections{
        target: GPIO
        /*
        function onGpioSig(value){
            if(comeBackStateEdit.text === ""){
                comeBackStateEdit.text = value;
            }else{
                comeBackStateEdit.text = comeBackStateEdit.text + "\n" + value
            }
        }
        */
        onGpioSig:{
            if(comeBackStateEdit.text === ""){
                comeBackStateEdit.text = data;
            }else{
                comeBackStateEdit.text = comeBackStateEdit.text + "\n" + data
            }
        }
    }


    Rectangle{
        id: recGpio
        z:6
        width: root.width*150/1024
        height: root.height* 52/600
        anchors.left: parent.left
        anchors.leftMargin: root.width*200/1024
        anchors.top: parent.top
        anchors.topMargin: root.height* 100/600
        color: "#11234A"
        radius: 12
        DMenu{
            id: gpioMenu
            anchors.top:parent.top
            visible: false
            listHeight: root.height* 200/600
            showText: "PE3"
            model:["PE3", "PE4", "PE5", "PE6", "PE7", "PE8"]
        }
        Text {
            id: txtBaudChose
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: root.width*20/1024
            font.pixelSize: 18
            color: "white"
            text: qsTr(gpioMenu.showText)
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                    if(gpioMenu.visible){
                        gpioMenu.visible = false;
                    }else{
                        gpioMenu.visible = true;
                    }

            }
        }
    }

    Text {
        text: qsTr("选择GPIO口")
        anchors.right: recGpio.left
        anchors.rightMargin: root.width*50/1024
         anchors.verticalCenter: recGpio.verticalCenter
         color: "white"
         font.pixelSize: 18

    }


    //电平按钮
    Rectangle{
        id: btLevel
        width: root.width*159/1024
        height: root.height*74/600
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.leftMargin:  root.width*37/1024
        anchors.topMargin: root.height*177/600
        color: "transparent"
        Image {
            id: imgLevel
            anchors.fill: parent
            source: "./src/btLowLevel"
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if(nLevel == 0){
                        nLevel = 1;
                        imgLevel.source = "./src/btHeightLevel"
                        GPIO.setHighLowLevel(gpioMenu.showText, "0")
                    }else{
                        nLevel = 0;
                        imgLevel.source = "./src/btLowLevel"
                        GPIO.setHighLowLevel(gpioMenu.showText, "1")
                    }
                }
            }
        }
    }

    //IODirection按钮
    Rectangle{
        id: btIO
        width: root.width*159/1024
        height: root.height*74/600
        color: "transparent"
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.leftMargin: root.width*231/1024
        anchors.topMargin:  root.height*177/600
        Image {
            id: imgIO
            anchors.fill: parent
            source: "./src/btOutput"
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if(nIO == 0){
                        nIO = 1;
                        imgIO.source = "./src/btOutput"
                        GPIO.setIODirection(gpioMenu.showText, "in")
                    }else{
                        nIO = 0;
                        imgIO.source = "./src/btInput"
                        GPIO.setIODirection(gpioMenu.showText, "out")
                    }
                }
            }
        }
    }

    Rectangle {
        id: recPortStatus
        width: root.width * 0.5195  // 530 像素转换为相对于 root.width 的百分比（假设 root.width 为 1024 像素）
        height: root.height * 0.2728  // 211 像素转换为相对于 root.height 的百分比（假设 root.height 为 768 像素）
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: root.height * 0.1157  // 89 像素转换为相对于 root.height 的百分比（假设 root.height 为 768 像素）
        anchors.leftMargin: root.width * 0.4422  // 452 像素转换为相对于 root.width 的百分比（假设 root.width 为 1024 像素）
        color: "#B2CEFF"
        opacity: 0.3
        radius: 10
    }
    Text {
        id: txtPortStatus
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: root.height * 0.1209  // 93 像素转换为相对于 root.height 的百分比（假设 root.height 为 768 像素）
        anchors.leftMargin: root.width * 0.6617  // 677 像素转换为相对于 root.width 的百分比（假设 root.width 为 1024 像素）
        color: "white"
        font.pixelSize: 20
        text: qsTr("端口状态")
    }

    Rectangle {
        id: texteditRec
        width: root.width * 0.5076  // 520 像素转换为相对于 root.width 的百分比（假设 root.width 为 1024 像素）
        height: root.height * 0.2101  // 161 像素转换为相对于 root.height 的百分比（假设 root.height 为 768 像素）
        anchors.top: txtPortStatus.top  // 假设 txtPortStatus 的 top 边距已经是百分比形式
        anchors.left: parent.left
        anchors.topMargin: root.height * 0.0526  // 40 像素转换为相对于 root.height 的百分比（假设 root.height 为 768 像素）
        anchors.leftMargin: root.width * 0.4525  // 462 像素转换为相对于 root.width 的百分比（假设 root.width 为 1024 像素）
        color: "transparent"
        ScrollView {
            id: texteditview
            width: texteditRec.width  // 使用父项的宽度
            height: texteditRec.height  // 使用父项的高度
            anchors.left: parent.left
            anchors.top: parent.top
            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
            ScrollBar.vertical.policy: ScrollBar.AlwaysOn
            clip: true
            Text {
                id: comeBackStateEdit
                width: texteditview.width  // 与父项宽度一致
                color: "white"
                renderType: Text.NativeRendering
                wrapMode: TextEdit.Wrap
            }
        }
    }

    Rectangle {
        id: recLine
        width: root.width * 0.9195  // 942 像素转换为相对于 root.width 的百分比（假设 root.width 为 1024 像素）
        height: 1  // 保持为 1 像素，因为这是一个细线
        color: "white"
        opacity: 0.42
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: root.width * 0.0363  // 37 像素转换为相对于 root.width 的百分比（假设 root.width 为 1024 像素）
        anchors.topMargin: root.height * 0.45  // 319 像素转换为相对于 root.height 的百分比（假设 root.height 为 768 像素）
    }

    Image {
        id: iconScan
        width: root.height * 0.0328  // 25 像素转换为相对于 root.height 的百分比（假设 root.height 为 768 像素）
        height: root.height * 0.0328  // 25 像素转换为相对于 root.height 的百分比（假设 root.height 为 768 像素）
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: root.width * 0.0363  // 37 像素转换为相对于 root.width 的百分比（假设 root.width 为 1024 像素）
        anchors.topMargin: root.height * 0.4826  // 371 像素转换为相对于 root.height 的百分比（假设 root.height 为 768 像素）
        source: "./src/iconScan"
    }

    Text {
        id: txtScan
        anchors.verticalCenter: iconScan.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: root.width * 0.0707  // 73 像素转换为相对于 root.width 的百分比（假设 root.width 为 1024 像素）
        font.pixelSize: 24  // 保持字体大小不变
        color: "white"
        text: qsTr("扫描")
    }

    // I2C1 按钮
    Rectangle {
        id: btI2C1
        width: root.width * 0.1554  // 159 像素转换为相对于 root.width (1024 像素) 的百分比
        height: root.height * 0.1233  // 74 像素转换为相对于 root.height (600 像素) 的百分比
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.leftMargin: root.width * 0.0363  // 37 像素转换为相对于 root.width 的百分比
        anchors.topMargin: root.height * 0.7117  // 427 像素转换为相对于 root.height 的百分比
        color: "transparent"
        Image {
            id: imgI2C1
            anchors.fill: parent
            source: "./src/btI2C1"
            MouseArea {
                anchors.fill: parent
                onPressed: {
                    btI2C1.opacity = 0.5
                }
                onReleased: {
                    btI2C1.opacity = 1
                    scanStateEdit.text += I2C.checkI2C("i2c-1") + "\n"
                }
            }
        }
    }
    // I2C0 按钮
    Rectangle {
        id: btI2C0
        width: root.width * 0.1554  // 159 像素转换为相对于 root.width (1024 像素) 的百分比
        height: root.height * 0.1233  // 74 像素转换为相对于 root.height (600 像素) 的百分比
        color: "transparent"
        radius: 8
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.leftMargin: root.width * 0.2285  // 231 像素转换为相对于 root.width 的百分比
        anchors.topMargin: root.height * 0.7117  // 427 像素转换为相对于 root.height 的百分比
        Image {
            id: imgI2C0
            anchors.fill: parent
            source: "./src/btI2C0"
            MouseArea {
                anchors.fill: parent
                onPressed: {
                    btI2C0.opacity = 0.5
                }
                onReleased: {
                    btI2C0.opacity = 1
                    scanStateEdit.text += I2C.checkI2C("i2c-0") + "\n"
                }
            }
        }
    }

    // 扫描结果
    Rectangle {
        id: recScan
        width: root.width * 0.5195  // 530 像素转换为相对于 root.width 的百分比
        height: root.height * 0.3517  // 211 像素转换为相对于 root.height 的百分比
        color: "#B2CEFF"
        opacity: 0.3
        radius: 10
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: root.height * 0.5833  // 350 像素转换为相对于 root.height 的百分比
        anchors.leftMargin: root.width * 0.4525  // 452 像素转换为相对于 root.width 的百分比
    }

    Text {
        id: txtScanResult
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: root.height * 0.59  // 354 像素转换为相对于 root.height 的百分比
        anchors.leftMargin: root.width * 0.6625  // 677 像素转换为相对于 root.width 的百分比
        color: "white"
        font.pixelSize: 20
        text: qsTr("扫描结果")
    }

    Rectangle {
        id: scantxtRec
        width: root.width * 0.5078  // 520 像素转换为相对于 root.width 的百分比
        height: root.height * 0.2675  // 161 像素转换为相对于 root.height 的百分比
        anchors.top: txtScanResult.top  // 假设 txtScanResult 的 top 边距已经是百分比形式
        anchors.left: parent.left
        anchors.topMargin: root.height * 0.0667  // 40 像素转换为相对于 root.height 的百分比
        anchors.leftMargin: root.width * 0.4525  // 462 像素转换为相对于 root.width 的百分比
        color: "transparent"
        ScrollView {
            id: scanTexteditview
            width: scantxtRec.width  // 使用父项的宽度
            height: scantxtRec.height  // 使用父项的高度
            anchors.left: parent.left
            anchors.top: parent.top
            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
            ScrollBar.vertical.policy: ScrollBar.AlwaysOn
            clip: true
            Text {
                id: scanStateEdit
                width: scanTexteditview.width  // 与父项宽度一致
                color: "white"
                renderType: Text.NativeRendering
                wrapMode: TextEdit.Wrap
            }
        }
    }


}
