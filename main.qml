import QtQuick 2.12
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQml 2.0
//import QtQuick.VirtualKeyboard 2.1

Window {
    id: root
//    width: Screen.width//Screen.desktopAvailableWidth
//    height: Screen.height//Screen.desktopAvailableHeight
    width: 1024//Screen.desktopAvailableWidth
    height: 600//Screen.desktopAvailableHeight
    visible: true
    title: qsTr("Demo")
    
    Component.onCompleted: {
        timer.start();

    }

    Connections {

        target: SystemSetting
        onScreenSaveSig:{
            screenSaveimg.visible = true
        }

        onUpdateTimeSig:{
            showTime.text = currentDateTime();
        }
    }

    Image {
        id: screenSaveimg
        width: parent.width
        height: parent.height
        visible: true
        z:99
        source: "./src/introducePage"
      //  source: "./src/a2.png"
        MouseArea{
            anchors.fill: parent
            onClicked: {
                screenSaveimg.visible = false;
            }
        }
    }

    // 判断时间是否小于10
    function addZero(zero){
        if(zero < 10){
            return "0"+zero;
        }
        else{
            return zero;
        }
    }

    //获取时间字符;
    function currentDateTime(){

        var ti = new Date;
        var strDateMain = "";
        switch(ti.getDay()){
        case 1: strDateMain = qsTr("周一"); break;
        case 2: strDateMain = qsTr("周二"); break;
        case 3: strDateMain = qsTr("周三"); break;
        case 4: strDateMain = qsTr("周四"); break;
        case 5: strDateMain = qsTr("周五"); break;
        case 6: strDateMain = qsTr("周六"); break;
        default : strDateMain = qsTr("周日") ;

        };

        var year = ti.getFullYear();
        var mon  = addZero(ti.getMonth() + 1);
        var day  = addZero(ti.getDate() );
        var hh   = addZero(ti.getHours()+ 8);
        var mm   = addZero(ti.getMinutes());

        if(hh > 23){
           hh =  "0" + (hh - 24).toString()
        }

        strDateMain = strDateMain+ "     "+ year+ "/"+ mon+ "/"+ day+ "    "+ hh+ ": "+ mm ;
        return strDateMain;
    }

    Timer{
        id: timer
        repeat: true
        interval: 60000
        onTriggered: {
            showTime.text = currentDateTime();
        }
    }

    Rectangle{
        id: rootRec
        width: parent.width
        height: parent.height

        //背景图
        Image {
            id: rootbg
            anchors.fill: parent
            source: "./src/mainBg"
        }

        //logo图
        Image {
            id: rootLogo
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.topMargin:parent.height/60 
            anchors.leftMargin: parent.width*0.059
            source: "./src/logo"
            MouseArea{
                anchors.fill: parent
                onClicked: {
                }
            }
        }

        Text {
            id: yztiotName
            anchors.left: parent.left
            anchors.leftMargin: parent.width*0.4443
            anchors.verticalCenter: rootLogo.verticalCenter
            font.pixelSize: 32
            color: "#2F97D2"
            font.bold: true
            text: qsTr("远众演示")
        }

        //显示时间
        Text {
            id: showTime
            anchors.left: parent.left
            anchors.leftMargin: parent.width*0.7461
            anchors.verticalCenter: rootLogo.verticalCenter
            color: "white"
            font.pixelSize: 18
            text: currentDateTime()
        }

//        SwipeView {
//            id: swipeView
//            width: 1024
//            height: 600
//            interactive : true
//            orientation: Qt.Vertical
        Item {
            id: name
        }


              //  ope
                FunctionPage{
                    id: functionPageRoot

                }
 //           }
 //       }
    }

}
