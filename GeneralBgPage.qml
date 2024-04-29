import QtQuick 2.12
import QtQml 2.0
Rectangle{
    id: bgRoot
    //    width: parent.width
    //    height: parent.height
    width: root.width
    height: root.height

    property string titleName: ""
    property string iconPath: ""

    signal destroySig();

    //屏蔽穿透点击
    MouseArea{
        anchors.fill: parent
    }

    Component.onCompleted: {
        timer.start();
    }

    Connections{
        target: SystemSetting
        /* qt 5.15用这种方式响应信号
        function onUpdateTimeSig(){
            showTime.text = currentDateTime();
        }
        */

        /*qt 5.12.12 用这种方式*/
        onUpdateTimeSig:{
            showTime.text = ""
            showTime.text = currentDateTime();
        }
    }

    Image {
        id: imgBg
        anchors.fill: parent
        source: "./src/secondBg"
    }

    Rectangle{
        id: recTurnLeft
        width: root.width*0.0684
        height: root.height/10
        anchors.left: parent.left
        anchors.top: parent.top
        color: "transparent"
        Image {
            id: imgTurnLeft
            width: root.width*0.0332
            height: root.height*0.0567
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            // anchors.centerIn: parent
            source: "./src/turnLeft"

        }
        MouseArea{
            id: destroyMouse
            anchors.fill: parent
            onClicked: {
                console.log("destory page")
                bgRoot.destroySig()
                bgRoot.destroy();
            }
        }
    }

    Rectangle{
        id: recTitleIcon
        width: root.width*0.0586
        height:root.height*0.1
        anchors.verticalCenter: recTurnLeft.verticalCenter
        anchors.left: recTurnLeft.right
        color: "transparent"
        Image {
            id: titleIcon
            width: root.width*0.0332
            height: root.height*0.0567
            anchors.centerIn: parent
            source: iconPath
        }
    }

    Text {
        id: titleNameText
        anchors.verticalCenter: recTitleIcon.verticalCenter
        anchors.left: recTitleIcon.right
        anchors.leftMargin: root.width*0.01
        text: titleName
        color: "white"
        font.pixelSize: 28
    }


    // 判断时间是否小于10
    function addZero(zero){
        if(zero < 10)
            return "0"+zero;
        else
            return zero;
    }

    //获取时间字符;
    function currentDateTime(){
        var ti = new Date;
        var strDateBG = "";
        switch(ti.getDay()){
        case 1: strDateBG = qsTr("周一"); break;
        case 2: strDateBG = qsTr("周二"); break;
        case 3: strDateBG = qsTr("周三"); break;
        case 4: strDateBG = qsTr("周四"); break;
        case 5: strDateBG = qsTr("周五"); break;
        case 6: strDateBG = qsTr("周六"); break;
        default : strDateBG = qsTr("周日") ;

        };

        var year = ti.getFullYear();
        var mon  = addZero(ti.getMonth() + 1);
        var day  = addZero(ti.getDate());
     //   if()
        var hh   = addZero(ti.getHours() + 8);
        var mm   = addZero(ti.getMinutes());
        if(hh > 23){
           hh = "0" +  (hh - 24).toString()
        }

        console.log("time::"+ ti+ "::" + hh+ "::"+ ti.getHours());

        strDateBG = strDateBG+ "     "+ year+ "/"+ mon+ "/"+ day+ "    "+ hh+ ": "+ mm ;

        return strDateBG;
    }

    Timer{
        id: timer
        repeat: true
        interval: 60000
        onTriggered: {
            showTime.text = currentDateTime();
        }
    }

    //显示时间
    Text {
        id: showTime
        anchors.left: parent.left
        anchors.leftMargin: root.width*0.75
        anchors.verticalCenter: recTurnLeft.verticalCenter
        color: "white"
        font.pixelSize: 18
        text: currentDateTime()
    }

        // width: root.width*312/1024
        // height: root.height*314/600
}
