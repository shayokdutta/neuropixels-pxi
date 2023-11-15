// TableViewComponent.qml
import QtQuick 6.5
import QtQuick.Controls 2.15

TableView {
    id: tableView
    resizableRows: false
    model: channelSelectionModel
    clip: true

    Rectangle {
        anchors.fill: parent
        color: 'black'
        opacity: 0.25
    }

    delegate: ItemDelegate {
        id: tableDelegate
        implicitWidth: tableView.width / tableView.model.columnCount

        CheckBox {
            id: checkBox
            opacity: 0.5
            visible: {
                return (row > 0) && (column >= tableView.model.columnCount - 2);
            }
            checked: (row > 0) ? model.checkBoxState : false
            display: AbstractButton.IconOnly
            text: qsTr("")
            anchors.centerIn: parent

            onCheckedChanged: {
                if (row > 0) {  // Assuming row 0 is a header and not clickable
                    channelSelectionModel.setData(row, column, checked, CheckBoxStateRole);
                }
            }

        }

        Label {
            id: textLabel

            visible: {
                let isCheckBoxColumn = column >= tableView.model.columnCount - 2;
                let shouldBeVisible = (row < 1) || !isCheckBoxColumn;

                return shouldBeVisible;
            }
            text: model.displayText
            color: "white"
            anchors.centerIn: parent
            font.bold: model.isHeader
        }
    }

    ScrollBar.vertical: ScrollBar {
        id: verticalScrollBar
        visible: true
        wheelEnabled: true
        active: true
    }

    ScrollBar.horizontal: ScrollBar {
        id: horizontalScrollBar
        visible: true
        active: true
    }
}



