import QtQuick 2.12
//import QtQuick.Controls 1.2
//import QtGraphicalEffects 1.0

GeneralBgPage {
    id: drawRoot
    iconPath: "./src/iconDraw"
    titleName: qsTr("画板")

    Rectangle{
        id: drawRec
        width:parent.width
        height: parent.height *0.9
        anchors.top: parent.top
        anchors.topMargin: root.height*0.1
        property alias mouseX: area.mouseX
        property alias mouseY: area.mouseY

        //画板
        Canvas {
            id: canvas
            anchors.fill: parent
            antialiasing: true
            property real lastX //画笔的终止位置
            property real lastY
            property double lineWidth: 1 //线宽
            property color paintColor: "#000000" //画笔颜色

            Image {
                id: btClean
                width: parent.width * 50/1024  // 50 像素转换为相对于父项宽度的百分比 (50 / 1024)
                height: parent.height *72/600 // 72 像素转换为相对于父项高度的百分比 (72 / 600)
                anchors.bottom: parent.bottom  // 底部对齐父项
                anchors.left: parent.left  // 左对齐父项
                anchors.bottomMargin: parent.height * 0.03333  // 20 像素转换为相对于父项高度的百分比 (20 / 600)
                anchors.leftMargin: parent.width * 0.92558  // 946 像素转换为相对于父项宽度的百分比 (946 / 1024)

                z: 50
                source: "./src/btDrawClean"

                MouseArea {
                    anchors.fill: parent  // 填充整个父项
                    onClicked: {
                        console.log("clean")
                        var ctx = canvas.getContext("2d")
                        ctx.clearRect(0, 0, canvas.width, canvas.height)
                        canvas.requestPaint()
                    }
                }
            }

            onPaint: {
                var ctx = canvas.getContext("2d")
                ctx.lineWidth = lineWidth
                ctx.strokeStyle = paintColor
                ctx.beginPath()
                ctx.moveTo(lastX, lastY)
                lastX = area.mouseX
                lastY = area.mouseY
                ctx.lineTo(lastX, lastY)
                ctx.stroke()
            }
            MouseArea {
                id: area
                anchors.fill: parent
                acceptedButtons: Qt.AllButtons
                onPressed: {
                    canvas.lastX = mouseX
                    canvas.lastY = mouseY
                }
                onPositionChanged: {
                    canvas.requestPaint()
                }

            }
        }
    }

}
