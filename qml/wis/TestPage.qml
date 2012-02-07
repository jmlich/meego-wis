import QtQuick 1.1
import com.nokia.meego 1.0

WisPage {
    id: testPage;
    tools: testPageTools

    ToolBarLayout {
        id: testPageTools
        visible: true
        MyToolIcon {
            myPlatformIconId: "toolbar-back"
            anchors.left: parent.left
            onClicked: back();
        }
    }

    signal back();

    property int answeredCorrect: 0
    property int answeredWrong: 0
    property int answeredNone: 0
    property int currentQuestion: 0
    property string lastAnswer: ""
    property string testName: "bc2011-1a.xml"
    property int score: 0;

    onStatusChanged: {
        if (status == PageStatus.Active) {
            zadaniModel.reload();
        }
    }

    function start() {
        currentQuestion = 0;
        answeredCorrect = 0;
        answeredWrong = 0;
        answeredNone = 0;
        score = 0;
        showQuestion();
    }

    function stop() {

    }

    function selectedAnswer(value) {
        lastAnswer = value
        var correct = zadaniModel.get(currentQuestion).correct;

        if (value == correct) {
            answeredCorrect++;
            score += parseInt(zadaniModel.get(currentQuestion).points, 10);
        } else if (value == "-"){
            answeredNone++;
        } else {
            score += parseInt(zadaniModel.get(currentQuestion).pointsWrong, 10);
            answeredWrong++;
            if (value == "a") {
                answerA.wrong();
            } else if (value == "b") {
                answerB.wrong();
            } else if (value == "c") {
                answerC.wrong();
            } else if (value == "d") {
                answerD.wrong();
            } else if (value == "e") {
                answerE.wrong();
            }
        }

        if (correct == "a") {
            answerA.correct();
        } else if (correct == "b") {
            answerB.correct();
        } else if (correct == "c") {
            answerC.correct();
        } else if (correct == "d") {
            answerD.correct();
        } else if (correct == "e") {
            answerE.correct();
        }

        answersButtonsRow.visible = false;
        controlButtonsRow.visible = true;

    }

    function nextQuestion() {
        currentQuestion++;
        if (currentQuestion < zadaniModel.count) {
            showQuestion();
        } else {
            stop();
            testSummary.open();
        }
    }

    function showQuestion() {

        answerA.notAnswered();
        answerB.notAnswered();
        answerC.notAnswered();
        answerD.notAnswered();
        answerE.notAnswered();

        question.text = zadaniModel.get(currentQuestion).question;
        answerA.text = "a) " + zadaniModel.get(currentQuestion).answerA;
        answerB.text = "b) " + zadaniModel.get(currentQuestion).answerB;
        answerC.text = "c) " + zadaniModel.get(currentQuestion).answerC;
        answerD.text = "d) " + zadaniModel.get(currentQuestion).answerD;
        answerE.text = "e) " + zadaniModel.get(currentQuestion).answerE;
        points.text  = zadaniModel.get(currentQuestion).points + "/" + zadaniModel.get(currentQuestion).pointsWrong

        answersButtonsRow.visible = true;
        controlButtonsRow.visible = false;

        testPageFlickable.scale = 1.0;

    }


    BusyIndicator {
        id: busyindicator;
        anchors.right: parent.right;
        anchors.margins: 20;
        anchors.verticalCenter: pageHeader.verticalCenter
        visible: (zadaniModel.status != XmlListModel.Ready);

        running: visible;
        z: 12
    }

    XmlListModel {
        id: zadaniModel;
        source: "./tests/"+testName

        onStatusChanged: {
            if (status == XmlListModel.Ready)    {
                start();
            } else if (status == XmlListModel.Error) {
                console.log("xmlListModel: " + errorString())
            }
        }

        query: "/tasks/task"
        XmlRole { name: "question"; query: "question/string()" }
        XmlRole { name: "answerA"; query: "answerA/string()" }
        XmlRole { name: "answerB"; query: "answerB/string()" }
        XmlRole { name: "answerC"; query: "answerC/string()" }
        XmlRole { name: "answerD"; query: "answerD/string()" }
        XmlRole { name: "answerE"; query: "answerE/string()" }
        XmlRole { name: "correct"; query: "correct/string()" }
        XmlRole { name: "points"; query: "points/string()" }
        XmlRole { name: "pointsWrong"; query: "pointsWrong/string()" }

    }


    PageHeader {
        id: pageHeader
        text: (zadaniModel.count > currentQuestion) ? (qsTr("Question ") + (currentQuestion+1)) : ""
    }

    Flickable {
        id: testPageFlickable;
        transformOrigin: Item.TopLeft
        anchors.top: pageHeader.bottom
        anchors.left: parent.left;
        anchors.right: parent.right;
        anchors.bottom: parent.bottom;
        contentWidth: parent.width * scale
        contentHeight: (10*20 +question.height + answerA.height + answerB.height + answerC.height + answerD.height + answerE.height + points.height + answersButtonsRow.height) * scale

        Label {
            id: question;
            anchors.margins: 20
            anchors.top: parent.top;
            anchors.left: parent.left;
            anchors.right: parent.right;
            text: "question text"
            textFormat: Text.RichText
            wrapMode: Text.WordWrap;
            color: "black"
        }

        TestPageAnswer {
            anchors.margins: 20
            anchors.top: question.bottom
            anchors.left: parent.left;
            anchors.right: parent.right;
            id: answerA
        }


        TestPageAnswer {
            anchors.top: answerA.bottom
            anchors.left: parent.left;
            anchors.right: parent.right;
            id: answerB
        }


        TestPageAnswer {
            anchors.top: answerB.bottom
            anchors.left: parent.left;
            anchors.right: parent.right;
            id: answerC
        }
        TestPageAnswer {
            anchors.top: answerC.bottom
            anchors.left: parent.left;
            anchors.right: parent.right;
            id: answerD
        }
        TestPageAnswer {
            anchors.top: answerD.bottom
            anchors.left: parent.left;
            anchors.right: parent.right;
            id: answerE
        }

        Label {
            id: points
            text: ""
            anchors.margins: 20;
            anchors.top: answerE.bottom
            anchors.left: parent.left;
            anchors.right: parent.right;
            color: "black"

        }

        Row {

            id: answersButtonsRow
            anchors.margins: 20
            anchors.top: points.bottom
            anchors.left: parent.left;
            anchors.right: parent.right;
            Button {
                id: btnA
                width: parent.width/6
                text: "a"
                onClicked: { selectedAnswer("a") }
            }
            Button {
                id: btnB
                width: parent.width/6
                text: "b"
                onClicked: { selectedAnswer("b") }
            }
            Button {
                id: btnC
                width: parent.width/6
                text: "c"
                onClicked: { selectedAnswer("c") }
            }
            Button {
                id: btnD
                width: parent.width/6
                text: "d"
                onClicked: { selectedAnswer("d") }
            }
            Button {
                id: btnE
                width: parent.width/6
                text: "e"
                onClicked: { selectedAnswer("e") }
            }
            Button {
                id: btnNevim
                width: parent.width/6
                text: "-"
                onClicked: { selectedAnswer("-") }
            }
        }

        Row {
            id: controlButtonsRow
            anchors.margins: 20
            anchors.top: points.bottom
            //            anchors.top: answersButtonsRow.bottom
            anchors.left: parent.left;
            anchors.right: parent.right;
            Button {
                width: parent.width/2
                text: qsTr("Report")
                onClicked: { reportDialog.open() }
            }
            Button {
                width: parent.width/2
                text: (currentQuestion == zadaniModel.count-1) ? qsTr("Show summary"): qsTr("Next Question")
                onClicked: { nextQuestion(); }
            }

        }

        PinchArea {
            property double __oldZoom

            anchors.top: question.top;
            anchors.bottom: answerE.bottom;
            anchors.left: parent.left;
            anchors.right: parent.right

            property real minScale: 0.5
            property real maxScale: 8

            function calcZoomDelta(zoom, percent) {
                var r = zoom + Math.log(percent)/Math.log(2)
                r = (r < minScale) ? minScale : r;
                r = (r > maxScale) ? maxScale : r;
                return r
            }

            onPinchStarted: {
                __oldZoom = testPageFlickable.scale
            }

            onPinchUpdated: {
                testPageFlickable.scale = calcZoomDelta(__oldZoom, pinch.scale)
            }

            onPinchFinished: {
                testPageFlickable.scale = calcZoomDelta(__oldZoom, pinch.scale)
                testPageFlickable.returnToBounds();
            }



        }

    }

    Dialog {
        id: testSummary;
        title: Label {
            color: "white"
            font.pixelSize: 34
            text: qsTr("Test Summary")
        }
        content: Column {

            Label {
                color: "white";
                text: qsTr("Correct: ") + answeredCorrect
            }
            Label {
                color: "white";
                text: qsTr("Incorrect: ") + answeredWrong
            }
            Label {
                color: "white";
                text: qsTr("Not answered: ") + answeredNone
            }
            Label {
                color: "white";
                text: qsTr("Score: ") + ((score > 0) ? score : 0)
            }
        }

        buttons: Button { text: qsTr("continue"); onClicked: testSummary.accept(); 
        // FIXME SYMBIAN
                platformStyle: ButtonStyle { inverted: true } 
        }

        onAccepted: {
            testPage.back();

        }

    }

    Dialog {
        id: reportDialog

        title: Label {
            font.pixelSize: 34
            color: "white";
            text: qsTr("Report")
        }

        content: TextArea {
            id:reportDialogTextArea
            anchors.fill: parent;
            placeholderText: qsTr("Your notes to the question")
            height: 300

        }

        buttons: Column {
            spacing: 20

            anchors.horizontalCenter: parent.horizontalCenter
            Button { text: qsTr("submit"); onClicked: reportDialog.accept();
// FIXME Symbian
                platformStyle: ButtonStyle { inverted: true }
            }
            Button { text: qsTr("cancel"); onClicked: reportDialog.reject();
// FIXME Symbian
                platformStyle: ButtonStyle { inverted: true }
            }
        }

        onAccepted: {
            var xhr = new XMLHttpRequest;
            xhr.open("GET", "http://pcmlich.fit.vutbr.cz/wis/report.php?testid="+zadaniModel.source+"&q="+currentQuestion+"&a="+lastAnswer+"&report="+reportDialogTextArea.text);
            xhr.onreadystatechange = function() {
                        if (xhr.readyState == XMLHttpRequest.DONE) {
                            console.log(xhr.responseText);
                        }
                    }
            xhr.send();
        }


    }





}
