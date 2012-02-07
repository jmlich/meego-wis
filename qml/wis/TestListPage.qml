import QtQuick 1.1
import com.nokia.meego 1.0

WisPage {
    tools: mainPageTools

    ToolBarLayout {
        id: mainPageTools
        visible: true
        MyToolIcon {
            myPlatformIconId: "toolbar-back"
            anchors.left: parent.left
            onClicked: back();
        }
    }

    signal back()
    signal testSelected(string filename)

    ListModel {
        id: zadaniModel;

        ListElement { title: "BC 2011 1A"; filename: "bc2011-1a.xml"; }
        ListElement { title: "BC 2011 1B"; filename: "bc2011-1b.xml"; }
        ListElement { title: "BC 2011 2A"; filename: "bc2011-2a.xml"; }
        ListElement { title: "BC 2011 2B"; filename: "bc2011-2b.xml"; }
        ListElement { title: "BC 2011 3A"; filename: "bc2011-3a.xml"; }
        ListElement { title: "BC 2011 3B"; filename: "bc2011-3b.xml"; }
        ListElement { title: "BC 2011 4A"; filename: "bc2011-4a.xml"; }
        ListElement { title: "MGR 2011 A"; filename: "mgr2011-a.xml"; }
        ListElement { title: "MGR 2011 B"; filename: "mgr2011-b.xml"; }
    }

    PageHeader {
        id: pageHeader
        text: qsTr("Tests")
    }

    ListView {
        anchors.top: pageHeader.bottom;
        anchors.left: parent.left;
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        model: zadaniModel
        delegate: Rectangle {
            width: parent.width;
            height: 88;
//            color: itemMouseArea.pressed ? Qt.darker("#ffe0e1e2", 1.2) : "#ffe0e1e2"
            color: itemMouseArea.pressed ? "#ffe0e1e2" : "white"
            Label {
                clip: true;
                anchors.margins: 10
                anchors.left: parent.left;
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 34
                text: model.title
                color: "black"
            }


            MouseArea {
                id: itemMouseArea;
                anchors.fill: parent;
                onClicked: {
                    testSelected(model.filename)
                }
            }
        }

    }



}
