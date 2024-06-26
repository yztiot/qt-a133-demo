import QtQuick 2.12
import QtQml 2.0

Rectangle{
    id: screenSaveRoot
    width: root.width*945/1024
    height:  root.height*84/600
    anchors.top: volRoot.bottom
    anchors.topMargin:  root.height*8/600
    anchors.horizontalCenter: parent.horizontalCenter
    color: "transparent"
    property int nScreenModel: 0
    property var bOpenScreenSave: false



    Component.onCompleted: {

        nScreenModel = Number(SystemSetting.getScreenSaveModel());

        switch(nScreenModel){
        case 0:
            btOneMin.color = "#0080FF";
            bOpenScreenSave = true
            SystemSetting.setScreenSave(1, bOpenScreenSave);
            break;
        case 1:
            bOpenScreenSave = true
            SystemSetting.setScreenSave(5, bOpenScreenSave);
            btFiveMin.color = "#0080FF";
            break;
        case 2:
            bOpenScreenSave = true
            SystemSetting.setScreenSave(10, bOpenScreenSave);
            btTenMin.color = "#0080FF";
            break;
        case 3:
            bOpenScreenSave = true
            SystemSetting.setScreenSave(30, bOpenScreenSave);
            btThirtyMin.color = "0#080FF";
            break;
        case 4:
            btOnehour.color = "#0080FF";
            bOpenScreenSave = true
            SystemSetting.setScreenSave(60, bOpenScreenSave);
            break;
        default:
            bOpenScreenSave = false
            SystemSetting.setScreenSave(100, bOpenScreenSave);
            btForever.color = "#0080FF";
            break;
        }
    }

    Rectangle{
        anchors.fill: parent
        radius: 12
        opacity: 0.23
        color: "#B2CEFF"
    }
    Image {
        id: imgScreenSaver
        width: 24
        height: 24
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.topMargin:root.height*31/600
        anchors.leftMargin:  root.width*29/1024
        source: "./src/screenSaver"
    }
    Text {
        id: txt
        anchors.left: parent.left
        anchors.leftMargin:  root.width*66/1024
        anchors.verticalCenter: imgScreenSaver.verticalCenter
        font.pixelSize: 26
        color: "white"
        text: qsTr("屏保")
    }
    Rectangle{
        id: btOneMin

        width: root.width*113/1024
        height:  root.height*42/600

        radius: height / 2
        color: "#EBEFF5"
        border.color: "#D4D4D4"
        anchors.left: parent.left
         anchors.verticalCenter: imgScreenSaver.verticalCenter
         anchors.leftMargin: root.width*140/1024//200//219


        Text {
            id: txtOne
            anchors.centerIn: parent
            font.pixelSize: 17
            color:"#0046C8"
            text: qsTr("1分钟后")

        }

        MouseArea{
            anchors.fill: parent
            onClicked: {
                nScreenModel = 0
                btOneMin.color = "#0080FF"
                btFiveMin.color = "#EBEFF5"
                btTenMin.color = "#EBEFF5"
                btThirtyMin.color = "#EBEFF5"
                btOnehour.color = "#EBEFF5"
                btForever.color = "#EBEFF5"
                txtOne.color = "white"
                txtFive.color = "#0046C8"
                txtTen.color = "#0046C8"
                txtThirty.color = "#0046C8"
                txtHour.color = "#0046C8"
                txtForever.color = "#0046C8"
                bOpenScreenSave = true
                SystemSetting.setScreenSave(1, bOpenScreenSave);
            }
        }
    }

    Rectangle{
        id: btFiveMin
        width: root.width*113/1024
        height:  root.height*42/600

        radius: height / 2
        color: "#EBEFF5"
        border.color: "#D4D4D4"
        anchors.verticalCenter: btOneMin.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: root.width*270/1024//200//219
        Text {
            id: txtFive
            anchors.centerIn: parent
            font.pixelSize: 17
            color:"#0046C8"
            text: qsTr("5分钟后")

        }

        MouseArea{
            anchors.fill: parent
            onClicked: {
                nScreenModel = 1
                btOneMin.color = "#EBEFF5"
                btFiveMin.color = "#0080FF"
                btTenMin.color = "#EBEFF5"
                btThirtyMin.color = "#EBEFF5"
                btOnehour.color = "#EBEFF5"
                btForever.color = "#EBEFF5"
                txtOne.color = "#0046C8"
                txtFive.color = "white"
                txtTen.color = "#0046C8"
                txtThirty.color = "#0046C8"
                txtHour.color = "#0046C8"
                txtForever.color = "#0046C8"
                bOpenScreenSave = true
                SystemSetting.setScreenSave(5, bOpenScreenSave);

            }
        }
    }

    Rectangle{
        id: btTenMin
        width: root.width*113/1024
        height:  root.height*42/600

        radius: height / 2
        color: "#EBEFF5"
        border.color: "#D4D4D4"
        anchors.verticalCenter: btOneMin.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: root.width*400/1024//348//368
        Text {
            id: txtTen
            anchors.centerIn: parent
            font.pixelSize: 17
            color:"#0046C8"
            text: qsTr("10分钟后")

        }

        MouseArea{
            anchors.fill: parent
            onClicked: {
                nScreenModel = 2
                btOneMin.color = "#EBEFF5"
                btFiveMin.color = "#EBEFF5"
                btTenMin.color = "#0080FF"
                btThirtyMin.color = "#EBEFF5"
                btOnehour.color = "#EBEFF5"
                btForever.color = "#EBEFF5"
                txtOne.color = "#0046C8"
                txtFive.color = "#0046C8"
                txtTen.color = "white"
                txtThirty.color = "#0046C8"
                txtHour.color = "#0046C8"
                txtForever.color = "#0046C8"
                bOpenScreenSave = true
                SystemSetting.setScreenSave(10, bOpenScreenSave);

            }
        }
    }

    Rectangle{
        id: btThirtyMin
        width: root.width*113/1024
        height:  root.height*42/600
        radius: height / 2
        color: "#EBEFF5"
        border.color: "#D4D4D4"
        anchors.verticalCenter: btOneMin.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: root.width*540/1024//496//516
        Text {
            id: txtThirty
            anchors.centerIn: parent
            font.pixelSize: 17
            color:"#0046C8"
            text: qsTr("30分钟后")

        }

        MouseArea{
            anchors.fill: parent
            onClicked: {
                nScreenModel = 3
                btOneMin.color = "#EBEFF5"
                btFiveMin.color = "#EBEFF5"
                btTenMin.color = "#EBEFF5"
                btThirtyMin.color = "#0080FF"
                btOnehour.color = "#EBEFF5"
                btForever.color = "#EBEFF5"
                txtOne.color = "#0046C8"
                txtFive.color = "#0046C8"
                txtTen.color = "#0046C8"
                txtThirty.color = "white"
                txtHour.color = "#0046C8"
                txtForever.color = "#0046C8"
                bOpenScreenSave = true
                SystemSetting.setScreenSave(30, bOpenScreenSave);

            }
        }
    }

    Rectangle{
        id: btOnehour
        width: root.width*113/1024
        height:  root.height*42/600
        radius: height / 2
        color: "#EBEFF5"
        border.color: "#D4D4D4"
        anchors.verticalCenter: btOneMin.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: root.width*660/1024//645//665
        Text {
            id: txtHour
            anchors.centerIn: parent
            font.pixelSize: 17
            color:"#0046C8"
            text: qsTr("一小时后")

        }

        MouseArea{
            anchors.fill: parent
            onClicked: {
                nScreenModel = 4
                btOneMin.color = "#EBEFF5"
                btFiveMin.color = "#EBEFF5"
                btTenMin.color = "#EBEFF5"
                btThirtyMin.color = "#EBEFF5"
                btOnehour.color = "#0080FF"
                btForever.color = "#EBEFF5"
                txtOne.color = "#0046C8"
                txtFive.color = "#0046C8"
                txtTen.color = "#0046C8"
                txtThirty.color = "#0046C8"
                txtHour.color = "white"
                txtForever.color = "#0046C8"
                bOpenScreenSave = true
                SystemSetting.setScreenSave(60, bOpenScreenSave);

            }
        }
    }

    Rectangle{
        id: btForever
        width: root.width*113/1024
        height:  root.height*42/600
        radius: height / 2
        color: "#EBEFF5"
        border.color: "#D4D4D4"
        anchors.verticalCenter: btOneMin.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin:  root.width*790/1024//795//815
        Text {
            id: txtForever
            anchors.centerIn: parent
            font.pixelSize: 17
            color:"#0046C8"
            text: qsTr("永久")

        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                nScreenModel = 5
                btOneMin.color = "#EBEFF5"
                btFiveMin.color = "#EBEFF5"
                btTenMin.color = "#EBEFF5"
                btThirtyMin.color = "#EBEFF5"
                btOnehour.color = "#EBEFF5"
                btForever.color = "#0080FF"
                txtOne.color = "#0046C8"
                txtFive.color = "#0046C8"
                txtTen.color = "#0046C8"
                txtThirty.color = "#0046C8"
                txtHour.color = "#0046C8"
                txtForever.color = "white"
                bOpenScreenSave = false
                SystemSetting.setScreenSave(100, bOpenScreenSave);
            }
        }
    }

    function setModel(i){
        switch(i){
            case 0: {

                btOneMin.color = "#0080FF";

                break;
            }
            case 1: {

                btFiveMin.color = "#0080FF"; break;
            }
            case 2: {

                btTenMin.color = "#0080FF"; break;
            }
            case 3: {

                btThirtyMin.color = "0#080FF"; break;
            }
            case 4: {

                btOnehour.color = "#0080FF"; break;
            }
            case 5: {
                btForever.color = "#0080FF"; break;
            }

            default: {

                 break;

                }
        }
    }



}
