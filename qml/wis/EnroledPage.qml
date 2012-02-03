import QtQuick 1.1
import com.nokia.meego 1.0

WisPage {
    tools: enroledTools

    property alias model: wismodel
    property alias loading: busyindicator.visible;
    property alias errorString: errorLabel.text

    signal courseSelected(string title, string course_id, string abbrv, string type, string completion, string points, string credits, string upd_ts);
    signal refresh;
    signal back;

    PageHeader {
        id: pageHeader
        text: qsTr("Enrolled Courses")
    }

    BusyIndicator {
        id: busyindicator;
        anchors.right: parent.right;
        anchors.margins: 20;
        anchors.verticalCenter: pageHeader.verticalCenter
        visible: true;
        running: visible;
        z: 12
    }

    Label {
        id: errorLabel
        color: "#ffff0000"
        anchors.centerIn: parent;
        text: ""
        z: 10
    }


    XmlListModel {
        id: wismodel
        query: "/*/course"

        XmlRole { name: "title";     query: "title/string()" }
        XmlRole { name: "course_id"; query: "@id/string()" }
        XmlRole { name: "abbrv";     query: "@abbrv/string()" }
        XmlRole { name: "type";      query: "@type/string()" }
        XmlRole { name: "completion";query: "@completion/string()" }
        XmlRole { name: "points";    query: "@points/string()" }
        XmlRole { name: "credits";   query: "@credits/string()" }
        XmlRole { name: "upd_ts";    query: "@upd_ts/string()" }


        onStatusChanged: {
            if (status == XmlListModel.Error) {
                console.log("xmlListModel.status == Error: " + errorString())
            }

        }

    }

    Item {
        anchors.top: pageHeader.bottom;
        anchors.bottom: parent.bottom;
        anchors.left: parent.left;
        anchors.right: parent.right;
        ListView {
            anchors.fill: parent;
            model: wismodel
            delegate: Rectangle {
                width: parent.width;
                height: 88;
                //color: itemMouseArea.pressed ? Qt.darker("#ffe0e1e2", 1.2) : "#ffe0e1e2"
                color: itemMouseArea.pressed ? "#ffe0e1e2" : "white"
                Label {
                    clip: true;
                    anchors.margins: 10
                    width: parent.width -80
                    anchors.left: parent.left;
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: 34
                    text: model.title
                }

                Label {
                    anchors.margins: 10
                    anchors.right: parent.right;
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: 34
                    text: model.points
                }

                MouseArea {
                    id: itemMouseArea;
                    anchors.fill: parent;
                    onClicked: {
                        courseSelected(model.title, model.course_id, model.abbrv, model.type, model.completion, model.points, model.credits, model.upd_ts);

                    }
                }
            }
        }

    }

    ToolBarLayout {
        id: enroledTools
        visible: true
        ToolIcon {
            platformIconId: "toolbar-back"
            anchors.left: (parent === undefined) ? undefined : parent.left;
            onClicked: {
                back();
            }
        }
        ToolIcon {
            platformIconId: "toolbar-refresh"
            anchors.right: (parent === undefined) ? undefined : parent.right
            onClicked: {
                refresh();
            }
        }

    }

}
