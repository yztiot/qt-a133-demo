import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.2
import QtQml 2.0

GeneralBgPage{
    id: settingRoot
    iconPath: "./src/iconSetting"
    titleName: "系统设置"

    property int  nCurrentHour: 0
    property int  nCurrentMin: 0
    property int  nCurrentSec: 0

    Component.onCompleted: {
        getTime();
    }

    ListView{
        id: listViewRoot
        width: parent.width
        height: root.height*500/600
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: root.height*89/600
        anchors.horizontalCenter: parent.horizontalCenter
        model: listModel
        clip: true
        spacing: 10
        delegate: Rectangle{
            id: listRecRoot
            width: parent.width
            height: root.height
            anchors.top: parent.top
            anchors.left: parent.left
            color: "transparent"
            MouseArea{
                anchors.fill: parent
                onClicked: {
                }
            }

            VolLmPage{
                id: lmRoot
                strName: "亮度"
                logoPath: "./src/lmMax"
                minPath: "./src/lmMin"
                maxPath: "./src/lmMax"
                model :1
            }
            ScreenSaver{
                id: screenSaver
                anchors.top: lmRoot.bottom
            }

            //设置时间
            Rectangle{
                id: timeRoot
                width:  root.width*945/1024
                height: root.height*218/600
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: screenSaver.bottom
                anchors.topMargin: root.height*8/600
                color: "transparent"

                Rectangle{
                    anchors.fill: parent
                    radius: 12
                    opacity: 0.23
                    color: "#B2CEFF"
                }

                Image {
                    id: imgTime
                    width:  root.width*25/1024
                    height: root.height*25/600
                    anchors.left: parent.left
                    anchors.leftMargin: root.width*29/1024
                    anchors.top: parent.top
                    anchors.topMargin: root.height*27/600
                    source: "./src/time"
                }

                Text{
                    id: txtTime
                    anchors.verticalCenter: imgTime.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: root.width*66/1024
                    font.pixelSize: 26
                    color: "white"
                    text: qsTr("时间")
                }

                FontMetrics {
                    id: fontMetrics
                }

                Component {
                    id: delegateComponent

                    Label {
                        text: formatText(Tumbler.tumbler.count, modelData)
                        color: Tumbler.displacement ? "white": "#0080FF"
                        opacity: 1.0 - Math.abs(Tumbler.displacement) / (Tumbler.tumbler.visibleItemCount / 2)
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.pixelSize:root.height*22/600   //* 3//Math.abs(Tumbler.displacement) / (Tumbler.tumbler.visibleItemCount * 2) * 20
                    }
                }

                /*选择时间*/
                Rectangle {
                    id: frame
                    width: timeRoot.width / 2
                    height: timeRoot.height / 1.5
                    anchors.centerIn: parent
                   // color: "yellow"
                    color: "transparent"

                    Row {
                        id: row
                        anchors.centerIn: parent
                        spacing: root.height*20/600

                        Tumbler {
                            id: hoursTumbler
                            model: 24
                            visibleItemCount: 3
                            delegate: delegateComponent
                            currentIndex: nCurrentHour


                        }
                        Text {
                            id: hh
                            anchors.verticalCenter: parent.verticalCenter
                            color:"white"
                            font.pixelSize: root.height*22/600

                            text: qsTr("时")
                        }

                        Tumbler {
                            id: minutesTumbler
                            model: 60
                            visibleItemCount: 3
                            delegate: delegateComponent
                            currentIndex: nCurrentMin
                        }

                        Text {
                            id: mm
                            anchors.verticalCenter: parent.verticalCenter
                            color:"white"
                            font.pixelSize:  root.height*22/600
                            text: qsTr("分")
                        }

                        Tumbler {
                            id: secondTumbler
                            model: 60
                            visibleItemCount: 3
                            delegate: delegateComponent
                            currentIndex: nCurrentSec
                        }

                        Text {
                            id: ss
                            anchors.verticalCenter: parent.verticalCenter
                            color:"white"
                            font.pixelSize:  root.height*22/600
                            text: qsTr("秒")
                        }
                    }
                }

                Rectangle{
                    id: btUpdate
                    width: root.width*107/1024
                    height: root.height*40/600
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: root.width*773/1024
                    radius: height / 2
                    color: "#D4D4D4"

                    Text {
                       // id: name
                        anchors.centerIn: parent
                        color: "#0046C8"
                        font.pixelSize: 16
                        text: qsTr("更新")
                    }

                    MouseArea{
                        anchors.fill: parent
                        onPressed: {
                            btUpdate.opacity = 0.5
                            setTime(hoursTumbler.currentIndex, minutesTumbler.currentIndex, secondTumbler.currentIndex)
                        }
                        onReleased: {
                            btUpdate.opacity = 1
                        }
                    }
                }

            }


        }

    }

    ListModel{
        id:listModel
        ListElement{
            name:""
        }
    }

    function formatText(count, modelData) {
        var data = (count === 12) ? modelData + 1 : modelData;
        return data.toString().length < 2 ? "0" + data : data;
    }

    //获取系统时间
    function getTime(){
        var time = new Date;
        var nhour = time.getHours()
        if(nhour >15 ){
            nCurrentHour = nhour%8
        }else{

            nCurrentHour = time.getHours() + 8 ;
        }
        nCurrentMin = time.getMinutes();
        nCurrentSec = time.getSeconds();

    }

    //设置系统时间
    function setTime(hour, minutes, second){
        var time = new Date;
        var year = time.getFullYear();
        var mon = time.getMonth() + 1;
        var day = time.getDate();

        var strhour = ""
        var strminuter = ""
        var strsceond = ""
        var strTime = ""
        if(hour < 8){
            day = day + 1
        }

        if(hour < 10 && hour > 0){
            strhour = "0"+ (hour.toString());
        }else{
            strhour = hour
        }
        if(minutes  < 10){
            strminuter = "0" + (minutes.toString())
        }else{
            strminuter = minutes
        }
        if(second < 9){
            strsceond = "0" + (second.toString())
        }else{
            strsceond = second
        }


        strTime = year + "-" + mon + "-" + day + " " + strhour + ":" + strminuter + ":" + strsceond
        time.setHours(strhour);
    //   strTime = year  + mon  + day + " " + strhour + ":" + strminuter + ":" + strsceond

        SystemSetting.setSysTime(strTime)
    }

}
