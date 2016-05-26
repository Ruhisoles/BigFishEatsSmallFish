var component = null;
var max = 30
var fishes = new Array(max)
var xBoarderLength = 100
var yBoarderLength = 50
function generateNewFish() {
    if (mainWindow.fishNumber < max) {
        //        component = Qt.createComponent("Fish1.qml");
        createComponentDueToType();
        if (component.status == Component.Ready)
            finishGeneration();
        else
            component.statusChanged.connect(finishGeneration);
    }
}

function createComponentDueToType() {
    var type = 10 * Math.random();
    if ( type < 8 ) component = Qt.createComponent("Fish1.qml");
    else if (type >9) component = Qt.createComponent("Fish3.qml");

    else component = Qt.createComponent("Fish2.qml");
}

function finishGeneration() {
    if (component.status == Component.Ready) {
        //        fishes[mainWindow.fishNumber] = component.createObject(background, {"x": background.width * Math.random(), "y": background.height * Math.random()-40});
        createFishDueToPosition();
        mainWindow.fishNumber++
        if (fishes[mainWindow.fishNumber - 1] == null) {
            // Error Handling
            console.log("Error creating object");
        }
    } else if (component.status == Component.Error) {
        // Error Handling
        console.log("Error loading component:", component.errorString());
    }
}

function createFishDueToPosition() {
    var position = Math.random();
    if (position < 0.5)
        fishes[mainWindow.fishNumber] = component.createObject(background, {"x": (-xBoarderLength) * Math.random(), "y": (background.height-40)* Math.random()});
    else
        fishes[mainWindow.fishNumber] = component.createObject(background, {"x": background.width+xBoarderLength*Math.random(), "y": (background.height-40)* Math.random(), "mirror": true, "dir": -1});
}

function checkEating() {
    for (var i = 0; i < mainWindow.fishNumber; i++) {
        if (fishes[i] != null)
            if ( (fishes[i].y + fishes[i].height)>playerFish.y && fishes[i].y<(playerFish.y+playerFish.height) &&
                    (fishes[i].x + fishes[i].width)>playerFish.x && fishes[i].x<(playerFish.x+playerFish.height) )
            {
                if (playerFish.growValue > fishes[i].growValue) {
                    playerFish.growValue = playerFish.growValue + fishes[i].nutrition;
                    fishes[i].destroy();
                    for (var j=i; j < mainWindow.fishNumber; j++)
                    {
                        fishes[j] = fishes[j+1];
                    }
                    mainWindow.fishNumber--;
                }
                else {
                    gameOver();
                }
            }
    }
}
function fishMovement() {
    for (var i = 0; i < mainWindow.fishNumber; i++) {
        if (fishes[i] != null) {
            fishes[i].x = fishes[i].dir*fishes[i].speed + fishes[i].x;
        }
        //if the fish acrosses boarders, destroy fish
        if ( fishes[i].x>(background.width+xBoarderLength) || (fishes[i].x+fishes[i].width)<-xBoarderLength
                || (fishes[i].y+fishes[i].height)<-yBoarderLength || fishes[i].y>(background.height+yBoarderLength) )
        {
            fishes[i].destroy();
            for (var j=i; j < mainWindow.fishNumber; j++)
            {
                fishes[j] = fishes[j+1];
            }
            mainWindow.fishNumber--;
        }
    }
}

function gameOver() {
    playerFish.visible = false;
    restartGameButton.visible = true;
    timer1.stop();
    mainMouseArea.hoverEnabled = false;
    gameOverColumn.visible = true;

}

function restartGame() {
    for (var j=0; j < mainWindow.fishNumber; j++)
        fishes[j].destroy();
    gameOverColumn.visible = false;
    mainWindow.fishNumber = 0;
    timer1.start();
    restartGameButton.visible = false;
    playerFish.visible = true;
    playerFish.growValue = 10;
    mainMouseArea.hoverEnabled = true;
}
