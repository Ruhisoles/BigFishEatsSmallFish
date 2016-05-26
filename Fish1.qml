import QtQuick 2.0

Image {
    id: fish1
    source: "image/Fish1Right.jpg"
    width: 54; height: 40
    z: 3
    property int dir: 1; //1=right, -1=left
    property double growValue: 5
    property double nutrition: 0.5
    property double speed: 30
}
