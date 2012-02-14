import QtQuick 1.1
import com.nokia.meego 1.0

WisPage {

    signal showEnroled
    signal showNews
    signal showConfiguration;
    signal showTests

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
            //color: newsBtnMouse.pressed ? Qt.darker("#ffe0e1e2", 1.2) : "#ffe0e1e2"
            color: newsBtnMouse.pressed ? "#ffe0e1e2" : "white"
            Label {
                clip: true;
                anchors.margins: 10
                width: parent.width
                anchors.left: parent.left;
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 34
                color: "black"
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
//            color: enroledBtnMouse.pressed ? Qt.darker("#ffe0e1e2", 1.2) : "#ffe0e1e2"
            color: enroledBtnMouse.pressed ? "#ffe0e1e2" : "white"
            Label {
                clip: true;
                anchors.margins: 10
                width: parent.width
                anchors.left: parent.left;
                anchors.verticalCenter: parent.verticalCenter
                color: "black"
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

        Rectangle {
            width: parent.width;
            height: 88;
//            color: testsBtnMouse.pressed ? Qt.darker("#ffe0e1e2", 1.2) : "#ffe0e1e2"
            color: testsBtnMouse.pressed ? "#ffe0e1e2" : "white"
            Label {
                clip: true;
                anchors.margins: 10
                width: parent.width
                anchors.left: parent.left;
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 34
                color: "black"
                text: qsTr("Admission test")
            }


            MouseArea {
                id: testsBtnMouse;
                anchors.fill: parent;
                onClicked: {
                    showTests()

                }
            }
        }

    }

    ToolBarLayout {
        id: mainTools
        visible: true
        MyToolIcon {
            myPlatformIconId: "toolbar-view-menu"
            anchors.left: (parent === undefined) ? undefined : parent.left;
            onClicked: {
                showConfiguration();
            }
        }

    }


}
