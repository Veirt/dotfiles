import QtQuick
import Quickshell
import Quickshell.Io
import qs
import qs.services
import qs.modules.common
import qs.modules.common.functions
import qs.modules.common.widgets

QuickToggleModel {
    id: root
    property bool isRecording: false
    property string elapsedText: ""
    property bool pendingAudio: false

    name: Translation.tr("Screen record")
    hasStatusText: true
    statusText: isRecording && elapsedText.length > 0 ? elapsedText : Translation.tr("Off")
    toggled: isRecording
    icon: isRecording ? "stop_circle" : "videocam"
    tooltipText: isRecording
        ? Translation.tr("Recording (%1) — click to stop").arg(elapsedText || "00:00")
        : Translation.tr("Left-click: Record | Right-click: Record with audio")

    mainAction: () => {
        if (root.isRecording) {
            Quickshell.execDetached([Quickshell.env("HOME") + "/.local/bin/record"]);
            statusRefreshDelay.restart();
        } else {
            root.pendingAudio = false;
            GlobalStates.sidebarRightOpen = false;
            delayedActionTimer.start();
        }
    }

    altAction: () => {
        if (root.isRecording) {
            Quickshell.execDetached([Quickshell.env("HOME") + "/.local/bin/record"]);
            statusRefreshDelay.restart();
        } else {
            root.pendingAudio = true;
            GlobalStates.sidebarRightOpen = false;
            delayedActionTimer.start();
        }
    }

    Timer {
        id: delayedActionTimer
        interval: 300
        repeat: false
        onTriggered: {
            const cmd = [Quickshell.env("HOME") + "/.local/bin/record"];
            if (root.pendingAudio) cmd.push("audio");
            Quickshell.execDetached(cmd);
            statusRefreshDelay.restart();
        }
    }

    Timer {
        id: statusRefreshDelay
        interval: 1200
        repeat: false
        onTriggered: statusProc.running = true
    }

    Timer {
        interval: 1000
        running: GlobalStates.sidebarRightOpen || root.isRecording
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            if (!statusProc.running) statusProc.running = true;
        }
    }

    Process {
        id: statusProc
        command: [Quickshell.env("HOME") + "/.local/bin/record", "status"]
        stdout: SplitParser {
            onRead: data => {
                if (!data) return;
                try {
                    const info = JSON.parse(data);
                    root.isRecording = info.alt === "recording";
                    root.elapsedText = info.text || "";
                } catch (e) {}
            }
        }
    }
}
