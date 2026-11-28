import qs.services
import qs.modules.common
import qs.modules.common.widgets
import qs.modules.common.functions
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell

Item {
    id: root
    property int messageIndex
    property var messageData
    property var messageInputField

    readonly property bool isUser: messageData?.role === "user"
    readonly property bool isAssistant: messageData?.role === "assistant"
    readonly property bool isInterface: messageData?.role === "interface"

    property real messagePadding: isUser ? 12 : 8
    property real contentSpacing: 6

    property bool enableMouseSelection: false
    property bool renderMarkdown: true
    property bool editing: false

    property list<var> messageBlocks: StringUtils.splitMarkdownBlocks(root.messageData?.content)

    anchors.left: parent?.left
    anchors.right: parent?.right
    implicitHeight: bubble.implicitHeight

    function saveMessage() {
        if (!root.editing) return;
        const segments = messageContentColumnLayout.children
            .map(child => child.segment)
            .filter(segment => (segment));

        const newContent = segments.map(segment => {
            if (segment.type === "code") {
                const lang = segment.lang ? segment.lang : "";
                const code = segment.content.replace(/\n+$/, "");
                return "```" + lang + "\n" + code + "\n```";
            } else {
                return segment.content;
            }
        }).join("");

        root.editing = false;
        root.messageData.content = newContent;
    }

    Keys.onPressed: (event) => {
        if (
            event.key === Qt.Key_Control ||
            event.key == Qt.Key_Shift ||
            event.key == Qt.Key_Alt ||
            event.key == Qt.Key_Meta
        ) {
            event.accepted = true;
        }
        if ((event.key === Qt.Key_S) && event.modifiers == Qt.ControlModifier) {
            root.saveMessage();
            event.accepted = true;
        }
    }

    HoverHandler {
        id: hoverHandler
    }

    TextMetrics {
        id: userTextMetrics
        font.pixelSize: Appearance.font.pixelSize.normal
        text: root.isUser ? (root.messageData?.rawContent ?? "") : ""
    }

    Rectangle {
        id: bubble
        anchors.right: parent.right
        width: root.isUser
            ? Math.min(parent.width * 0.84, Math.max(64, userTextMetrics.width + root.messagePadding * 2 + 16))
            : parent.width
        implicitHeight: columnLayout.implicitHeight + root.messagePadding * 2

        radius: root.isUser ? Appearance.rounding.normal : Appearance.rounding.small
        color: root.isUser ? Appearance.colors.colSecondaryContainer
            : root.isInterface ? Appearance.colors.colLayer1
            : "transparent"

            ColumnLayout {
                id: columnLayout
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.margins: root.messagePadding
                spacing: root.contentSpacing

                RowLayout {
                    id: headerRowLayout
                    visible: !root.isUser
                    Layout.fillWidth: true
                    spacing: 6

                    CustomIcon {
                        id: modelIcon
                        visible: root.isAssistant && (Ai.models[messageData?.model]?.icon ?? "") !== ""
                        width: Appearance.font.pixelSize.small
                        height: Appearance.font.pixelSize.small
                        source: root.isAssistant ? (Ai.models[messageData?.model]?.icon ?? "") : "desktop-symbolic"
                        colorize: true
                        color: Appearance.colors.colSubtext
                    }

                    MaterialSymbol {
                        visible: !modelIcon.visible
                        iconSize: Appearance.font.pixelSize.normal
                        color: Appearance.colors.colSubtext
                        text: root.isInterface ? "info" : "neurology"
                    }

                    StyledText {
                        Layout.fillWidth: true
                        elide: Text.ElideRight
                        font.pixelSize: Appearance.font.pixelSize.small
                        color: Appearance.colors.colSubtext
                        text: root.isAssistant ? (Ai.models[messageData?.model]?.name ?? "Assistant") : Translation.tr("System")
                    }

                    RowLayout {
                        spacing: 2
                        opacity: (hoverHandler.hovered || root.editing) ? 1 : 0
                        Behavior on opacity {
                            animation: Appearance.animation.elementMoveFast.numberAnimation.createObject(this)
                        }

                        AiMessageControlButton {
                            id: regenButton
                            buttonIcon: "refresh"
                            visible: root.isAssistant
                            onClicked: Ai.regenerate(root.messageIndex)
                            StyledToolTip { text: Translation.tr("Regenerate") }
                        }
                        AiMessageControlButton {
                            id: copyButton
                            buttonIcon: activated ? "inventory" : "content_copy"
                            onClicked: {
                                Quickshell.clipboardText = root.messageData?.content;
                                copyButton.activated = true;
                                copyIconTimer.restart();
                            }
                            Timer {
                                id: copyIconTimer
                                interval: 1500
                                repeat: false
                                onTriggered: copyButton.activated = false
                            }
                            StyledToolTip { text: Translation.tr("Copy") }
                        }
                        AiMessageControlButton {
                            id: editButton
                            activated: root.editing
                            enabled: root.messageData?.done ?? false
                            buttonIcon: "edit"
                            onClicked: {
                                root.editing = !root.editing;
                                if (!root.editing) root.saveMessage();
                            }
                            StyledToolTip { text: root.editing ? Translation.tr("Save") : Translation.tr("Edit") }
                        }
                        AiMessageControlButton {
                            id: toggleMarkdownButton
                            activated: !root.renderMarkdown
                            buttonIcon: "code"
                            visible: root.isAssistant
                            onClicked: root.renderMarkdown = !root.renderMarkdown
                            StyledToolTip { text: Translation.tr("View Markdown source") }
                        }
                        AiMessageControlButton {
                            id: deleteButton
                            buttonIcon: "close"
                            onClicked: Ai.removeMessage(root.messageIndex)
                            StyledToolTip { text: Translation.tr("Delete") }
                        }
                    }
                }

                Loader {
                    Layout.fillWidth: true
                    active: root.messageData?.localFilePath && root.messageData?.localFilePath.length > 0
                    sourceComponent: AttachedFileIndicator {
                        filePath: root.messageData?.localFilePath
                        canRemove: false
                    }
                }

                ColumnLayout {
                    id: messageContentColumnLayout
                    Layout.fillWidth: true
                    spacing: 0

                    Item {
                        Layout.fillWidth: true
                        implicitHeight: loadingIndicatorLoader.shown ? loadingIndicatorLoader.implicitHeight : 0
                        implicitWidth: loadingIndicatorLoader.implicitWidth
                        visible: implicitHeight > 0

                        Behavior on implicitHeight {
                            animation: Appearance.animation.elementMove.numberAnimation.createObject(this)
                        }
                        FadeLoader {
                            id: loadingIndicatorLoader
                            anchors.centerIn: parent
                            shown: (root.messageBlocks.length < 1) && (!root.messageData.done)
                            sourceComponent: MaterialLoadingIndicator {
                                loading: true
                            }
                        }
                    }
                    Repeater {
                        model: ScriptModel {
                            values: root.messageBlocks
                        }
                        delegate: DelegateChooser {
                            id: messageDelegate
                            role: "type"

                            DelegateChoice { roleValue: "code"; MessageCodeBlock {
                                editing: root.editing
                                renderMarkdown: root.renderMarkdown
                                enableMouseSelection: root.enableMouseSelection
                                segmentContent: modelData.content
                                segmentLang: modelData.lang
                                messageData: root.messageData
                            } }
                            DelegateChoice { roleValue: "think"; MessageThinkBlock {
                                editing: root.editing
                                renderMarkdown: root.renderMarkdown
                                enableMouseSelection: root.enableMouseSelection
                                segmentContent: modelData.content
                                messageData: root.messageData
                                done: root.messageData?.done ?? false
                                completed: modelData.completed ?? false
                            } }
                            DelegateChoice { roleValue: "text"; MessageTextBlock {
                                editing: root.editing
                                renderMarkdown: root.renderMarkdown
                                enableMouseSelection: root.enableMouseSelection
                                segmentContent: modelData.content
                                messageData: root.messageData
                                done: root.messageData?.done ?? false
                                forceDisableChunkSplitting: root.messageData?.content.includes("```") ?? true
                            } }
                        }
                    }
                }

                RowLayout {
                    visible: root.isUser && (hoverHandler.hovered || root.editing)
                    Layout.alignment: Qt.AlignRight
                    spacing: 2

                    AiMessageControlButton {
                        buttonIcon: "content_copy"
                        onClicked: Quickshell.clipboardText = root.messageData?.content
                        StyledToolTip { text: Translation.tr("Copy") }
                    }
                    AiMessageControlButton {
                        activated: root.editing
                        enabled: root.messageData?.done ?? false
                        buttonIcon: "edit"
                        onClicked: {
                            root.editing = !root.editing;
                            if (!root.editing) root.saveMessage();
                        }
                        StyledToolTip { text: root.editing ? Translation.tr("Save") : Translation.tr("Edit") }
                    }
                    AiMessageControlButton {
                        buttonIcon: "close"
                        onClicked: Ai.removeMessage(root.messageIndex)
                        StyledToolTip { text: Translation.tr("Delete") }
                    }
                }

                Flow {
                    visible: root.messageData?.annotationSources?.length > 0
                    spacing: 5
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignLeft

                    Repeater {
                        model: ScriptModel {
                            values: root.messageData?.annotationSources || []
                        }
                        delegate: AnnotationSourceButton {
                            required property var modelData
                            displayText: modelData.text
                            url: modelData.url
                        }
                    }
                }

                Flow {
                    visible: root.messageData?.searchQueries?.length > 0
                    spacing: 5
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignLeft

                    Repeater {
                        model: ScriptModel {
                            values: root.messageData?.searchQueries || []
                        }
                        delegate: SearchQueryButton {
                            required property var modelData
                            query: modelData
                        }
                    }
                }
            }
        }
}
