import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: root
    width: 120 // Set the default width of the custom SpinBox
    height: 40 // Set the default height of the custom SpinBox

    property real value: 3.00 // Initial value as a decimal
    property real minimumValue: 0.00 // Minimum value as a decimal
    property real maximumValue: 100.00 // Maximum value as a decimal
    property real stepSize: 1.00 // Step size for increment/decrement as a decimal

    signal myValueChanged(real newValue)

    function increment() {
        if (root.value < root.maximumValue) {
            var newValue = root.value + root.stepSize;
            newValue = Math.round(newValue * 100) / 100; // Round to two decimal places
            root.value = newValue; // Directly set the new value
            root.myValueChanged(newValue); // Emit the custom signal
        }
    }

    function decrement() {
        if (root.value > root.minimumValue) {
            var newValue = root.value - root.stepSize;
            newValue = Math.round(newValue * 100) / 100; // Round to two decimal places
            root.value = newValue; // Directly set the new value
            root.myValueChanged(newValue); // Emit the custom signal
        }
    }

    // Text Field
    TextField {
        id: textField
        anchors { top: parent.top; left: minusButton.right; right: plusButton.left; bottom: parent.bottom }
        text: root.value.toFixed(2) // Display value with 2 decimal places
        color: "white"
        font.bold: true
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        opacity: 0.8
        background: Rectangle {
            color: "black"
            opacity: 0.25
        }
        inputMethodHints: Qt.ImhFormattedNumbersOnly // Hint to only accept numbers

        onEditingFinished: {
            let newValue = parseFloat(text); // Use parseFloat instead of parseInt
            if (!isNaN(newValue) && newValue >= minimumValue && newValue <= maximumValue) {
                newValue = Math.round(newValue * 100) / 100; // Round to two decimal places
                root.value = newValue;
                myValueChanged(root.value); // Emit the custom signal
            } else {
                text = root.value.toFixed(2); // Reset to the last valid value
            }
        }
    }

    // Minus Button
    Rectangle {
        id: minusButton
        width: 15
        height: root.height
        color: "#BEBEBE"
        opacity: 0.5
        anchors.left: parent.left

        MouseArea {
            anchors.fill: parent
            onClicked: decrement()
        }

        Label {
            text: "-"
            anchors.centerIn: parent
            color: "black"
        }
    }

    // Plus Button
    Rectangle {
        id: plusButton
        width: 15
        height: root.height
        color: "#BEBEBE"
        opacity: 0.5
        anchors.right: parent.right

        MouseArea {
            anchors.fill: parent
            onClicked: increment()
        }

        Label {
            text: "+"
            anchors.centerIn: parent
            color: "black"
        }
    }

    Connections {
        target: root
        onMyValueChanged: function(newValue){
            textField.text = newValue.toFixed(2);
        }
    }
}
