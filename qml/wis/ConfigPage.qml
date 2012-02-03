import QtQuick 1.1
import com.nokia.meego 1.0

WisPage {
    tools: configTools
    signal save;

    property alias login: loginField.text
    property alias password: passwordField.text;


    PageHeader {
        id: configHeader
        text: qsTr("configuration")
    }

    /*
    Rectangle {
        anchors.fill: parent;
        z: -1;
    }
    */


    TextField {
        id: loginField
        anchors.bottom: parent.verticalCenter;
        width: parent.width
        placeholderText: qsTr("login")
        inputMethodHints: Qt.ImhNoAutoUppercase
        Keys.onReturnPressed: {
            passwordField.forceActiveFocus();
        }

    }

    TextField {
        id: passwordField;
        anchors.top: parent.verticalCenter;
        width: parent.width;
        placeholderText: qsTr("password")
        echoMode: TextInput.Password
        Keys.onReturnPressed: {
            save();
        }
    }







    ToolBarLayout {
        id: configTools
        visible: true
        ToolIcon {
            platformIconId: "toolbar-back"
            anchors.left: (parent === undefined) ? undefined : parent.left;
            onClicked: {
                save();
            }
        }
    }


}
