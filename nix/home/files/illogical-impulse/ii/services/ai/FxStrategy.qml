import QtQuick

ApiStrategy {
    property bool inProgressBlock: false

    function buildEndpoint(model: AiModel): string {
        return "fx://ask";
    }

    function buildRequestData(model: AiModel, messages, systemPrompt: string, temperature: real, tools: list<var>, filePath: string) {
        let promptText = "";
        if (messages.length <= 1) {
            promptText = messages.length === 1 ? messages[0].rawContent : "";
        } else {
            const history = messages.slice(0, -1).map(m => `${m.role === "user" ? "User" : "Assistant"}: ${m.rawContent}`).join("\n\n");
            const latest = messages[messages.length - 1].rawContent;
            promptText = `Previous conversation:\n${history}\n\nUser: ${latest}`;
        }
        if (filePath && filePath.length > 0) {
            promptText += `\n\n[Attached file: ${filePath}]`;
        }
        return {
            "prompt": promptText
        };
    }

    function buildAuthorizationHeader(apiKeyEnvVarName: string): string {
        return "";
    }

    function parseProgressLine(line: string, message: AiMessageData) {
        const clean = line.trim();
        if (!clean || clean.startsWith("[notice]")) return;
        let chunk = "";
        if (!inProgressBlock) {
            inProgressBlock = true;
            chunk += "\n\n<think>\n";
        }
        chunk += clean + "\n";
        message.rawContent += chunk;
        message.content += chunk;
    }

    function parseResponseLine(line: string, message: AiMessageData) {
        let chunk = "";
        if (inProgressBlock) {
            inProgressBlock = false;
            chunk += "</think>\n\n";
        }
        chunk += (message.rawContent.length > 0 && !chunk.endsWith("\n\n") ? "\n" : "") + line;
        message.rawContent += chunk;
        message.content += chunk;
        return {};
    }

    function onRequestFinished(message: AiMessageData): var {
        if (inProgressBlock) {
            inProgressBlock = false;
            const endBlock = "</think>\n\n";
            message.rawContent += endBlock;
            message.content += endBlock;
        }
        return { finished: true };
    }

    function reset() {
        inProgressBlock = false;
    }
}
