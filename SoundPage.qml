import QtQuick 2.12
import QtMultimedia 5.12
import QtQml 2.0

GeneralBgPage{
    id: settingRoot
    iconPath: "./src/iconSound"
    titleName: qsTr("音频")

    property string currentDir: ""
    property var soundNameList
    property var lastSoundIndex
    property string currentSoundFile : ""
    property int nCurrentIndex: 0
    property bool bPlay: false
    property int soundViewItemWidth: Math.round(soundView.width * 950 / 1024)
    property int soundViewItemHeight: Math.round(soundView.height * 84 / 600)

    Component.onCompleted: {
        Sound.findSoundFile();
        updataSoundList();
    }

    function updataSoundList(){
        soundNameList  = Sound.getSoundFile()
        currentDir = Sound.getSoundPath();
        for(var i in soundNameList){
            listModel.append({
                                 name: soundNameList[i],
                                 playSoundIconVisble: false
                             })
        }
    }

    function playMusic(name){
        soundPlay.play()
    }

    Rectangle{
        id: soundPage
        width: parent.width * 0.9
        height: parent.height
        color: "transparent"
        anchors.horizontalCenter: parent.horizontalCenter
        VolLmPage{
            id: volRoot
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.topMargin: Math.round(root.height* 89/ 600)
            strName: "音量"
            logoPath: "./src/volMax"
            minPath: "./src/volMin"
            maxPath: "./src/volMax"
            model :2
        }

        Text {
            id: soundTip
            color: "white"
            font.pixelSize: 22
            anchors.left: volRoot.left
            anchors.top: volRoot.bottom
            anchors.topMargin: root.height / 60
            text: qsTr("歌曲")
        }

        ListView{
            id: soundView
            width: parent.width
            height: root.height * 0.5
            spacing: 5
            anchors.top: soundTip.bottom
            anchors.topMargin: Math.round(root.height*70/600)
            anchors.horizontalCenter: parent.horizontalCenter
            model: listModel

            delegate: Rectangle{
                width: root.width * 0.92
                height: root.height / 7
                color: "transparent"
                MouseArea{
                    anchors.fill: parent
                    onClicked: {

                    }
                }

                Rectangle{
                    width: parent.width
                    height: parent.height
                    color: "#B2CEFF"
                    opacity: 0.23
                    radius: 12
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            listModel.set(lastSoundIndex, {playSoundIconVisble: false})
                            lastSoundIndex = index
                            listModel.set(index, {playSoundIconVisble: true})
                            currentSoundFile = currentDir+"/"+ soundNameList[index]
                            nCurrentIndex =index
                            console.log("source::" +"file:"+ currentSoundFile)
                            soundPlay.source = "file:" + currentSoundFile
                            soundPlay.play();
                            bPlay = true;
                        }
                    }
                }

                Image{
                    id: imgIcon
                    width: height
                    height: root.height *16/ 600
                    visible: playSoundIconVisble
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin:  root.width * 29/ 1024
                    source: "./src/soundPlaying"

                }
                Text {
                    id: soundName
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin:  Math.round(root.width* 66/ 1024)
                    color: "white"
                    font.pixelSize: 26
                    text: qsTr(name)
                }


                Image{
                    id: imgIconlast
                    width:  Math.round(root.width* 80/ 1024)
                    height: Math.round(root.height* 80/ 600)
                    visible: playSoundIconVisble
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: Math.round(root.height* 20/ 600)
                    source: "./src/pauseSound"
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            console.log("the stauts is::" + soundPlay.status )
                            if(bPlay){
                                soundPlay.pause();
                                bPlay = false

                                imgIconlast.source = "./src/playSound"

                            }else{
                                soundPlay.play();
                                bPlay = true
                                imgIconlast.source = "./src/pauseSound"

                            }

                        }
                    }
                }
            }
        }


        ListModel{
            id: listModel
        }

        MediaPlayer{
            id:soundPlay
            volume: 0.5
            source: ""

        }

    }
}
