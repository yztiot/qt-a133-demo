import QtQuick 2.3
import QtQuick.Controls 2.3
import QtQml 2.0
GeneralBgPage{
    id: wifiRoot
    iconPath: "./src/iconNet"
    titleName: qsTr("以太网")
    property int nGetNetWorkInformation: 0
    property int nTest: 0


    function getIfconfig(){
           textEdit.text = InternetSetting.ifconfig()
    }

    Connections{
        target: InternetSetting
        /*
        function onPingSig(){
            editPing.text = editPing.text + InternetSetting.getPingStr()
        }
        */

        onPingSig:{
            editPing.text = editPing.text + InternetSetting.getPingStr()
        }
    }

    //获取网络信息按钮
    Image{
        id: btNetInf
        width: parent.width * 0.155  // 159 像素转换为相对于父项宽度的百分比 (1024 * 0.155)
        height: parent.height * 0.123  // 74 像素转换为相对于父项高度的百分比 (600 * 0.123)
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: parent.width * 0.0366  // 37 像素转换为相对于父项宽度的百分比 (1024 * 0.0366)
        anchors.topMargin: parent.height * 0.2633  // 158 像素转换为相对于父项高度的百分比 (600 * 0.2633)
        source: "./src/btNetInf"
        MouseArea{
            anchors.fill: parent
            onClicked: {
                if(nGetNetWorkInformation === 0){
                    nGetNetWorkInformation = 1;
                    btNetInf.source = "./src/btPause"
                 //   textEdit.clear()
                    textEdit === ""
                    getIfconfig();
                }else{
                    nGetNetWorkInformation = 0;
                    btNetInf.source = "./src/btNetInf"
                    InternetSetting.closeIfconfig();
                }
            }
        }
    }

    Rectangle {
        id: recPortStatus
        width: root.width * 0.734375  // 754 像素转换为相对于父项宽度的百分比 (1024 * 0.734375)
        height: root.height * 0.351667  // 211 像素转换为相对于父项高度的百分比 (600 * 0.351667)
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: root.height * 89/600 // 89 像素转换为相对于父项高度的百分比 (600 * 0.01483)
        anchors.leftMargin: root.width * 0.21875  // 228 像素转换为相对于父项宽度的百分比 (1024 * 0.21875)
        color: "#B2CEFF"
        opacity: 0.3
        radius: 10
    }
    Text {
        id: txtPortStatus
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: root.height * 0.0155  // 93 像素转换为相对于父项高度的百分比 (600 * 0.0155)
        anchors.leftMargin: root.width * 0.5547  // 565 像素转换为相对于父项宽度的百分比 (1024 * 0.5547)
        color: "white"
        font.pixelSize: 20
        text: qsTr("端口状态")
    }

    ScrollView {
        id: texteditview
        width: recPortStatus.width  // 使用与 recPortStatus 相同的宽度
        height: recPortStatus.height - root.height*0.05   // 减去 30 像素的高度
        anchors.horizontalCenter: recPortStatus.horizontalCenter  // 水平居中对齐 recPortStatus
        anchors.top: recPortStatus.top  // 顶部对齐 recPortStatus
        anchors.topMargin: root.height*0.05  // 顶部边距为 30 像素
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        ScrollBar.vertical.policy: ScrollBar.AlwaysOn
        clip: true

        Text {
            id: textEdit
            color: "white"
            focus: true
            font.pixelSize: 12
            renderType: Text.NativeRendering
            wrapMode: TextEdit.Wrap
        }
    }



    Rectangle {
        id: recLine
        width: parent.width * 0.91954  // 942 像素转换为相对于父项宽度的百分比 (1024 * 0.91954)
        height: 1  // 保持为 1 像素，因为这是一个细线
        color: "white"
        opacity: 0.42
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: parent.width * 0.03598  // 37 像素转换为相对于父项宽度的百分比 (1024 * 0.03598)
        anchors.topMargin: parent.height * 0.53167  // 319 像素转换为相对于父项高度的百分比 (600 * 0.53167)
    }
    Image {
        id: btTest
        width: parent.width * 0.15527  // 159 像素转换为相对于父项宽度的百分比 (1024 * 0.15527)
        height: parent.height * 0.12333  // 74 像素转换为相对于父项高度的百分比 (600 * 0.12333)
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: parent.width * 0.03598  // 37 像素转换为相对于父项宽度的百分比 (1024 * 0.03598)
        anchors.topMargin: parent.height * 0.69167  // 419 像素转换为相对于父项高度的百分比 (600 * 0.69167)
        source: "./src/btTest"
        MouseArea {
            anchors.fill: parent
            onClicked: {
                if(nTest === 0){
                    nTest = 1;
                    btTest.source = "./src/btPause"
                    editPing.text = ""
                    InternetSetting.ping();
                } else {
                    nTest = 0;
                    btTest.source = "./src/btTest"
                    InternetSetting.closePing();
                }
            }
        }
    }
    // 扫描结果矩形
    Rectangle {
        id: recScan
        width: parent.width * 0.734375  // 754 像素转换为相对于父项宽度的百分比 (1024 * 0.734375)
        height: parent.height * 0.351667  // 211 像素转换为相对于父项高度的百分比 (600 * 0.351667)
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: parent.height * 0.58333  // 350 像素转换为相对于父项高度的百分比 (600 * 0.58333)
        anchors.leftMargin: parent.width * 0.21875  // 228 像素转换为相对于父项宽度的百分比 (1024 * 0.21875)
        color: "#B2CEFF"
        opacity: 0.3
        radius: 10
    }

    // 扫描结果文本
    Text {
        id: txtScanResult
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: parent.height * 0.59  // 354 像素转换为相对于父项高度的百分比 (600 * 0.59)
        anchors.leftMargin: parent.width * 0.55208  // 565 像素转换为相对于父项宽度的百分比 (1024 * 0.55208)
        color: "white"
        font.pixelSize: 20
        text: qsTr("扫描结果")
    }

    ScrollView {
        id: pingview
        width: recScan.width  // 使用与 recScan 相同的宽度
        height: recScan.height - root.height*30/600  // 减去 30 像素的高度
        anchors.horizontalCenter: recScan.horizontalCenter  // 水平居中对齐 recScan
        anchors.top: recScan.top  // 顶部对齐 recScan
        anchors.topMargin: root.height*30/600   // 顶部边距为 30 像素
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        ScrollBar.vertical.policy: ScrollBar.AlwaysOn
        clip: true

        Text {
            id: editPing
            width: pingview.width  // 使用与 pingview 相同的宽度
            color: "white"
            font.pixelSize: 12
            renderType: Text.NativeRendering
            wrapMode: TextEdit.Wrap
        }
    }

}
