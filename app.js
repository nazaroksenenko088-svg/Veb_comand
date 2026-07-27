class WindowManager {
    constructor(containerId) {
        this.container = document.getElementById(containerId);
        this.highestZIndex = 100;
    }

    createWindow(title, contentHTML) {
        const win = document.createElement('div');
        win.className = 'cyber-window';
        win.style.zIndex = ++this.highestZIndex;
        win.style.top = '50px';
        win.style.left = '50px';

        win.innerHTML = `
            <div class="window-header">
                <span class="window-title">${title}</span>
                <div class="window-controls">
                    <button class="minimize-btn">_</button>
                    <button class="close-btn">X</button>
                </div>
            </div>
            <div class="window-body">
                ${contentHTML}
            </div>
        `;

        // Логика закрытия окна
        win.querySelector('.close-btn').addEventListener('click', () => {
            win.remove();
        });

        // Сделать окно перетаскиваемым
        this.makeDraggable(win);

        // Фокус при клике
        win.addEventListener('mousedown', () => {
            win.style.zIndex = ++this.highestZIndex;
        });

        this.container.appendChild(win);
        return win;
    }

    makeDraggable(element) {
        const header = element.querySelector('.window-header');
        let isDragging = false;
        let startX, startY;

        header.addEventListener('mousedown', (e) => {
            isDragging = true;
            startX = e.clientX - element.offsetLeft;
            startY = e.clientY - element.offsetTop;
            element.style.zIndex = ++this.highestZIndex;
        });

        document.addEventListener('mousemove', (e) => {
            if (!isDragging) return;
            element.style.left = `${e.clientX - startX}px`;
            element.style.top = `${e.clientY - startY}px`;
        });

        document.addEventListener('mouseup', () => {
            isDragging = false;
        });
    }
}

class LinuxVM {
    constructor(windowManager) {
        this.wm = windowManager;
        this.emulator = null;
    }

    bootISO(isoUrl) {
        const contentHTML = `
            <div id="vm-screen-container" style="width: 640px; height: 400px; background: #000; overflow: hidden; position: relative;">
                <div style="color: #00ffcc; padding: 15px; font-family: monospace;">
                    [Polygon Hypervisor] Запуск инициализации v86...<br>
                    [Polygon Hypervisor] Подключение ISO образа: ${isoUrl}<br>
                    [Polygon Hypervisor] Загрузка BIOS и выделение памяти...
                </div>
            </div>
        `;

        this.wm.createWindow('Linux Virtual Machine (v86)', contentHTML);

        const windows = document.querySelectorAll('.cyber-window');
        const currentWindow = windows[windows.length - 1];
        const screenContainer = currentWindow.querySelector('#vm-screen-container');

        // Инициализация эмулятора v86
        try {
            this.emulator = new V86Starter({
                wasm_path: "https://cdn.jsdelivr.net/npm/v86@0.3/build/v86.wasm",
                memory_size: 256 * 1024 * 1024, // 256 MB RAM
                vga_memory_size: 8 * 1024 * 1024,
                screen_container: screenContainer,
                bios: {
                    url: "https://cdn.jsdelivr.net/npm/v86@0.3/bios/seabios.bin",
                },
                vga_bios: {
                    url: "https://cdn.jsdelivr.net/npm/v86@0.3/bios/vgabios.bin",
                },
                cdrom: {
                    url: isoUrl,
                },
                autostart: true,
            });
        } catch (error) {
            screenContainer.innerHTML = `<div style="color: #ff5555; padding: 15px;">Ошибка запуска эмулятора: ${error.message}</div>`;
        }
    }
}

// === Инициализация системы при загрузке страницы ===
window.addEventListener('DOMContentLoaded', () => {
    const wm = new WindowManager('custom-ui-container');
    const vm = new LinuxVM(wm);

    // Кнопка запуска виртуальной машины с Linux
    document.getElementById('run-btn').addEventListener('click', () => {
        // Укажи здесь путь к твоему легковесному ISO (например, Alpine или Tiny Core)
        vm.bootISO('./alpine.iso');
    });

    // Кнопка открытия админ-панели
    document.getElementById('admin-btn').addEventListener('click', () => {
        if (window.AdminPanel) {
            const admin = new AdminPanel();
            const win = wm.createWindow('Системная Панель', admin.renderPanel());
            // Прикрепляем события внутри окна после его отрисовки
            setTimeout(() => admin.attachEvents(), 100);
        } else {
            alert('Модуль AdminPanel не загружен!');
        }
    });

    console.log("[Polygon OS] Окружение успешно инициализировано.");
    if (window.SystemFeatures) {
        window.SystemFeatures.listModules();
    }
});
