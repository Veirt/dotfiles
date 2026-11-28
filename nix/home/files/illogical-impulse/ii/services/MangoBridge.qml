pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: bridge

    property var monitors: []
    property var clients: []
    readonly property ShellScreen focusedScreen: {
        const activeOutput = monitors.find(monitor => monitor.active)?.name;
        return Quickshell.screens.find(screen => screen.name === activeOutput) ?? Quickshell.screens[0] ?? null;
    }

    function tagsFor(output: string): var {
        return monitors.find(monitor => monitor.name === output)?.tags ?? [];
    }

    function clientsFor(output: string, tagIndex: int): var {
        return clients.filter(c => c.monitor === output && !c.is_scratchpad && Array.isArray(c.tags) && c.tags.includes(tagIndex));
    }

    function viewTag(output: string, index: int): void {
        if (!tagsFor(output).some(tag => tag.index === index))
            return;
        Quickshell.execDetached(["mmsg", "dispatch", "viewcrossmon," + index + "," + output]);
    }

    Process {
        id: monitorEvents
        command: ["mmsg", "watch", "all-monitors"]
        running: true
        stdout: SplitParser {
            onRead: data => {
                try {
                    const snapshot = JSON.parse(data);
                    if (Array.isArray(snapshot.monitors))
                        bridge.monitors = snapshot.monitors;
                } catch (error) {
                    console.warn("Invalid Mango monitor event:", error);
                }
            }
        }
        onExited: restart.restart()
    }

    Timer {
        id: restart
        interval: 1000
        onTriggered: monitorEvents.running = true
    }

    Process {
        id: clientEvents
        command: ["mmsg", "watch", "all-clients"]
        running: true
        stdout: SplitParser {
            onRead: data => {
                try {
                    const snapshot = JSON.parse(data);
                    if (Array.isArray(snapshot.clients))
                        bridge.clients = snapshot.clients;
                } catch (error) {
                    console.warn("Invalid Mango client event:", error);
                }
            }
        }
        onExited: clientRestart.restart()
    }

    Timer {
        id: clientRestart
        interval: 1000
        onTriggered: clientEvents.running = true
    }
}
