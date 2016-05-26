import QtQuick 2.0

Image {
    id: fish2
    source: "image/Fish2Right.jpg"
    width: 100; height: 80
    z: 3
    property int dir: 1; //1=right, -1=left
    property double growValue: 20
    property double nutrition: 2
    property double speed: 15
}
