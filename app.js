let editor;

// Инициализация редактора Monaco при загрузке страницы
require.config({ paths: { 'vs': 'https://cdnjs.cloudflare.com/ajax/libs/monaco-editor/0.34.1/min' }});
require(['vs/editor/editor.main'], function() {
    editor = monaco.editor.create(document.getElementById('editor'), {
        value: '/* Напиши свой скрипт здесь */\n#include <iostream>\n\nint main() {\n    std::cout << "Cyber OS Active" << std::endl;\n    return 0;\n}',
        language: 'cpp',
        theme: 'vs-dark',
        automaticLayout: true
    });

    // Отслеживаем изменения для индикаторной лампы
    editor.onDidChangeModelContent(() => {
        updateScriptStatusLamp(editor);
    });
    
    updateScriptStatusLamp(editor);
    
    if (window.CyberTools) {
        window.CyberTools.log('success', 'Monaco Editor initialized successfully.');
    }
});

// Логика индикаторной лампы (зеленый — есть код, красный — пусто)
function updateScriptStatusLamp(editorInstance) {
    const lamp = document.getElementById('script-status-lamp');
    if (!lamp) return;

    const content = editorInstance.getValue().trim();
    if (content.length > 0) {
        lamp.style.backgroundColor = '#00ffcc';
        lamp.style.boxShadow = '0 0 10px #00ffcc, 0 0 20px #00ffcc';
    } else {
        lamp.style.backgroundColor = '#ff3333';
        lamp.style.boxShadow = '0 0 10px #ff3333, 0 0 20px #ff3333';
    }
}

// Управление X11 режимом
class CyberOSX11 {
    static toggleMode() {
        const editorDiv = document.getElementById('editor');
        const x11Div = document.getElementById('x11-viewport-container');
        
        if (x11Div.style.display === 'none') {
            editorDiv.style.display = 'none';
            x11Div.style.display = 'block';
            if (window.CyberTools) window.CyberTools.log('info', 'Switched to Termux-X11 Display View.');
        } else {
            x11Div.style.display = 'none';
            editorDiv.style.display = 'block';
            if (window.CyberTools) window.CyberTools.log('info', 'Switched back to Code Editor.');
        }
    }
}

// Виртуальная файловая система (VFS)
class CyberVFS {
    static createNewFile() {
        const fileName = prompt("Введите имя нового файла (например: script.cpp / payload.lua):", "module.cpp");
        if (fileName) {
            const tree = document.getElementById('vfs-file-tree');
            const item = document.createElement('div');
            item.className = 'file-item';
            item.style.padding = '5px 10px';
            item.style.cursor = 'pointer';
            item.style.color = '#00ffcc';
            item.style.fontFamily = 'monospace';
            item.textContent = `📄 ${fileName}`;
            item.onclick = () => {
                if (window.CyberTools) window.CyberTools.log('info', `Opened file: ${fileName}`);
            };
            tree.appendChild(item);
            if (window.CyberTools) window.CyberTools.log('success', `File created: ${fileName}`);
        }
    }
}

// Обработка ввода в кастомной консоли
const CyberDevTools = {
    insertMacro: function(text) {
        if (editor) {
            const position = editor.getPosition();
            editor.executeEdits('', [{ range: new monaco.Range(position.lineNumber, position.column, position.lineNumber, position.column), text: text }]);
            editor.focus();
        }
    },
    runCmd: function() {
        const input = document.getElementById('dt-js-input');
        if (!input) return;
        const cmd = input.value.trim();
        if (!cmd) return;

        if (window.CyberTools) {
            window.CyberTools.log('info', `root@cyber-os:~# ${cmd}`);
        }

        if (cmd === 'help') {
            if (window.CyberTools) {
                window.CyberTools.log('success', 'Available commands: g++, x11 start, inspect, clear, reboot');
            }
        } else if (cmd === 'inspect') {
            if (window.CyberTools) window.CyberTools.inspectMemory();
        } else if (cmd === 'clear') {
            const consoleOut = document.getElementById('dt-console-output');
            if (consoleOut) consoleOut.innerHTML = '';
        } else {
            if (window.CyberTools) {
                window.CyberTools.executeActiveScript();
            }
        }
        input.value = '';
    }
};

// Биндим Enter для консоли
document.addEventListener('DOMContentLoaded', () => {
    const input = document.getElementById('dt-js-input');
    if (input) {
        input.addEventListener('keypress', (e) => {
            if (e.key === 'Enter') {
                CyberDevTools.runCmd();
            }
        });
    }
});
