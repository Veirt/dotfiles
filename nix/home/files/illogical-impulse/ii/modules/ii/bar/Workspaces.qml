import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import qs
import qs.services
import qs.modules.common
import qs.modules.common.widgets

Item {
    id: root

    required property string output
    readonly property var tags: MangoBridge.tagsFor(output)
    property bool vertical: Config.options.bar.vertical

    Layout.alignment: vertical ? Qt.AlignHCenter : Qt.AlignVCenter
    Layout.fillWidth: vertical
    Layout.fillHeight: !vertical

    implicitWidth: pillContainer.implicitWidth
    implicitHeight: Appearance.sizes.barHeight

    Rectangle {
        id: pillContainer
        anchors.centerIn: parent
        implicitWidth: tagsRow.implicitWidth + 8
        implicitHeight: 30
        radius: Appearance.rounding.full
        color: Config.options?.bar.borderless ? "transparent" : Appearance.colors.colLayer1

        RowLayout {
            id: tagsRow
            anchors.centerIn: parent
            spacing: 2

            Repeater {
                model: root.tags.filter(tag => tag.is_active || tag.client_count > 0)

                delegate: Rectangle {
                    id: tagPill
                    required property var modelData
                    readonly property bool selected: modelData.is_active
                    readonly property var tagClients: MangoBridge.clientsFor(root.output, modelData.index)

                    implicitWidth: tagContent.implicitWidth + 14
                    implicitHeight: 24
                    radius: Appearance.rounding.full
                    color: selected
                        ? Appearance.colors.colSecondaryContainer
                        : tagMouseArea.containsMouse
                            ? Appearance.colors.colLayer2Hover
                            : "transparent"

                    Behavior on color {
                        animation: Appearance.animation.elementMoveFast.colorAnimation.createObject(this)
                    }

                    RowLayout {
                        id: tagContent
                        anchors.centerIn: parent
                        spacing: 5

                        StyledText {
                            Layout.alignment: Qt.AlignVCenter
                            text: modelData.index
                            color: tagPill.selected ? Appearance.m3colors.m3onSecondaryContainer : Appearance.colors.colOnLayer1
                            font.pixelSize: Appearance.font.pixelSize.small
                            font.weight: tagPill.selected ? Font.DemiBold : Font.Normal
                        }

                        Repeater {
                            model: tagPill.tagClients

                            delegate: IconImage {
                                required property var modelData
                                Layout.alignment: Qt.AlignVCenter
                                implicitSize: 18
                                source: Quickshell.iconPath(AppSearch.guessIcon(modelData.appid), "image-missing")
                            }
                        }
                    }

                    MouseArea {
                        id: tagMouseArea
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: MangoBridge.viewTag(root.output, tagPill.modelData.index)
                    }
                }
            }
        }
    }
}
