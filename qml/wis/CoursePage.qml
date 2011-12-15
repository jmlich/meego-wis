import QtQuick 1.1
import com.nokia.meego 1.0

Page {
    id: courseDetail
    tools: courseTools
    signal back;

    property string course_id: "";
    property string title: "";
    property string abbrv: "";
    property string type: "";
    property string completion: "";
    property string points: "";
    property string credits: "";
    property string upd_ts: "";


    function typeToString(abbr) {
        var arr = {
            "P"  : qsTr("P"),
            "PV" : qsTr("PV"),
            "V"  : qsTr("V"),
            "D"  : qsTr("D")
        }
        return arr[abbr];

    }

    function completionToString(abbr) {
        var arr = {
            "Za":   qsTr("Za"),
            "Zk":   qsTr("Zk"),
            "ZaZk": qsTr("ZaZk"),
            "Klz":  qsTr("Klz"),
            "-":    qsTr("-")
        }
        return arr[abbr];
    }



    PageHeader {
        id: m_title;
        text: courseDetail.title
        // courseID
    }

    /*
    Rectangle {
        anchors.fill: parent;
        z: -1;
    }
    */

    Column {
        anchors.top: m_title.bottom;
        anchors.bottom: parent.bottom
        anchors.left: parent.left;
        anchors.right: parent.right
        anchors.margins: 10

        Label {
            id: m_abbrv;
            text: qsTr("abbreviation") + ": " + courseDetail.abbrv
        }

        Label {
            id: m_type;
            text: qsTr("type") + ": " + typeToString(courseDetail.type)
        }

        Label {
            id: m_completion;
            text: qsTr("completion") + ": " + completionToString(courseDetail.completion)
        }

        Label {
            id: m_points
            text: qsTr("points") + ": " + courseDetail.points
        }

        Label {
            id: m_credits
            text: qsTr("credits") + ": " + courseDetail.credits
        }

        Label {
            id: m_upd_ts
            text: qsTr("update") + ": " + courseDetail.upd_ts
        }
    }



    ToolBarLayout {
        id: courseTools
        visible: true
        ToolIcon {
            platformIconId: "toolbar-back"
            anchors.left: (parent === undefined) ? undefined : parent.left;
            onClicked: {
                back();
            }
        }
    }


}
