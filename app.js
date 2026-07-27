class WindowManager {
    constructor(containerId) {
        this.container = document.getElementById(containerId) || document.body;
        this.zIndexCounter = 10;
    }

    createWindow(title, contentHTML) {
        // Создаем главный контейнер окна
        const win = document.createElement('div');
        win.className = 'cyber-window';
        win.style.top = '120px';
        win.style.left = '180px';
        win.style.zIndex = ++this.zIndexCounter;

        // Создаем шапку
        const header = document.createElement('div');
        header.className = 'window-header';

        const titleSpan = document.createElement('span');
        titleSpan.innerText = title;

        const controls = document.createElement('div');
        controls.className = 'window-controls';

        const btnMin = document.createElement('button');
        btnMin.className = 'win-btn btn-min';
        
        const btnClose = document.createElement('button');
        btnClose.className = 'win-btn btn-close';

        controls.appendChild(btnMin);
        controls.appendChild(btnClose);

        header.appendChild(titleSpan);
        header.appendChild(controls);

        // Создаем контентную часть
        const content = document.createElement('div');
        content.className = 'window-content';
        content.innerHTML = contentHTML;

        win.appendChild(header);
        win.appendChild(content);
        this.container.appendChild(win);

        // Поведение по клику (фокус)
        win.addEventListener('mousedown', () => {
            win.style.zIndex = ++this.zIndexCounter;
        });

        // Перетаскивание за заголовок
        this.makeDraggable(win, titleSpan);

        // Закрытие окна
        btnClose.addEventListener('click', () => {
            win.remove();
        });

        // Сворачивание / разворачивание контента
        btnMin.addEventListener('click', () => {
            content.style.display = content.style.display === 'none' ? 'block' : 'none';
        });
    }

    makeDraggable(windowElement, dragHandle) {
        let isDragging = false;
        let offsetX = 0;
        let offsetY = 0;

        dragHandle.addEventListener('mousedown', (e) => {
            isDragging = true;
            offsetX = e.clientX - windowElement.getBoundingClientRect().left;
            offsetY = e.clientY - windowElement.getBoundingClientRect().top;
        });

        document.addEventListener('mousemove', (e) => {
            if (!isDragging) return;
            windowElement.style.left = (e.clientX - offsetX) + 'px';
            windowElement.style.top = (e.clientY - offsetY) + 'px';
        });

        document.addEventListener('mouseup', () => {
            isDragging = false;
        });
    }
}

class TerminalUI {
    constructor(windowManager) {
        this.wm = windowManager;
    }

    openTerminal() {
        const contentHTML = `
            <div class="term-logs" style="height: 160px; overflow-y: auto; margin-bottom: 10px; font-size: 13px; line-height: 1.4;">
                <div style="color: #00ffcc;">[Система] Оболочка инициализирована. Введите 'help' для справки.</div>
            </div>
            <div class="term-input-line" style="display: flex; align-items: center; color: #00ffcc; font-size: 13px;">
                <span style="margin-right: 8px;">root@polygon:~#</span>
                <input type="text" class="term-input" style="flex: 1; background: transparent; border: none; color: #fff; font-family: monospace; outline: none; font-size: 13px;" autocomplete="off" autofocus>
            </div>
        `;

        this.wm.createWindow('Terminal_v0.1', contentHTML);

        // Получаем свежесозданное окно для привязки логики ввода
        const windows = document.querySelectorAll('.cyber-window');
        const currentWindow = windows[windows.length - 1];
        
        const inputField = currentWindow.querySelector('.term-input');
        const logsArea = currentWindow.querySelector('.term-logs');

        // Автофокус на поле ввода сразу после отрисовки
        setTimeout(() => inputField.focus(), 50);

        inputField.addEventListener('keydown', (e) => {
            if (e.key === 'Enter') {
                const command = inputField.value.trim();
                if (command) {
                    this.executeCommand(command, logsArea);
                }
                inputField.value = '';
                logsArea.scrollTop = logsArea.scrollHeight;
            }
        });
    }

    executeCommand(cmd, logsArea) {
        logsArea.innerHTML += `<div><span style="color: #666;">root@polygon:~#</span> ${cmd}</div>`;

        let response = '';
        switch (cmd.toLowerCase()) {
            case 'help':
                response = 'Доступные команды: help, ls, clear, whoami, date';
                break;
            case 'ls':
                response = '<span style="color: #ffb86c;">SIGMA_PROJECT/</span>  <span style="color: #ffb86c;">rust_security/</span>  HARVESTER_V3.0.py  Kernel.c';
                break;
            case 'whoami':
                response = 'root (Polygon WebOS environment)';
                break;
            case 'date':
                response = new Date().toUTCString();
                break;
            case 'clear':
                logsArea.innerHTML = '';
                return;
            default:
                response = `<span style="color: #ff5555;">bash: ${cmd}: команда не найдена</span>`;
        }

        logsArea.innerHTML += `<div>${response}</div>`;
    }
}

// === ИНИЦИАЛИЗАЦИЯ ПРИЛОЖЕНИЯ ===
const wm = new WindowManager('custom-ui-container');
const terminal = new TerminalUI(wm);

document.getElementById('run-btn').addEventListener('click', () => {
    terminal.openTerminal();
});
