import qs
import qs.services
import qs.modules.common
import qs.modules.common.widgets
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

Item {
    id: root

    property bool runtimeReady: false
    property string runtimeVersion: ""
    property bool loading: false
    property string errorText: ""
    property string sessionFilter: "all" // "all", "active", "done"
    property var sessions: []

    readonly property var filteredSessions: {
        if (sessionFilter === "active") {
            return sessions.filter(s => s.state !== "done");
        } else if (sessionFilter === "done") {
            return sessions.filter(s => s.state === "done");
        }
        return sessions;
    }

    readonly property int activeSessionCount: sessions.filter(s => s.state !== "done").length

    function refresh() {
        if (fetchProc.running) return;
        root.loading = true;
        root.errorText = "";
        fetchProc.running = true;
    }

    function formatRelativeTime(tsMs) {
        if (!tsMs) return "";
        const diffSec = Math.max(0, Math.floor((Date.now() - tsMs) / 1000));
        if (diffSec < 60) return `${diffSec}s`;
        if (diffSec < 3600) return `${Math.floor(diffSec / 60)}m`;
        if (diffSec < 86400) return `${Math.floor(diffSec / 3600)}h`;
        return `${Math.floor(diffSec / 86400)}d`;
    }

    function stateBgColor(state) {
        if (state === "working" || state === "running" || state === "in_progress") return Appearance.colors.colPrimaryContainer;
        if (state === "waiting" || state === "pending") return Appearance.colors.colTertiaryContainer;
        if (state === "failed" || state === "error") return Appearance.colors.colErrorContainer;
        return Appearance.colors.colSecondaryContainer;
    }

    function stateFgColor(state) {
        if (state === "working" || state === "running" || state === "in_progress") return Appearance.colors.colOnPrimaryContainer;
        if (state === "waiting" || state === "pending") return Appearance.colors.colOnTertiaryContainer;
        if (state === "failed" || state === "error") return Appearance.colors.colOnErrorContainer;
        return Appearance.colors.colOnSecondaryContainer;
    }

    Timer {
        interval: 8000
        running: GlobalStates.sidebarLeftOpen
        repeat: true
        triggeredOnStart: true
        onTriggered: root.refresh()
    }

    Process {
        id: fetchProc
        command: ["bash", "-c", `
            export PATH="$HOME/.local/bin:$PATH"
            python3 - <<'PY'
import concurrent.futures, json, shutil, subprocess

orca = shutil.which("orca-ide")
if not orca:
    print(json.dumps({"ok": False, "error": "orca-ide not found in PATH"}))
    raise SystemExit(0)

def run_json(args, timeout=6):
    try:
        p = subprocess.run([orca] + args + ["--json"], capture_output=True, text=True, timeout=timeout)
        if p.returncode != 0 or not p.stdout.strip():
            return None
        return json.loads(p.stdout)
    except Exception:
        return None

with concurrent.futures.ThreadPoolExecutor(max_workers=2) as ex:
    f_status = ex.submit(run_json, ["status"])
    f_agents = ex.submit(run_json, ["agent", "list"])

    status = f_status.result() or {}
    agents_res = f_agents.result() or {}

res = status.get("result", {})
rt = res.get("runtime", {})
ready = bool(status.get("ok") and rt.get("reachable"))
version = rt.get("appVersion", "")

sessions = []
for a in agents_res.get("result", {}).get("agents", []):
    sessions.append({
        "id": a.get("orcaSessionId", ""),
        "agent": a.get("agent", ""),
        "kind": a.get("kind", ""),
        "state": a.get("state", "unknown"),
        "repo": a.get("repo", ""),
        "workspace": a.get("workspace", ""),
        "title": a.get("title", ""),
        "preview": a.get("lastAssistantMessage", ""),
        "updatedAt": a.get("updatedAt", 0),
    })
sessions.sort(key=lambda x: (0 if x["state"] != "done" else 1, -(x["updatedAt"] or 0)))

print(json.dumps({
    "ok": True,
    "ready": ready,
    "version": version,
    "sessions": sessions,
}))
PY
        `]
        stdout: SplitParser {
            onRead: data => {
                if (!data) return;
                try {
                    const parsed = JSON.parse(data);
                    if (!parsed.ok) {
                        root.runtimeReady = false;
                        root.errorText = parsed.error || "Failed to query Orca";
                    } else {
                        root.runtimeReady = parsed.ready;
                        root.runtimeVersion = parsed.version || "";
                        root.sessions = parsed.sessions || [];
                    }
                } catch (e) {
                    root.errorText = "Failed to parse Orca response";
                }
            }
        }
        onExited: root.loading = false
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

        // Runtime header
        Rectangle {
            Layout.fillWidth: true
            implicitHeight: headerRow.implicitHeight + 14
            radius: Appearance.rounding.small
            color: Appearance.colors.colLayer2

            RowLayout {
                id: headerRow
                anchors.fill: parent
                anchors.margins: 7
                spacing: 8

                Rectangle {
                    width: 8
                    height: 8
                    radius: 4
                    color: root.runtimeReady ? Appearance.m3colors.m3success : Appearance.colors.colError
                }

                StyledText {
                    Layout.fillWidth: true
                    font.pixelSize: Appearance.font.pixelSize.normal
                    color: Appearance.colors.colOnLayer2
                    elide: Text.ElideRight
                    text: root.runtimeReady
                        ? Translation.tr("Orca Ready%1").arg(root.runtimeVersion ? ` · v${root.runtimeVersion}` : "")
                        : Translation.tr("Orca Offline")
                }

                RippleButton {
                    implicitWidth: 28
                    implicitHeight: 28
                    buttonRadius: Appearance.rounding.full
                    onClicked: root.refresh()
                    contentItem: MaterialSymbol {
                        anchors.centerIn: parent
                        text: "refresh"
                        iconSize: Appearance.font.pixelSize.normal
                        color: Appearance.colors.colOnLayer2
                    }
                    StyledToolTip { text: Translation.tr("Refresh") }
                }

                RippleButton {
                    implicitWidth: 28
                    implicitHeight: 28
                    buttonRadius: Appearance.rounding.full
                    onClicked: Quickshell.execDetached(["bash", "-c", "export PATH=\"$HOME/.local/bin:$PATH\"; exec orca-ide open"])
                    contentItem: MaterialSymbol {
                        anchors.centerIn: parent
                        text: "open_in_new"
                        iconSize: Appearance.font.pixelSize.normal
                        color: Appearance.colors.colOnLayer2
                    }
                    StyledToolTip { text: Translation.tr("Open Orca") }
                }
            }
        }

        StyledText {
            visible: root.errorText.length > 0
            Layout.fillWidth: true
            wrapMode: Text.Wrap
            font.pixelSize: Appearance.font.pixelSize.small
            color: Appearance.colors.colError
            text: root.errorText
        }

        Flickable {
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            contentWidth: width
            contentHeight: contentColumn.implicitHeight

            ColumnLayout {
                id: contentColumn
                width: parent.width
                spacing: 12

                // Sessions
                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 6

                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 4

                        StyledText {
                            Layout.fillWidth: true
                            font.pixelSize: Appearance.font.pixelSize.small
                            font.weight: Font.DemiBold
                            color: Appearance.colors.colSubtext
                            text: Translation.tr("SESSIONS (%1 active)").arg(root.activeSessionCount)
                        }

                        Repeater {
                            model: [
                                { id: "all", label: Translation.tr("All") },
                                { id: "active", label: Translation.tr("Active") },
                                { id: "done", label: Translation.tr("Done") },
                            ]
                            delegate: RippleButton {
                                required property var modelData
                                implicitWidth: filterLabel.implicitWidth + 14
                                implicitHeight: 22
                                buttonRadius: Appearance.rounding.full
                                toggled: root.sessionFilter === modelData.id
                                onClicked: root.sessionFilter = modelData.id
                                contentItem: StyledText {
                                    id: filterLabel
                                    anchors.centerIn: parent
                                    font.pixelSize: Appearance.font.pixelSize.smaller
                                    color: parent.toggled ? Appearance.colors.colOnPrimary : Appearance.colors.colOnLayer2
                                    text: modelData.label
                                }
                            }
                        }
                    }

                    StyledText {
                        visible: root.filteredSessions.length === 0
                        font.pixelSize: Appearance.font.pixelSize.small
                        color: Appearance.colors.colSubtext
                        text: Translation.tr("No sessions")
                    }

                    Repeater {
                        model: root.filteredSessions
                        delegate: Rectangle {
                            required property var modelData
                            Layout.fillWidth: true
                            implicitHeight: sessionCol.implicitHeight + 14
                            radius: Appearance.rounding.small
                            color: Appearance.colors.colLayer2

                            ColumnLayout {
                                id: sessionCol
                                anchors.fill: parent
                                anchors.margins: 7
                                spacing: 4

                                RowLayout {
                                    Layout.fillWidth: true
                                    spacing: 6

                                    StyledText {
                                        Layout.fillWidth: true
                                        elide: Text.ElideRight
                                        font.pixelSize: Appearance.font.pixelSize.small
                                        font.weight: Font.DemiBold
                                        color: Appearance.colors.colOnLayer2
                                        text: `${modelData.repo || "workspace"} · ${modelData.workspace || ""}`
                                    }

                                    StyledText {
                                        font.pixelSize: Appearance.font.pixelSize.smaller
                                        color: Appearance.colors.colSubtext
                                        text: root.formatRelativeTime(modelData.updatedAt)
                                    }

                                    Rectangle {
                                        implicitWidth: sessionStateText.implicitWidth + 12
                                        implicitHeight: sessionStateText.implicitHeight + 4
                                        radius: height / 2
                                        color: root.stateBgColor(modelData.state)

                                        StyledText {
                                            id: sessionStateText
                                            anchors.centerIn: parent
                                            font.pixelSize: Appearance.font.pixelSize.smaller
                                            color: root.stateFgColor(modelData.state)
                                            text: modelData.state
                                        }
                                    }
                                }

                                StyledText {
                                    visible: (modelData.title ?? "").length > 0
                                    Layout.fillWidth: true
                                    elide: Text.ElideRight
                                    font.pixelSize: Appearance.font.pixelSize.normal
                                    color: Appearance.colors.colOnLayer2
                                    text: modelData.title ?? ""
                                }

                                StyledText {
                                    visible: (modelData.preview ?? "").length > 0
                                    Layout.fillWidth: true
                                    maximumLineCount: 2
                                    wrapMode: Text.Wrap
                                    elide: Text.ElideRight
                                    font.pixelSize: Appearance.font.pixelSize.smaller
                                    color: Appearance.colors.colSubtext
                                    text: modelData.preview ?? ""
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
