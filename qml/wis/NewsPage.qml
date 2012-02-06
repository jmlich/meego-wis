import QtQuick 1.1
import com.nokia.meego 1.0

WisPage {

    tools: newsTools

    signal back


    PageHeader {
        id: pageHeader;
        text: qsTr("News");
    }

    BusyIndicator {
        id: busyindicator;
        anchors.right: parent.right;
        anchors.margins: 20;
        anchors.verticalCenter: pageHeader.verticalCenter
        visible: (newsModel.status != XmlListModel.Ready);

        running: visible;
        z: 12
    }

    XmlListModel {
        id: newsModel
        source: "http://www.fit.vutbr.cz/news/news-rss.php.cs"
        query: "/rss/channel/item"

        XmlRole { name: "title"; query: "title/string()" }
        XmlRole { name: "text"; query: "description/string()" }
        XmlRole { name: "pubDate"; query: "pubDate/string()" }
    }

    Item {
        anchors.top: pageHeader.bottom;
        anchors.bottom: parent.bottom;
        anchors.left: parent.left;
        anchors.right: parent.right;
        ListView {

            anchors.fill: parent;
            model: newsModel
            delegate: Rectangle {

                width: parent.width;
//                height: 88;
                height: rssTitle.paintedHeight + rssDescripption.paintedHeight + 40


//                color: "#ffe0e1e2"
                color: "white"
//                color: itemMouseArea.pressed ? Qt.darker("#ffe0e1e2", 1.2) : "#ffe0e1e2"
                Label {
                    id: rssTitle
//                    clip: true;
                    anchors.margins: 10
                    anchors.left: parent.left;
                    anchors.right: parent.right;
                    anchors.top: parent.top;
                    font.pixelSize: 34
                    text: model.title
                    wrapMode: Text.WordWrap;
                    textFormat: Text.RichText
                    color: "black"
                }

                Label {
                    id: rssDescripption
                    clip: true;
                    anchors.margins: 10
                    anchors.left: parent.left;
                    anchors.right: parent.right;
                    anchors.top: rssTitle.bottom
                    font.pixelSize: 20
                    text: model.text
                    wrapMode: Text.WordWrap;
                    textFormat: Text.RichText
                    color: "black"
                }

/*
                MouseArea {
                    id: itemMouseArea;
                    anchors.fill: parent;
                    onClicked: {
                        courseSelected(model.title, model.course_id, model.abbrv, model.type, model.completion, model.points, model.credits, model.upd_ts);

                    }
                }
*/
            }
        }

    }


    ToolBarLayout {
        id: newsTools
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
                newsModel.reload();
            }
        }


    }

}
