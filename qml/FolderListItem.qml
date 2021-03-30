import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import MeuiKit 1.0 as Meui

Item {
    id: _listItem
    width: ListView.view.width - ListView.view.leftMargin - ListView.view.rightMargin
    height: 40

    Accessible.name: fileName
    Accessible.role: Accessible.Canvas

    property Item iconArea: _image.visible ? _image : _icon
    property Item textArea: _label

    property int index: model.index
    property bool hovered: ListView.view.hoveredItem === _listItem
    property bool selected: model.selected
    property bool blank: model.blank

    property color hoveredColor: Meui.Theme.darkMode ? Qt.lighter(Meui.Theme.backgroundColor, 1.1)
                                                     : Qt.darker(Meui.Theme.backgroundColor, 1.05)
    property color selectedColor: Meui.Theme.darkMode ? Qt.lighter(Meui.Theme.backgroundColor, 1.2)
                                                      : Qt.darker(Meui.Theme.backgroundColor, 1.15)
//    onSelectedChanged: {
//        if (selected && !blank) {
//            _listItem.grabToImage(function(result) {
//                folderModel.addItemDragImage(_listItem.index,
//                                             _listItem.x,
//                                             _listItem.y,
//                                             _listItem.width, _listItem.height, result.image)
//            })
//        }
//    }

    Rectangle {
        id: _background
        anchors.fill: parent
        radius: Meui.Theme.smallRadius
        color: selected ? selectedColor : hovered ? hoveredColor : "transparent"
        visible: selected || hovered
    }

    RowLayout {
        id: _mainLayout
        anchors.fill: parent
        anchors.leftMargin: Meui.Units.smallSpacing
        anchors.rightMargin: Meui.Units.smallSpacing
        spacing: Meui.Units.largeSpacing

        Item {
            id: iconItem
            Layout.fillHeight: true
            width: parent.height * 0.8

            Image {
                id: _icon
                anchors.centerIn: iconItem
                width: iconItem.width
                height: width
                sourceSize.width: width
                sourceSize.height: height
                source: "image://icontheme/" + model.iconName
                visible: !_image.visible
                asynchronous: true
            }

            Image {
                id: _image
                width: parent.height * 0.8
                height: width
                anchors.centerIn: iconItem
                sourceSize: Qt.size(_icon.width, _icon.height)
                source: model.thumbnail ? model.thumbnail : ""
                visible: _image.status === Image.Ready
                fillMode: Image.PreserveAspectFit
                asynchronous: true
                smooth: false
            }
        }

        Label {
            id: _label
            text: model.fileName
            Layout.fillWidth: true
            color: Meui.Theme.textColor
            elide: Qt.ElideMiddle
        }
    }
}