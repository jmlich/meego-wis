import QtQuick 1.1
import com.nokia.meego 1.0

Page {

    signal showEnroled
    signal showNews
    signal showConfiguration;
    tools: mainTools


    PageHeader {
        id: pageHeader
        text: qsTr("wis.fit.vutbr.cz")
    }


    Column {
        anchors.top: pageHeader.bottom;
        anchors.bottom: parent.bottom;
        anchors.left: parent.left;
        anchors.right: parent.right

        Rectangle {
            width: parent.width;
            height: 88;
            color: newsBtnMouse.pressed ? Qt.darker("#ffe0e1e2", 1.2) : "#ffe0e1e2"
            Label {
                clip: true;
                anchors.margins: 10
                width: parent.width
                anchors.left: parent.left;
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 34
                text: qsTr("News")
            }


            MouseArea {
                id: newsBtnMouse;
                anchors.fill: parent;
                onClicked: {
                    showNews()

                }
            }
        }



        Rectangle {
            width: parent.width;
            height: 88;
            color: enroledBtnMouse.pressed ? Qt.darker("#ffe0e1e2", 1.2) : "#ffe0e1e2"
            Label {
                clip: true;
                anchors.margins: 10
                width: parent.width
                anchors.left: parent.left;
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 34
                text: qsTr("Enrolled Courses")
            }


            MouseArea {
                id: enroledBtnMouse;
                anchors.fill: parent;
                onClicked: {
                    showEnroled()

                }
            }
        }

    }

    ToolBarLayout {
        id: mainTools
        visible: true
        ToolIcon {
            platformIconId: "toolbar-view-menu"
            anchors.left: (parent === undefined) ? undefined : parent.left;
            onClicked: {
                showConfiguration();
            }
        }

    }


}
