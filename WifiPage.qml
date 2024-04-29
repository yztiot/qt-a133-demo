import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQml 2.0

GeneralBgPage{
    id: wifiRoot
    iconPath: "./src/iconWifi"
    titleName: "WiFi"
    property string stateText: "未打开"

    //nState: 0为关闭wifi或蓝牙，1为开启wifi或蓝牙
    property bool nState:false
    property string strFontFamily: ""
    property var wifiNameList
    property int currentChooseWifi: 0

    Component.onCompleted: {

        console.log("height::" + Math.ceil( wifiBluetoothList.height * 0.4))
        nState = WiFi.getWifiCurrentState();
        if(!nState){
            imgOpenWifi.source = "./src/btSlideOff"
            txtState.text = "未打开"
            WiFi.setWifiCurrentState(false)
            wifiBluetoothList.visible = false
        }else{
            imgOpenWifi.source= "./src/btSlideOn"
            txtState.text = "已打开"
            WiFi.setWifiCurrentState(true)
            wifiBluetoothList.visible = true


           // var wifiNameList;
            wifiNameList = WiFi.getWifiNameList()
            listModel.clear()
            for(var i = 0; i < wifiNameList.length; i++ ){
                listModel.append({
                                     name: wifiNameList[i],
                                     loadVisible: false
                                 })
            }
        }
    }

    function onWaitingSig(){
        console.log("on loading::"+ index +"::"+ wifiBluetoothList.currentIndex);
    }

    Connections{
        target: WiFi

        onWifiNameQml:{
            wifiNameList = ""
            wifiNameList = name
            listModel.clear()
            for(var i = 0; i < wifiNameList.length; i++ ){
                listModel.append({
                                     name: wifiNameList[i],
                                     loadVisible: false
                                 })
            }
        }

        onConnectCurrentNameSig:{
            txtConnect.text = name//"已连接"
            listModel.clear()
            for(var i = 0; i < wifiNameList.length; i++ ){
                listModel.append({
                                     name: wifiNameList[i],
                                     loadVisible: false
                                 })
            }
        }

        onDisCurrentWifiSigQml:{
            listModel.set(currentChooseWifi, {loadVisible: false})
            txtConnect.text = qsTr("未连接")
            listModel.clear()
        }
    }

    Connections{
        target: connectTip

        onWaitingSig:{
            console.log("waiting current::"+ currentChooseWifi)
         //   listModel.set(currentChooseWifi, {"loadVisible": false})
            listModel.clear()
            for(var i = 0; i < wifiNameList.length; i++ ){
                listModel.append({
                                     name: wifiNameList[i],
                                     loadVisible: false
                                 })
            }

        }
    }

    Text {
        id: txtState
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin:  Math.ceil(parent.height*0.15)
        anchors.leftMargin:  Math.ceil(parent.width*0.0361)
        color: "white"
        font.family: strFontFamily
        font.pixelSize: 23
        text: qsTr(stateText)
    }

    /* 蓝牙或wifi打开关闭按钮 */
    Rectangle{
        id: btOpen
        width: Math.ceil(parent.width*0.0596)
        height:  Math.ceil(parent.height*0.0567)

        anchors.verticalCenter: txtState.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin:  Math.ceil(parent.width*0.141)
        color: "transparent"

        Image {
            id: imgOpenWifi
            anchors.fill: parent
            source: "./src/btSlideOff"
        }

        MouseArea{
            anchors.fill: parent
            onClicked: {
                nState = WiFi.getWifiCurrentState();
                if(!nState){
                    imgOpenWifi.source= "./src/btSlideOn"
                    txtState.text = "已打开"
                    WiFi.setWifiCurrentState(true)
                    wifiBluetoothList.visible = true
                //    waittingPage.visible = true
                //    WiFi.runScanWiFi();
                    WiFi.scanWiFi();
                }else{
                    imgOpenWifi.source = "./src/btSlideOff"
                    txtState.text = "未打开"
                    WiFi.setWifiCurrentState(false)
                    wifiBluetoothList.visible = false
                    WiFi.closeWiFi()
                }
            }
        }
    }

    ScrollView {
        id: scanTexteditview
        width:  root.width * 0.98
        height:  root.height / 1.3
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin:  Math.ceil(parent.width*0.0391)
        anchors.topMargin:  Math.ceil(parent.height*0.23)
        clip: true
        Rectangle{
            id: currentWifiBg
            width:  Math.ceil(root.width* 0.92)
            height:  Math.ceil(root.height/ 7)
            color:"#B2CEFF"
            opacity: 0.23
            radius: 12
        }

        Rectangle{
            width:  Math.ceil(root.width* 0.92)
            height:  Math.ceil(root.height/ 7)
         //   color: "#31447B"
            color:"transparent"
            radius: 5
            Image{
                id: smallWifiImg

                width:  Math.ceil(parent.width*0.0244)
                height:  width
                source: "./src/iconSmallWiFi"
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 29
            }
            Text {
                id: txtConnect
                anchors.verticalCenter: parent.verticalCenter
                color: "white"
                font.pixelSize: 26
                anchors.left: parent.left
                anchors.leftMargin: root.height * 0.11
                text: qsTr("未连接")
            }

        }

        Text{
            id: txtOtherDev
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.topMargin:  128
            color: "white"

            text: "其他设备"

        }

        ListView{
            id: wifiBluetoothList
            spacing: 10
            clip: true
            anchors.top: txtOtherDev.bottom
            anchors.topMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width
            height:  root.height * 0.45
            model:listModel
            delegate: Rectangle{
                id: wifiDelegateRoot
                property variant mymodel: model
                Rectangle{
                    id: listViewBg
                    width:   Math.ceil(root.width* 0.92)
                    height:  Math.ceil(root.height / 7)
                    color:"#B2CEFF"
                    opacity:0.23
                    radius: 12
                }

                width:  Math.ceil(root.width* 0.92)
                height:  Math.ceil( root.height / 7)
                color:"transparent"
                radius: 5

                Image{
                    id: listSmallWifiImg
                    width:  height
                    height: root.height/ 24
                    source: "./src/iconSmallWiFi"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 29
                }

                Text {
                    id: txtDisConnect
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin:  root.height * 0.11
                    color: "white"
                    font.pixelSize: 26
                    text: qsTr(name)
                }

                Image {
                    id: loadingImg
                    width:  height
                    height: root.height/ 17
                    anchors.right: parent.right
                    anchors.rightMargin: 28//parent.width*0.0273
                    anchors.verticalCenter: parent.verticalCenter

                    source: "./src/loading"
                    transformOrigin: Item.Center // 设置变换中心为图像中心点
                    visible: loadVisible

                    RotationAnimator {
                        target: loadingImg // 动画目标为Image组件
                        duration: 2000 // 动画持续时间1秒
                        from: 0 // 起始角度为0度
                        to: 360 // 结束角度为360度，即一圈完整的旋转
                        loops: Animation.Infinite // 循环播放动画
                        running: true // 启动动画
                    }
                }

                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        connectTip.showDel = false;
                        connectTip.tipModel = 3
                        connectTip.titleName = "输入密码"
                        connectTip.smallTip = wifiNameList[index]
                        connectTip.visible = true
                        loadingImg.visible = true
                        currentChooseWifi = index;
                        listModel.set(index, {loadVisible: true})
                    }
                }
            }
        }
        ListModel{
            id: listModel
        }
    }

    TipRectangle{
        id:connectTip
        visible: false
    }

}
