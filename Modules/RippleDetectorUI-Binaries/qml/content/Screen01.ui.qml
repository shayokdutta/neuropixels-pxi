
/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.qml files.
*/
import QtQuick 6.5
import QtQuick.Controls 6.5
import RippleDetectorUI
//import QtCharts 2.6
import QtQuick.Layouts

import QtQuick.Studio.MultiText
import QtQuick.Studio.Components

Rectangle {
    id: rectangle
    width: 725
    height: 660
    anchors.fill: parent
    color: "#ffffff"
    border.color: "#616161"
    gradient: Gradient {
        GradientStop {
            position: 0
            color: "#00ac00"
        }

        GradientStop {
            position: 0.78995
            color: "#ed000000"
        }
        orientation: Gradient.Vertical
    }

//    property alias tableViewArea: tableViewPlaceholder

    Frame {
        id: frame
        anchors.fill: parent
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        padding: 0

        ColumnLayout {
            id: columnLayout2
            anchors.fill: parent
            spacing: 0

            Text {
                id: text_title
                width: 465
                height: 35
                color: "#ffffff"
                text: "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n<html><head><meta name=\"qrichtext\" content=\"1\" /><meta charset=\"utf-8\" /><style type=\"text/css\">\np, li { white-space: pre-wrap; }\nhr { height: 1px; border-width: 0; }\nli.unchecked::marker { content: \"\\2610\"; }\nli.checked::marker { content: \"\\2612\"; }\n</style></head><body style=\" font-family:'Ubuntu'; font-size:10pt; font-weight:400; font-style:normal;\">\n<p align=\"center\" style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:1; text-indent:0px;\"><span style=\" font-family:'Universalis ADF Std'; font-size:20pt;\">Sh'RippleDetector --- Postdoc Edition</span></p></body></html>"
                font.pixelSize: 12
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                Layout.fillHeight: true
                Layout.fillWidth: true
                bottomPadding: 2
                topPadding: 4
                transformOrigin: Item.TopLeft
                textFormat: Text.RichText
                styleColor: "#eaeaea"
            }

            Frame {
                id: frame2
                width: 200
                height: 515
                Layout.fillHeight: true
                Layout.fillWidth: true
                padding: 0

                ColumnLayout {
                    id: columnLayout3
                    anchors.fill: parent
                    Layout.fillHeight: true
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    transformOrigin: Item.Bottom
                    spacing: 0
                    Layout.fillWidth: true

                    Frame {
                        id: frame3
                        height: 0
                        padding: 1
                        Layout.fillWidth: true

                        RowLayout {
                            id: rowLayout
                            anchors.fill: parent
                            spacing: 0

                            Frame {
                                id: frame_trainingSetup
                                width: 200
                                height: 200
                                Layout.fillHeight: true
                                padding: 0
                                rightPadding: 0
                                leftPadding: 0
                                bottomPadding: 0
                                topPadding: 0
                                Layout.fillWidth: true

                                ColumnLayout {
                                    id: columnLayout4
                                    anchors.fill: parent

                                    Frame {
                                        id: frame_chanSelection
                                        objectName: "frame_chanSelection"
                                        width: 200
                                        height: 200
                                        padding: 0
                                        Layout.fillWidth: true
                                        Layout.fillHeight: true

                                        ColumnLayout {
                                            id: columnLayout_chanSelection
                                            anchors.fill: parent
                                            spacing: 0

                                            Text {
                                                id: text_channelSelection
                                                width: 190
                                                height: 29
                                                color: "#ffffff"
                                                text: "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n<html><head><meta name=\"qrichtext\" content=\"1\" /><meta charset=\"utf-8\" /><style type=\"text/css\">\np, li { white-space: pre-wrap; }\nhr { height: 1px; border-width: 0; }\nli.unchecked::marker { content: \"\\2610\"; }\nli.checked::marker { content: \"\\2612\"; }\n</style></head><body style=\" font-family:'Ubuntu'; font-size:10pt; font-weight:400; font-style:normal;\">\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'Universalis ADF Std'; font-size:15pt;\">Channel Selection</span></p></body></html>"
                                                font.pixelSize: 12
                                                horizontalAlignment: Text.AlignHCenter
                                                Layout.fillHeight: false
                                                bottomPadding: 2
                                                topPadding: 4
                                                Layout.fillWidth: true
                                                textFormat: Text.RichText
                                            }
                                            TableViewComponent {
                                                    id: tableViewComponent
                                                    Layout.fillHeight: true
                                                    Layout.fillWidth: true
                                                    model: channelSelectionModel // Bind the model
                                            }
                                        }
                                    }

                                    Frame {
                                        id: frame_trainingParams
                                        width: 200
                                        height: 200
                                        topPadding: 3
                                        bottomPadding: 5
                                        padding: 0
                                        Layout.fillWidth: true

                                        ColumnLayout {
                                            id: columnLayout7
                                            anchors.fill: parent

                                            Text {
                                                id: text_trainingParams
                                                color: "#ffffff"
                                                text: "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n<html><head><meta name=\"qrichtext\" content=\"1\" /><meta charset=\"utf-8\" /><style type=\"text/css\">\np, li { white-space: pre-wrap; }\nhr { height: 1px; border-width: 0; }\nli.unchecked::marker { content: \"\\2610\"; }\nli.checked::marker { content: \"\\2612\"; }\n</style></head><body style=\" font-family:'Ubuntu'; font-size:10pt; font-weight:400; font-style:normal;\">\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'Universalis ADF Std'; font-size:15pt;\">Trainng Parameters</span></p></body></html>"
                                                font.pixelSize: 10
                                                horizontalAlignment: Text.AlignHCenter
                                                textFormat: Text.RichText
                                                rightPadding: 0
                                                Layout.fillWidth: true
                                            }

                                            RowLayout {
                                                id: rowLayout_TrainButtons
                                                width: 100
                                                height: 100
                                                Layout.fillWidth: true

//                                                Button {
//                                                    id: button_SetChannels
//                                                    width: 500
//                                                    height: 15
//                                                    opacity: 0.79
//                                                    visible: true
//                                                    text: "Set Channels"
//                                                    transformOrigin: Item.TopLeft
//                                                    topPadding: 0
//                                                    spacing: 6
//                                                    rightPadding: 0
//                                                    padding: 0
//                                                    leftPadding: 0
//                                                    icon.width: 10
//                                                    icon.height: 10
//                                                    highlighted: true
//                                                    font.pointSize: 8
//                                                    flat: true
//                                                    display: AbstractButton.TextBesideIcon
//                                                    clip: false
//                                                    bottomPadding: 0
//                                                    Layout.fillWidth: true
//                                                    Layout.fillHeight: false
//                                                    Layout.alignment: Qt.AlignHCenter
//                                                                      | Qt.AlignVCenter
//                                                    onClicked: {
//                                                        channelSelectionModel.setChannels();
//                                                    }
//                                                }
                                                Text {
                                                    id: text_SetChannels
                                                    color: "#ffffff"
                                                    text: "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n<html><head><meta name=\"qrichtext\" content=\"1\" /><meta charset=\"utf-8\" /><style type=\"text/css\">\np, li { white-space: pre-wrap; }\nhr { height: 1px; border-width: 0; }\nli.unchecked::marker { content: \"\\2610\"; }\nli.checked::marker { content: \"\\2612\"; }\n</style></head><body style=\" font-family:'Ubuntu'; font-size:10pt; font-weight:400; font-style:normal;\">\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'Universalis ADF Std'; font-size:12pt;\">Set Channels</span></p></body></html>"
                                                    font.pixelSize: 10
                                                    horizontalAlignment: Text.AlignHCenter
                                                    textFormat: Text.RichText
                                                    rightPadding: 0
                                                    Layout.fillWidth: false
                                                }

                                                Switch {
                                                    id: switch_SetChannels
                                                    width: 500
                                                    height: 40  // Adjusted for typical switch size
                                                    opacity: 0.79
                                                    visible: true

                                                    // Optional: Text label next to the switch
                                                    // Note: Switch doesn't have a 'text' property like Button

                                                    // Switch specific properties
                                                    onToggled: {
                                                        if (checked) {  // Execute when the switch is turned on
                                                            channelSelectionModel.setChannels();
                                                            console.log("Channels set for ripple detection!")
                                                        } else {
                                                            channelSelectionModel.restoreChannels(); // let's get the table reset.
                                                            console.log("All channels restored. Please set channels again for ripple detection!")
                                                        }
                                                    }

                                                    // Styling (optional)
                                                    // Customize the appearance of the switch as needed
                                                }

                                                Button {
                                                    id: button_TrainLFPStats
                                                    width: 500
                                                    height: 15
                                                    opacity: 0.79
                                                    visible: true
                                                    text: "Train LFP Stats"
                                                    transformOrigin: Item.TopLeft
                                                    topPadding: 0
                                                    spacing: 6
                                                    rightPadding: 0
                                                    padding: 0
                                                    leftPadding: 0
                                                    icon.width: 10
                                                    icon.height: 10
                                                    highlighted: true
                                                    font.pointSize: 8
                                                    flat: true
                                                    display: AbstractButton.TextBesideIcon
                                                    clip: false
                                                    bottomPadding: 0
                                                    Layout.fillWidth: true
                                                    Layout.fillHeight: false
                                                    Layout.alignment: Qt.AlignHCenter
                                                                      | Qt.AlignVCenter
                                                }
                                            }

                                            RowLayout {
                                                id: rowLayout_duration
                                                width: 100
                                                height: 100
                                                spacing: 0
                                                Layout.fillWidth: true

                                                Text {
                                                    id: text_duration
                                                    color: "#ffffff"
                                                    text: "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n<html><head><meta name=\"qrichtext\" content=\"1\" /><meta charset=\"utf-8\" /><style type=\"text/css\">\np, li { white-space: pre-wrap; }\nhr { height: 1px; border-width: 0; }\nli.unchecked::marker { content: \"\\2610\"; }\nli.checked::marker { content: \"\\2612\"; }\n</style></head><body style=\" font-family:'Ubuntu'; font-size:10pt; font-weight:400; font-style:normal;\">\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'Universalis ADF Std'; font-size:12pt;\">Trainng Duration (s)</span></p></body></html>"
                                                    font.pixelSize: 10
                                                    horizontalAlignment: Text.AlignHCenter
                                                    textFormat: Text.RichText
                                                    rightPadding: 0
                                                    Layout.fillWidth: false
                                                }

                                                ShpinBox {
                                                    id: spinBox_trainDuration
                                                    width: 80
                                                    transformOrigin: Item.TopLeft
                                                    value: 1200.00
                                                    minimumValue: 10
                                                    maximumValue: 1000000000
                                                    stepSize: 5
                                                    Layout.margins: 5
                                                    Layout.fillHeight: false
                                                    Layout.fillWidth: true
                                                }
                                            }

                                            RowLayout {
                                                id: rowLayout_timeRemaining
                                                width: 100
                                                height: 100

                                                Text {
                                                    id: text_timeLeft
                                                    color: "#ffffff"
                                                    text: "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n<html><head><meta name=\"qrichtext\" content=\"1\" /><meta charset=\"utf-8\" /><style type=\"text/css\">\np, li { white-space: pre-wrap; }\nhr { height: 1px; border-width: 0; }\nli.unchecked::marker { content: \"\\2610\"; }\nli.checked::marker { content: \"\\2612\"; }\n</style></head><body style=\" font-family:'Ubuntu'; font-size:10pt; font-weight:400; font-style:normal;\">\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'Universalis ADF Std'; font-size:12pt;\">Time Remainng (s)</span></p></body></html>"
                                                    font.pixelSize: 10
                                                    horizontalAlignment: Text.AlignHCenter
                                                    textFormat: Text.RichText
                                                    rightPadding: 0
                                                    Layout.fillWidth: false
                                                }

                                                ProgressBar {
                                                    id: progressBar
                                                    Layout.fillWidth: true
                                                    value: 0.5
                                                }
                                            }
                                        }
                                    }
                                }
                            }

                            Frame {
                                id: frame_RDInterface
                                width: 200
                                height: 200
                                Layout.fillHeight: true
                                padding: 0
                                rightPadding: 0
                                leftPadding: 0
                                bottomPadding: 0
                                topPadding: 0
                                Layout.fillWidth: true

                                ColumnLayout {
                                    id: columnLayout
                                    anchors.fill: parent
                                    spacing: 5

                                    Frame {
                                        id: frame_rd
                                        Layout.fillHeight: false
                                        Layout.fillWidth: true
                                        padding: 0
                                        rightPadding: 0
                                        leftPadding: 0
                                        bottomPadding: 0
                                        topPadding: 0

                                        ColumnLayout {
                                            id: columnLayout1
                                            x: 0
                                            y: 0
                                            width: 100
                                            height: 100
                                            anchors.left: parent.left
                                            anchors.right: parent.right
                                            anchors.top: parent.top
                                            anchors.bottom: parent.bottom
                                            anchors.rightMargin: 0
                                            anchors.bottomMargin: 0
                                            anchors.leftMargin: 0
                                            anchors.topMargin: 0
                                            spacing: 5

                                            Frame {
                                                id: frame_RDParams
                                                width: 200
                                                height: 200
                                                bottomPadding: 5
                                                padding: 0
                                                Layout.fillWidth: true

                                                ColumnLayout {
                                                    id: columnLayout6
                                                    anchors.fill: parent

                                                    Text {
                                                        id: text_RDParams
                                                        color: "#ffffff"
                                                        text: "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n<html><head><meta name=\"qrichtext\" content=\"1\" /><meta charset=\"utf-8\" /><style type=\"text/css\">\np, li { white-space: pre-wrap; }\nhr { height: 1px; border-width: 0; }\nli.unchecked::marker { content: \"\\2610\"; }\nli.checked::marker { content: \"\\2612\"; }\n</style></head><body style=\" font-family:'Ubuntu'; font-size:10pt; font-weight:400; font-style:normal;\">\n<p align=\"center\" style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'Universalis ADF Std'; font-size:15pt;\">Ripple Detection Parameters</span></p></body></html>"
                                                        font.pixelSize: 12
                                                        horizontalAlignment: Text.AlignHCenter
                                                        verticalAlignment: Text.AlignTop
                                                        bottomPadding: 2
                                                        topPadding: 4
                                                        Layout.fillWidth: true
                                                        transformOrigin: Item.TopLeft
                                                        Layout.alignment: Qt.AlignHCenter
                                                                          | Qt.AlignVCenter
                                                        textFormat: Text.RichText
                                                    }

                                                    RowLayout {
                                                        id: rowLayout2
                                                        Layout.fillWidth: true
                                                        spacing: 5

                                                        Text {
                                                            id: text_detectionThreshold
                                                            color: "#ffffff"
                                                            text: "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n<html><head><meta name=\"qrichtext\" content=\"1\" /><meta charset=\"utf-8\" /><style type=\"text/css\">\np, li { white-space: pre-wrap; }\nhr { height: 1px; border-width: 0; }\nli.unchecked::marker { content: \"\\2610\"; }\nli.checked::marker { content: \"\\2612\"; }\n</style></head><body style=\" font-family:'Ubuntu'; font-size:10pt; font-weight:400; font-style:normal;\">\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'Universalis ADF Std'; font-size:12pt;\">Detection Threshold</span></p></body></html>"
                                                            font.pixelSize: 8
                                                            horizontalAlignment: Text.AlignLeft
                                                            Layout.fillWidth: false
                                                            textFormat: Text.RichText
                                                        }

                                                        ShpinBox {
                                                            id: spinBox_detectionThreshold
                                                            width: 80
                                                            transformOrigin: Item.TopLeft
                                                            value: 3
                                                            stepSize: 0.25
                                                            Layout.margins: 5
                                                            Layout.fillWidth: true
                                                        }

                                                        Text {
                                                            id: text_numChans
                                                            color: "#ffffff"
                                                            text: "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n<html><head><meta name=\"qrichtext\" content=\"1\" /><meta charset=\"utf-8\" /><style type=\"text/css\">\np, li { white-space: pre-wrap; }\nhr { height: 1px; border-width: 0; }\nli.unchecked::marker { content: \"\\2610\"; }\nli.checked::marker { content: \"\\2612\"; }\n</style></head><body style=\" font-family:'Ubuntu'; font-size:10pt; font-weight:400; font-style:normal;\">\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'Universalis ADF Std'; font-size:12pt;\">Number of channels</span></p></body></html>"
                                                            font.pixelSize: 10
                                                            Layout.fillWidth: false
                                                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                                            Layout.fillHeight: false
                                                            textFormat: Text.RichText
                                                        }

                                                        ShpinBox {
                                                            id: spinBox_numChans
                                                            width: 80
                                                            value: 1
                                                            stepSize: 1
                                                            Layout.margins: 5
                                                            Layout.fillWidth: true
                                                            Layout.fillHeight: false
                                                        }
                                                    }

                                                    RowLayout {
                                                        id: rowLayout4
                                                        Layout.fillWidth: true
                                                        spacing: 0

                                                        Text {
                                                            id: text_postStimBlock
                                                            color: "#ffffff"
                                                            text: "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n<html><head><meta name=\"qrichtext\" content=\"1\" /><meta charset=\"utf-8\" /><style type=\"text/css\">\np, li { white-space: pre-wrap; }\nhr { height: 1px; border-width: 0; }\nli.unchecked::marker { content: \"\\2610\"; }\nli.checked::marker { content: \"\\2612\"; }\n</style></head><body style=\" font-family:'Segoe UI'; font-size:9pt; font-weight:400; font-style:normal;\">\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'Universalis ADF Std'; font-size:12pt;\">Post Stim Block (ms)</span></p></body></html>"
                                                            font.pixelSize: 10
                                                            textFormat: Text.RichText
                                                        }

                                                        ShpinBox {
                                                            id: spinBox_postStimBlock
                                                            width: 100
                                                            maximumValue: 1000.00
                                                            value: 100
                                                            stepSize: 1
                                                            Layout.margins: 5
                                                            Layout.fillWidth: false
                                                            Layout.fillHeight: false
                                                        }

                                                        Text {
                                                            id: text_maxStimRate
                                                            color: "#ffffff"
                                                            text: "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n<html><head><meta name=\"qrichtext\" content=\"1\" /><meta charset=\"utf-8\" /><style type=\"text/css\">\np, li { white-space: pre-wrap; }\nhr { height: 1px; border-width: 0; }\nli.unchecked::marker { content: \"\\2610\"; }\nli.checked::marker { content: \"\\2612\"; }\n</style></head><body style=\" font-family:'Segoe UI'; font-size:9pt; font-weight:400; font-style:normal;\">\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'Universalis ADF Std'; font-size:12pt;\">Max Stim Rate (Hz)</span></p></body></html>"
                                                            font.pixelSize: 10
                                                            textFormat: Text.RichText
                                                        }

                                                        ShpinBox {
                                                            id: spinBox_maxStimRate
                                                            width: 100
                                                            stepSize: 1
                                                            Layout.margins: 5
                                                            Layout.fillWidth: true
                                                            Layout.fillHeight: false
                                                        }
                                                    }

                                                    Button {
                                                        id: button_updateParams
                                                        width: 500
                                                        height: 15
                                                        opacity: 0.79
                                                        visible: true
                                                        text: "Update Parameters"
                                                        spacing: 6
                                                        clip: false
                                                        Layout.fillHeight: false
                                                        icon.width: 10
                                                        padding: 0
                                                        rightPadding: 0
                                                        leftPadding: 0
                                                        bottomPadding: 0
                                                        topPadding: 0
                                                        font.pointSize: 8
                                                        icon.height: 10
                                                        highlighted: true
                                                        flat: true
                                                        display: AbstractButton.TextBesideIcon
                                                        transformOrigin: Item.TopLeft
                                                        Layout.alignment: Qt.AlignHCenter
                                                                          | Qt.AlignVCenter
                                                        Layout.fillWidth: true
                                                    }
                                                }
                                            }

                                            Frame {
                                                id: frame_specialStim
                                                width: 200
                                                height: 200
                                                topPadding: 3
                                                padding: 0
                                                Layout.fillWidth: true
                                                Layout.fillHeight: false

                                                ColumnLayout {
                                                    id: columnLayout5
                                                    anchors.fill: parent

                                                    Text {
                                                        id: text_specialStim
                                                        color: "#ffffff"
                                                        text: "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n<html><head><meta name=\"qrichtext\" content=\"1\" /><meta charset=\"utf-8\" /><style type=\"text/css\">\np, li { white-space: pre-wrap; }\nhr { height: 1px; border-width: 0; }\nli.unchecked::marker { content: \"\\2610\"; }\nli.checked::marker { content: \"\\2612\"; }\n</style></head><body style=\" font-family:'Ubuntu'; font-size:10pt; font-weight:400; font-style:normal;\">\n<p align=\"center\" style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'Universalis ADF Std'; font-size:15pt;\">Special Stim Parameters</span></p></body></html>"
                                                        font.pixelSize: 10
                                                        horizontalAlignment: Text.AlignHCenter
                                                        bottomPadding: 2
                                                        topPadding: 4
                                                        Layout.fillWidth: true
                                                        Layout.alignment: Qt.AlignHCenter
                                                                          | Qt.AlignVCenter
                                                        textFormat: Text.RichText
                                                    }

                                                    RowLayout {
                                                        id: rowLayout_ControlStim
                                                        Layout.fillHeight: true
                                                        Layout.fillWidth: true
                                                        spacing: 0

                                                        CheckBox {
                                                            id: checkBox
                                                            height: 15
                                                            opacity: 0.5
                                                            text: qsTr("")
                                                            bottomPadding: 4
                                                            Layout.fillWidth: true
                                                            padding: 1
                                                            display: AbstractButton.IconOnly
                                                        }

                                                        Text {
                                                            id: text_numChans5
                                                            color: "#ffffff"
                                                            text: "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n<html><head><meta name=\"qrichtext\" content=\"1\" /><meta charset=\"utf-8\" /><style type=\"text/css\">\np, li { white-space: pre-wrap; }\nhr { height: 1px; border-width: 0; }\nli.unchecked::marker { content: \"\\2610\"; }\nli.checked::marker { content: \"\\2612\"; }\n</style></head><body style=\" font-family:'Ubuntu'; font-size:10pt; font-weight:400; font-style:normal;\">\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'Universalis ADF Std'; font-size:12pt;\">Control Stim Delay (ms)</span></p></body></html>"
                                                            font.pixelSize: 10
                                                            Layout.fillWidth: true
                                                            rightPadding: 50
                                                            textFormat: Text.RichText
                                                        }

                                                        ShpinBox {
                                                            id: spinBox_controlStim
                                                            width: 100
                                                            value: 200
                                                            minimumValue: 200
                                                            maximumValue: 1000
                                                            stepSize: 10
                                                            Layout.margins: 5
                                                            Layout.fillWidth: true
                                                            Layout.fillHeight: false
                                                        }
                                                    }

                                                    RowLayout {
                                                        id: rowLayout_LRD
                                                        Layout.fillWidth: true
                                                        Layout.fillHeight: true
                                                        spacing: 0

                                                        CheckBox {
                                                            id: checkBox_LRD
                                                            height: 15
                                                            opacity: 0.5
                                                            bottomPadding: 4
                                                            padding: 1
                                                            display: AbstractButton.IconOnly
                                                        }

                                                        Text {
                                                            id: text_numChans6
                                                            color: "#ffffff"
                                                            text: "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n<html><head><meta name=\"qrichtext\" content=\"1\" /><meta charset=\"utf-8\" /><style type=\"text/css\">\np, li { white-space: pre-wrap; }\nhr { height: 1px; border-width: 0; }\nli.unchecked::marker { content: \"\\2610\"; }\nli.checked::marker { content: \"\\2612\"; }\n</style></head><body style=\" font-family:'Ubuntu'; font-size:10pt; font-weight:400; font-style:normal;\">\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'Universalis ADF Std'; font-size:12pt;\">Enable Long </span></p>\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'Universalis ADF Std'; font-size:12pt;\">Ripple Detection</span></p></body></html>"
                                                            font.pixelSize: 10
                                                            bottomPadding: 3
                                                            rightPadding: 10
                                                            textFormat: Text.RichText
                                                        }

                                                        Text {
                                                            id: text_numChans7
                                                            color: "#ffffff"
                                                            text: "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n<html><head><meta name=\"qrichtext\" content=\"1\" /><meta charset=\"utf-8\" /><style type=\"text/css\">\np, li { white-space: pre-wrap; }\nhr { height: 1px; border-width: 0; }\nli.unchecked::marker { content: \"\\2610\"; }\nli.checked::marker { content: \"\\2612\"; }\n</style></head><body style=\" font-family:'Ubuntu'; font-size:10pt; font-weight:400; font-style:normal;\">\n<p align=\"justify\" style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'Universalis ADF Std'; font-size:12pt;\">Long Ripple Time </span></p>\n<p align=\"justify\" style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'Universalis ADF Std'; font-size:12pt;\">Thresh (ms)</span></p></body></html>"
                                                            font.pixelSize: 10
                                                            bottomPadding: 3
                                                            Layout.fillWidth: false
                                                            textFormat: Text.RichText
                                                        }

                                                        ShpinBox {
                                                            id: spinBox_LRD
                                                            width: 100
                                                            value: 10
                                                            minimumValue: 5
                                                            maximumValue: 50
                                                            stepSize: 1
                                                            Layout.margins: 5
                                                            Layout.fillWidth: true
                                                            Layout.fillHeight: false
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }

                                    Frame {
                                        id: frame_ttl
                                        visible: true
                                        Layout.fillHeight: true
                                        Layout.fillWidth: true
                                        padding: 0
                                        rightPadding: 0
                                        leftPadding: 0
                                        bottomPadding: 0
                                        topPadding: 0

                                        ColumnLayout {
                                            id: columnLayout_ttl
                                            anchors.fill: parent
                                            spacing: 0

                                            Frame {
                                                id: frame_connection
                                                width: 200
                                                bottomPadding: 5
                                                Layout.fillHeight: true
                                                //                                                height: 200
                                                Layout.fillWidth: true
                                                padding: 0

                                                ColumnLayout {
                                                    id: columnLayout_connection
                                                    anchors.fill: parent
                                                    spacing: 5

                                                    Text {
                                                        id: text_TTLInterface
                                                        color: "#ffffff"
                                                        text: "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n<html><head><meta name=\"qrichtext\" content=\"1\" /><meta charset=\"utf-8\" /><style type=\"text/css\">\np, li { white-space: pre-wrap; }\nhr { height: 1px; border-width: 0; }\nli.unchecked::marker { content: \"\\2610\"; }\nli.checked::marker { content: \"\\2612\"; }\n</style></head><body style=\" font-family:'Ubuntu'; font-size:10pt; font-weight:400; font-style:normal;\">\n<p align=\"center\" style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'Universalis ADF Std'; font-size:15pt;\">TTL Interface</span></p></body></html>"
                                                        font.pixelSize: 12
                                                        horizontalAlignment: Text.AlignHCenter
                                                        Layout.fillWidth: true
                                                        topPadding: 5
                                                        textFormat: Text.RichText
                                                    }

                                                    RowLayout {
                                                        id: rowLayout3
                                                        width: 100
                                                        height: 100
                                                        Layout.fillWidth: true

                                                        TextField {
                                                            id: textField_address
                                                            text: "udp://192.168.x.x:xxxx"
                                                            horizontalAlignment: Text.AlignHCenter
                                                            Layout.fillHeight: false
                                                            Layout.fillWidth: true
                                                            placeholderText: qsTr("udp://192.168.x.x:xxxx")
                                                            color: "white" // This sets the text color to white
                                                            opacity: 0.65
                                                            visible: true

                                                            // Define the background color and opacity
                                                            background: Rectangle {
                                                                color: "red" // Background color
                                                                opacity: 0.4 // Opacity of the background
                                                                anchors.fill: parent // This ensures the background fills the TextField
                                                            }
                                                        }
                                                        Text {
                                                            id: text_connectionStatus
                                                            text: "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n<html><head><meta name=\"qrichtext\" content=\"1\" /><meta charset=\"utf-8\" /><style type=\"text/css\">\np, li { white-space: pre-wrap; }\nhr { height: 1px; border-width: 0; }\nli.unchecked::marker { content: \"\\2610\"; }\nli.checked::marker { content: \"\\2612\"; }\n</style></head><body style=\" font-family:'Ubuntu'; font-size:10pt; font-weight:400; font-style:normal;\">\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'Universalis ADF Std'; font-size:12pt; color:#cc0000;\">Not Connected!</span></p></body></html>"
                                                            font.pixelSize: 12
                                                            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                                            Layout.fillWidth: false
                                                            textFormat: Text.RichText
                                                        }
                                                    }

                                                    RowLayout {
                                                        id: rowLayout_testStim
                                                        width: 100
                                                        height: 100
                                                        Layout.fillWidth: true

                                                        Text {
                                                            id: text_StimDuration
                                                            text: "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n<html><head><meta name=\"qrichtext\" content=\"1\" /><meta charset=\"utf-8\" /><style type=\"text/css\">\np, li { white-space: pre-wrap; }\nhr { height: 1px; border-width: 0; }\nli.unchecked::marker { content: \"\\2610\"; }\nli.checked::marker { content: \"\\2612\"; }\n</style></head><body style=\" font-family:'Ubuntu'; font-size:10pt; font-weight:400; font-style:normal;\">\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'Universalis ADF Std'; font-size:12pt; color:#ffffff;\">Stim Duration Per Phase (</span><span style=\" font-family:'Universalis ADF Std'; font-size:12pt; font-weight:500; color:#ffffff;\">μ</span><span style=\" font-family:'Universalis ADF Std'; font-size:12pt; color:#ffffff;\">s)</span></p></body></html>"
                                                            font.pixelSize: 12
                                                            textFormat: Text.RichText
                                                            Layout.fillWidth: false
                                                        }

                                                        ShpinBox {
                                                            id: spinBox_stimPulse
                                                            width: 100
                                                            value: 60
                                                            stepSize: 5
                                                            minimumValue: 30
                                                            maximumValue: 200
                                                            Layout.margins: 5
                                                            Layout.fillWidth: true
                                                            Layout.fillHeight: false
                                                        }

                                                        Button {
                                                            id: button_stim
                                                            height: 15
                                                            opacity: 0.79
                                                            visible: true
                                                            text: "Test Stim"
                                                            transformOrigin: Item.TopLeft
                                                            topPadding: 0
                                                            rightPadding: 0
                                                            padding: 0
                                                            leftPadding: 0
                                                            icon.width: 10
                                                            icon.height: 10
                                                            highlighted: true
                                                            font.pointSize: 8
                                                            flat: true
                                                            display: AbstractButton.TextBesideIcon
                                                            clip: false
                                                            bottomPadding: 0
                                                            Layout.fillWidth: true
                                                            Layout.fillHeight: false
                                                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }

                    Frame {
                        id: frame_rbf
                        height: 75
                        Layout.minimumHeight: 75
                        padding: 5
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        //                        ChartView {
                        //                            id: line_rbf
                        //                            x: -12
                        //                            y: -236
                        //                            width: 300
                        //                            height: 300
                        //                            anchors.left: parent.left
                        //                            anchors.right: parent.right
                        //                            anchors.top: parent.top
                        //                            anchors.bottom: parent.bottom
                        //                            backgroundColor: "#00000000"
                        //                            legend.visible: false
                        //                            title: "moo"

                        //                            // Custom title using Text item
                        //                            Text {
                        //                                text: "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n<html><head><meta name=\"qrichtext\" content=\"1\" /><meta charset=\"utf-8\" /><style type=\"text/css\">\np, li { white-space: pre-wrap; }\nhr { height: 1px; border-width: 0; }\nli.unchecked::marker { content: \"\\2610\"; }\nli.checked::marker { content: \"\\2612\"; }\n</style></head><body style=\" font-family:'Ubuntu'; font-size:10pt; font-weight:400; font-style:normal;\">\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'Universalis ADF Std'; font-size:15pt;\">Ripple band filtered</span></p></body></html>"
                        //                                color: "white" // Set the color of the title
                        //                                anchors.top: parent.top
                        //                                anchors.left: parent.left
                        //                                anchors.margins: 10 // Adjust the margin as needed
                        //                                font.pixelSize: 18
                        //                                textFormat: Text.RichText // Adjust font size as needed
                        //                            }
                        //                            ValuesAxis {
                        //                                id: axisX
                        //                                gridVisible: false
                        //                                visible: false
                        //                            }
                        //                            ValuesAxis {
                        //                                id: axisY
                        //                                gridVisible: false
                        //                                visible: false
                        //                            }
                        //                            LineSeries {
                        //                                axisX: axisX
                        //                                axisY: axisY
                        //                                XYPoint {
                        //                                    x: 0
                        //                                    y: 2
                        //                                }

                        //                                XYPoint {
                        //                                    x: 1
                        //                                    y: 1.2
                        //                                }

                        //                                XYPoint {
                        //                                    x: 2
                        //                                    y: 3.3
                        //                                }

                        //                                XYPoint {
                        //                                    x: 5
                        //                                    y: 2.1
                        //                                }
                        //                            }
                        //                        }
                    }

                    Frame {
                        id: frame_envelope
                        padding: 5
                        Layout.minimumHeight: 75
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        //                        ChartView {
                        //                            id: line_envelope
                        //                            x: -12
                        //                            y: -160
                        //                            visible: true
                        //                            anchors.fill: parent
                        //                            backgroundColor: "#00000000"
                        //                            legend.visible: false

                        //                            // Custom title using Text item
                        //                            Text {
                        //                                text: "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n<html><head><meta name=\"qrichtext\" content=\"1\" /><meta charset=\"utf-8\" /><style type=\"text/css\">\np, li { white-space: pre-wrap; }\nhr { height: 1px; border-width: 0; }\nli.unchecked::marker { content: \"\\2610\"; }\nli.checked::marker { content: \"\\2612\"; }\n</style></head><body style=\" font-family:'Ubuntu'; font-size:10pt; font-weight:400; font-style:normal;\">\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'Universalis ADF Std'; font-size:15pt;\">Estimated Envelope</span></p></body></html>"
                        //                                color: "white" // Set the color of the title
                        //                                anchors.top: parent.top
                        //                                anchors.left: parent.left
                        //                                anchors.margins: 10 // Adjust the margin as needed
                        //                                font.pixelSize: 18
                        //                                textFormat: Text.RichText // Adjust font size as needed
                        //                            }
                        //                            ValuesAxis {
                        //                                id: axisXX
                        //                                gridVisible: false
                        //                                visible: false
                        //                            }
                        //                            ValuesAxis {
                        //                                id: axisYY
                        //                                gridVisible: false
                        //                                visible: false
                        //                            }
                        //                            LineSeries {
                        //                                axisX: axisXX
                        //                                axisY: axisYY
                        //                                XYPoint {
                        //                                    x: 0
                        //                                    y: 2
                        //                                }

                        //                                XYPoint {
                        //                                    x: 1
                        //                                    y: 1.2
                        //                                }

                        //                                XYPoint {
                        //                                    x: 2
                        //                                    y: 3.3
                        //                                }

                        //                                XYPoint {
                        //                                    x: 5
                        //                                    y: 2.1
                        //                                }
                        //                            }
                        //                        }
                    }
                }
            }
        }
    }

    states: [
        State {
            name: "clicked"
        }
    ]
}
