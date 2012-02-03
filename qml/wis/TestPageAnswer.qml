// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.0

Label {
    anchors.margins: 20
    textFormat: Text.RichText
    wrapMode: Text.WordWrap;
    color: "black"

    function correct() {
        answerHighlight.opacity = 0.3;
        answerHighlight.color = "green"
    }

    function wrong() {
        answerHighlight.opacity = 0.3;
        answerHighlight.color = "red"
    }

    function notAnswered() {
        answerHighlight.opacity = 0.0;
        answerHighlight.color = "red"
    }

    Rectangle  {
        id: answerHighlight
        anchors.fill: parent
        anchors.margins: -10;
        z: parent.z + 1;
        opacity: 0

    }

}
