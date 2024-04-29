import QtQuick 2.12
import QtQuick.Controls 1.4

Rectangle {
    id: itemRoot
    width: parent.width  // 使用父项的宽度
    z: 20

    property variant model: []
    property string showText: ""
    property bool checked: false
    property int listHeight: parent.height * 0.35  // 假设列表的高度是父项高度的 35%
    radius: 12
    color: "#20335E"
    height: listHeight  // 使用定义的 listHeight
    Component.onCompleted: {
        addItem()
    }

    ListView {
        id: listViewRoot
        width: parent.width  // 使用父项的宽度
        height: listHeight  // 使用与 itemRoot 相同的高度
        clip: true
        model: listModel
        delegate: Rectangle {
            width: listViewRoot.width  // 使用父项的宽度
            height: root.height* 30/600  // 固定高度
            color: "transparent"
            radius: 12
            id: recItem

            Text {
                id: txtCurrent
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: parent.width * 0.035  // 假设左边距是父项宽度的 3.5%
                color: "white"
                font.pixelSize: 18
                text: muneName
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onPressed: {
                    showText = itemRoot.model[index]
                    itemRoot.visible = false
                }

                onEntered: {
                    recItem.color = "#34456D"  // 修改 item 的颜色
                }
                onExited: {
                    recItem.color = "#20335E"  // 恢复 item 的颜色
                }
            }
        }
    }

    ListModel {
        id: listModel
    }

    function addItem() {
        for (var i in model) {
            var data = model[i];
            listModel.append({ muneName: data })
        }
    }
}
