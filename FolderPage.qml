import QtQuick 2.12
//import QtQuick.VirtualKeyboard 2.1
import QtQml 2.0

GeneralBgPage{
    id: folderRoot
    iconPath: "./src/iconFolder"
    titleName: qsTr("文件夹")
     clip: true

    property int nFolderNumber: 0
    property string strCurrentPaht: "/"
    property string strTotalBuff: ""
    property string strTotalUsable: ""
    property var strList: ""
    property var strFileList: ""

    signal folderDestroySig();

    Component.onCompleted: {
        getSysDiskBuf();
    }


    Connections{
        target: Folder
        /* qt 5.15用这种方式响应信号
        function onSigDelFolder(){
            getSysDiskBuf();
        }

        function onUpdataFolderSig(value){
            strCurrentPaht = value
            getSysDiskBuf();
        }
        function onComeBackSig(){
            folderRoot.folderDestroySig();
            folderRoot.destroy();
        }
        */

        /*qt 5.12.12 用这种方式*/
        onComeBackSig: {
            folderRoot.folderDestroySig();
            console.log("destory folder page::")
            folderRoot.destroy();
        }

        onUpdataFolderSig:{
            strCurrentPaht = path
            getSysDiskBuf();
        }
        onSigDelFolder:{
            getSysDiskBuf();
        }

    }

    Rectangle{
        id: recTurnLeft
        width: root.width*0.06836
        height: root.height*0.1
        anchors.left: parent.left
        anchors.top: parent.top
        color: "transparent"
        Image {
            id: imgTurnLeft
            width: root.width*0.033
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

                Folder.comeBack();

            }
        }
    }

    Rectangle{
        id:recContent
        clip: true
        width: parent.width
        height: parent.height
        color: "transparent"
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: root.height*0.1
        Text {
            id: txtTotalFolder
            anchors.left: parent.left
            anchors.leftMargin: root.width*0.0361
            anchors.top: parent.top
            anchors.topMargin: root.height*0.0467
            font.pixelSize: 22
            color: "white"
            text: qsTr("本地文件 "+strCurrentPaht +"(" + nFolderNumber+ ")")
        }

        Text {
            id: txtTotalBuff
            anchors.left: parent.left
            anchors.leftMargin: root.width*724/1024
            anchors.top: parent.top
            anchors.topMargin:root.height* 28/600
            font.pixelSize: 22
            opacity: 0.52
            color: "white"
            text: qsTr("总存储: " + strTotalBuff)
        }

        Text {
            id: txtTotalUsable
            anchors.left: parent.left
            anchors.leftMargin:root.width*879/1024
            anchors.top: parent.top
            anchors.topMargin: root.height* 28/600
            font.pixelSize: 22
            opacity: 0.52
            color: "white"
            text: qsTr("剩余: " + strTotalUsable)
        }

        ListView{
            id:folderView
            spacing: 10


            anchors.top: parent.top
            anchors.topMargin: root.height* 89/600
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width
            height: root.height* 400/600
            model:listModel
            delegate: Rectangle{
                width: root.width*950/1024
                height: root.height* 84/600
                anchors.horizontalCenter: parent.horizontalCenter
                //color: "#B2CEFF"
                color: "transparent"
                radius: 12

                property int xPress: 0
                property int xRelease: 0

                Rectangle{
                    width: parent.width
                    height: parent.height
                    color: "#B2CEFF"
                    opacity: 0.23
                    radius: 12
                    MouseArea{
                        anchors.fill: parent
                        onPressed: {
                            xPress = mouseX;
                        }

                        onReleased: {
                            xRelease = mouseX
                            if(xPress - xRelease > 10){
                                folderView.currentIndex = index;
                                recEdit.visible = true;
                                recDel.visible  = true;
                            }else{
                                recDel.visible = false
                                recEdit.visible = false
                                Folder.inFolder(strList[index])
                            }
                        }

                    }
                }

                Image{
                    id: imgIcon
                    width: root.width* 25/1024
                    height: root.height* 25/600
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: root.width* 29/1024
                    source: srcPath//"./src/iconSmallFolder"

                }

                Text {
                    id: txtDisConnect
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: root.width* 66/1024
                    color: "white"
                    font.pixelSize: 22
                    text: qsTr(name)
                }

                //编辑按钮
                Rectangle{
                    id: recEdit
                    width: recDel.width + 5
                    height: recDel.height
                    anchors.right: parent.right
                    anchors.top: recDel.top
                    color: "#0080FF"
                    radius: 10
                    visible: false
                    Text{
                        id: texEdit
                        anchors.centerIn: parent
                        color: "white"
                        font.pixelSize: 22
                        text: qsTr("编辑")
                    }

                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            var strName
                            if(index < strList.length){
                                strName = strList[index];
                            }else{
                                strName = strFileList[index - strList.length]
                            }

                            folderView.currentIndex = index;
                            editTip.oldName = strName;
                            editTip.showDel = false;
                            editTip.tipModel = 0

                            editTip.visible = true;
                        }
                    }
                }

                //删除按钮
                Rectangle{
                    id:recDel
                    width: root.width* 104/1024
                    height: root.height* 84/600
                    anchors.right: recEdit.left
                    anchors.rightMargin: -5
                    color: "#FF8D1A"
                    visible: false
                    Text{
                        id: texDel
                        anchors.centerIn: parent
                        color: "white"
                        font.pixelSize: 22
                        text: qsTr("删除")
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            var strName
                            if(index < strList.length){
                                strName = strList[index];
                            }else{
                                strName = strFileList[index - strList.length]
                            }

                            editTip.showDel = true;
                            editTip.tipModel = 1
                            editTip.delName = strName;
                            editTip.visible = true
                            //  Folder.deleteFolder(strName)
                        }
                    }
                }
            }

            footer: Rectangle{
                anchors.topMargin: 20
                width: root.width* 950/1024
                height: root.height* 84/600
                anchors.horizontalCenter: parent.horizontalCenter
                color: "transparent"
                Rectangle{
                    id: addSpace
                    width: parent.width
                    height: root.height* 10/600
                    color: "transparent"
                }

                Rectangle{
                    id: bgRec
                    anchors.top: addSpace.bottom
                    width: parent.width
                    height: parent.height
                    color: "#B2CEFF"
                    opacity: 0.23
                    radius: 12
                }

                Image {
                    id: addFolderimg
                    width: root.width* 134/1024
                    height: root.height* 34/600
                    anchors.centerIn: bgRec
                    source: "./src/btCreateFolder"
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            editTip.showDel = false;
                            editTip.tipModel = 2
                            editTip.titleName = "创建文件夹"
                            editTip.visible = true
                        }
                    }
                }
            }
        }

        ListModel{
            id: listModel

        }
    }

    TipRectangle{
        id:editTip
        visible: false
        // titleName: "编辑"
    }


    function getSysDiskBuf(){
        listModel.clear();

        strTotalBuff   = Folder.getTotalBuf();
        strTotalUsable = Folder.getTotalUsable();
        strList = Folder.getFolderList();
        strFileList = Folder.getFileList();

        for(var i in strList){
            var folderName = strList[i]
            listModel.append({
                                 name: folderName,
                                 srcPath: "./src/iconSmallFolder"
                             })
        }
        for(var j in strFileList){
            var fileName = strFileList[j]
            listModel.append({
                                 name: fileName,
                                 srcPath: "./src/iconFile.png"
                             })
        }
        nFolderNumber = listModel.count;
    }

}
