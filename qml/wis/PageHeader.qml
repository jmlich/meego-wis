import QtQuick 1.0

Rectangle {
   id: headerRectangle
   property alias text: headerText.text

   width: parent.width
   height: 72

   anchors.top: parent.top
   anchors.left: parent.left
   anchors.right: parent.right

   color: "#ff00a8e6";
   z: 5


   Text {
       id: headerText

       anchors.left: parent.left
       anchors.leftMargin: 12
       anchors.verticalCenter: parent.verticalCenter

       color: "white"
       text: "header"
       font.pixelSize: 34
   }
}
