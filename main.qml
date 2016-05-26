import QtQuick 2.3
import QtQuick.Window 2.2
import "fishManagement.js" as FishManagement

Window {
    id: mainWindow
    visible: true
    width: 800
    height: 600
    property int fishNumber: 0
    property int maxFishNumber: 30
    Component.onCompleted: timer1.start()

    MouseArea {
        id: mainMouseArea
        width: parent.width; height: parent.height
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        z: 2
        hoverEnabled: true
        cursorShape: containsMouse ? "BlankCursor" : "ArrowCursor"

        Image {
            id: playerFish
            width: 5.4 * playerFish.growValue
            height: 4.0 * playerFish.growValue
            z: 4
            source: "image/PlayerFishLeft.jpg"
            x : mainMouseArea.mouseX - playerFish.width/2;
            y : mainMouseArea.mouseY - playerFish.height/2;
            property double growValue: 10
            Behavior on x { NumberAnimation {duration: 1500; easing.type: Easing.OutQuint} }
            Behavior on y { NumberAnimation {duration: 1500; easing.type: Easing.OutQuint} }
        }

        Text {
            id: displayFishNumber
            x: 615
            width: 140
            height: 24
            z: 5
            text: "FishNumber: " + mainWindow.fishNumber
            font.pixelSize: 20
            anchors.top: parent.top; anchors.topMargin: 50
            anchors.right: parent.right; anchors.rightMargin: 50
        }
        Text {
            id: displayScore
            width: 140
            height: 24
            z: 5
            text: "Score: " + (playerFish.growValue - 10)*2
            font.pixelSize: 20
            anchors.top: parent.top; anchors.topMargin: 50
            anchors.left: parent.left; anchors.leftMargin: 50
        }

        /*
        Text {
            id: displayX
            x: 610
            width: 140
            height: 24
            z: 5
            text:"X: " + mainMouseArea.mouseX
            font.pixelSize: 20
            anchors.top: parent.top; anchors.topMargin: 74
            anchors.right: parent.right; anchors.rightMargin: 50
        }

        Text {
            id: displayY
            x: 610
            width: 140
            height: 24
            z: 5
            text:"Y: " + mainMouseArea.mouseY
            font.pixelSize: 20
            anchors.top: parent.top; anchors.topMargin: 98
            anchors.right: parent.right; anchors.rightMargin: 50
        }
*/
    }

    Image {
        id: background
        anchors.fill: parent
        source: "image/SeeFloor.jpg"
        z: 1

        Column {
            id: gameOverColumn
            width: gameOverText.width
            height: hint1.height+5+gameOverText.height
            spacing: 5
            z: 5
            visible: false
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            Text {
                id: hint1
                text: qsTr("You've been eaten!!")
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 25
            }
            Text {
                id: endScore
                text: "End " + displayScore.text
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 25
            }
            Text {
                id: gameOverText
                text: qsTr("GAME OVER")
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 50
            }
        }

    }

    Row {
        z: 4
        spacing: 5
        anchors.bottom: parent.bottom; anchors.bottomMargin: 0
        height: restartGameButton.height

        Button {
            id: generateFishButton
            property bool generating: true
            text: generateFishButton.generating ? "Stop Generate" : "Start Generate"
            onClicked: generateFishButton.generating = !generateFishButton.generating
        }

        Button {
            id: endGameButton
            text: "End Game"
            onClicked: Qt.quit();
        }

        Button {
            id: restartGameButton
            visible: false
            text: "Restart"
            onClicked: FishManagement.restartGame()
        }
    }

    Timer {
        id: timer1
        interval: 100; repeat: true; running: false
        property int times: 0
        onTriggered: {
            times++
            if(times == 4 ) {  times=0; if(generateFishButton.generating)FishManagement.generateNewFish();}
            FishManagement.checkEating()
            FishManagement.fishMovement()
        }
    }
}
