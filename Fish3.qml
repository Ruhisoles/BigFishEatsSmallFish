import QtQuick 2.0

Image {
    id: fish3
    source: "image/Fish3Right.jpg"
    width: 180; height: 120
    z: 3
    property int dir: 1; //1=right, -1=left
    property double growValue: 30
    property double nutrition: 3
    property double speed: 30
}
