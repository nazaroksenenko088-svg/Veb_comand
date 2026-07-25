window.CyberDevTools = {
    insertMacro: function(text) {
        if (!editor) return;
        const position = editor.getPosition();
        editor.executeEdits('', [{
            range: new monaco.Range(position.lineNumber, position.column, position.lineNumber, position.column),
            text: text
        }]);
        editor.focus();
    },
    clearConsole: function() {
        document.getElementById('dt-console-output').innerHTML = '';
    }
};

function print(text, type = 'default') {
    const output = document.getElementById('dt-console-output');
    if (!output) return;
    const div = document.createElement('div');
    div.className = `log-${type}`;
    div.textContent = text;
    output.appendChild(div);
    output.scrollTop = output.scrollHeight;
}

let virtualFiles = {
    'main.cpp': '#include <iostream>\nusing namespace std;\n\nint main() {\n    cout << "Cyber OS Debian Kernel Initialized!" << endl;\n    return 0;\n}',
    'styles.css': 'body { background: #0b0f19; color: #00ffcc; font-family: monospace; }',
    'index.html': '<!DOCTYPE html>\n<html>\n<head><title>Cyber OS</title></head>\n<body><h1>Hello</h1></body>\n</html>'
};

let activeFile = 'main.cpp';

window.CyberVFS = {
    init: function() {
        this.renderTree();
    },
    renderTree: function() {
        const treeContainer = document.getElementById('vfs-file-tree');
        if (!treeContainer) return;
        treeContainer.innerHTML = '';
        
        Object.keys(virtualFiles).forEach(filename => {
            const item = document.createElement('div');
            item.className = `file-item ${filename === activeFile ? 'active' : ''}`;
            item.textContent = `📄 ${filename}`;
            item.onclick = () => CyberVFS.openFile(filename);
            treeContainer.appendChild(item);
        });
    },
    openFile: function(filename) {
        if (virtualFiles[activeFile] !== undefined && editor) {
            virtualFiles[activeFile] = editor.getValue();
        }
        activeFile = filename;
        if (editor && virtualFiles[filename] !== undefined) {
            editor.setValue(virtualFiles[filename]);
            const ext = filename.split('.').pop();
            let lang = 'cpp';
            if (ext === 'css') lang = 'css';
            if (ext === 'html') lang = 'html';
            monaco.editor.setModelLanguage(editor.getModel(), lang);
        }
        this.renderTree();
        print(`[VFS] Открыт файл: ${filename}`, 'system');
    },
    createNewFile: function() {
        const name = prompt("Имя нового файла (например: test.cpp):");
        if (name && !virtualFiles[name]) {
            virtualFiles[name] = '// Новый файл\n';
            this.openFile(name);
        }
    }
};

window.CyberOSX11 = {
    active: false,
    toggleMode: function() {
        this.active = !this.active;
        const viewport = document.getElementById('x11-viewport-container');
        const editorArea = document.getElementById('editor');
        
        if (this.active) {
            if (editorArea) editorArea.style.display = 'none';
            if (viewport) viewport.style.display = 'block';
            print('[Termux-X11] Дисплей :0 активирован.', 'info');
            
            const canvas = document.getElementById('x11-canvas');
            if (canvas) {
                const ctx = canvas.getContext('2d');
                canvas.width = canvas.clientWidth;
                canvas.height = canvas.clientHeight;
                ctx.fillStyle = '#05070b';
                ctx.fillRect(0, 0, canvas.width, canvas.height);
                ctx.strokeStyle = '#00ffcc';
                ctx.lineWidth = 1;
                ctx.beginPath();
                for(let i=0; i<canvas.width; i+=40) {
                    ctx.moveTo(i, 0); ctx.lineTo(i, canvas.height);
                }
                for(let j=0; j<canvas.height; j+=40) {
                    ctx.moveTo(0, j); ctx.lineTo(canvas.width, j);
                }
                ctx.stroke();
                ctx.fillStyle = '#00ffcc';
                ctx.font = '16px monospace';
                ctx.fillText('X11 Window Manager [Debian XWayland]', 20, 30);
            }
        } else {
            if (viewport) viewport.style.display = 'none';
            if (editorArea) editorArea.style.display = 'block';
            print('[Termux-X11] Возврат в стандартный режим IDE.', 'system');
        }
    }
};

let cmdHistory = [];
let historyIndex = -1;

CyberDevTools.runCmd = function() {
    const input = document.getElementById('dt-js-input');
    if(!input || !input.value.trim()) return;
    const cmd = input.value.trim();
    
    cmdHistory.push(cmd);
    historyIndex = cmdHistory.length;

    print(`root@cyber-os:~# ${cmd}`, 'system');

    const args = cmd.split(' ');
    const mainCmd = args[0].toLowerCase();
    const arg1 = args[1];
    const arg2 = args[2];

    if (editor && virtualFiles[activeFile] !== undefined) {
        virtualFiles[activeFile] = editor.getValue();
    }

    try {
        switch(mainCmd) {
            case 'help':
                print('Debian/Termux-X11 Shell - Команды:', 'info');
                print('  uname -a              - Версия ядра', 'log');
                print('  whoami                - Пользователь', 'log');
                print('  ls                    - Список файлов VFS', 'log');
                print('  cat <file>            - Чтение файла', 'log');
                print('  g++ <file>            - Симуляция компиляции C++', 'log');
                print('  x11 start / stop      - Управление графикой X11', 'log');
                print('  apt / pip install     - Пакетный менеджер', 'log');
                print('  clear                 - Очистить консоль', 'log');
                print('  ver                   - Версия системы', 'log');
                break;
            case 'uname':
                print('Linux cyber-os 6.8.0-kali-amd64 x86_64 GNU/Linux', 'log');
                break;
            case 'whoami':
                print('root', 'log');
                break;
            case 'clear':
                CyberDevTools.clearConsole();
                break;
            case 'ls':
                print(Object.keys(virtualFiles).join('  '), 'info');
                break;
            case 'cat':
                if (virtualFiles[arg1] !== undefined) print(virtualFiles[arg1], 'log');
                else print(`cat: ${arg1}: Файл не найден`, 'error');
                break;
            case 'x11':
                if (arg1 === 'start') {
                    if (!CyberOSX11.active) CyberOSX11.toggleMode();
                } else if (arg1 === 'stop') {
                    if (CyberOSX11.active) CyberOSX11.toggleMode();
                } else {
                    print('Использование: x11 start | x11 stop', 'warn');
                }
                break;
            case 'apt':
            case 'pkg':
            case 'pip':
                if (arg1 === 'install' && arg2) {
                    print(`[${mainCmd.toUpperCase()}] Сборка и установка пакета ${arg2}... Готово`, 'info');
                } else {
                    print(`Использование: ${mainCmd} install <package>`, 'warn');
                }
                break;
            case 'g++':
                print(`[C++ Compiler] Сборка файла ${arg1 || activeFile}...`, 'warn');
                setTimeout(() => print(`[build] Успешно. Код выхода: 0`, 'info'), 800);
                break;
            case 'ver':
                print('Cyber OS Core v3.0 [Termux-X11 Web Edition]', 'info');
                break;
            default:
                // Безопасный вызов JS без падений при вводе системных слов
                try {
                    const res = eval(cmd);
                    if(res !== undefined) print(JSON.stringify(res), 'log');
                } catch (evalErr) {
                    print(`bash: команда не найдена: ${mainCmd}. Введите 'help' для справки.`, 'error');
                }
                break;
        }
    } catch(e) {
        print(`bash: ошибка: ${e.message}`, 'error');
    }
    input.value = '';
};

document.addEventListener('DOMContentLoaded', () => {
    const input = document.getElementById('dt-js-input');
    if(input) {
        input.addEventListener('keydown', e => {
            if (e.key === 'Enter') {
                CyberDevTools.runCmd();
            } else if (e.key === 'ArrowUp') {
                e.preventDefault();
                if (cmdHistory.length > 0 && historyIndex > 0) {
                    historyIndex--;
                    input.value = cmdHistory[historyIndex];
                }
            } else if (e.key === 'ArrowDown') {
                e.preventDefault();
                if (cmdHistory.length > 0 && historyIndex < cmdHistory.length - 1) {
                    historyIndex++;
                    input.value = cmdHistory[historyIndex];
                } else {
                    historyIndex = cmdHistory.length;
                    input.value = '';
                }
            }
        });
    }
});
