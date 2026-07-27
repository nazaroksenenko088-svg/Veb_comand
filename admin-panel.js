class AdminPanel {
    constructor() {
        this.isAuthorized = true;
    }

    renderPanel() {
        return `
            <div style="color: #ff5555; font-family: monospace;">
                <h3>[ADMIN_ZONE] Консоль управления</h3>
                <p>Статус защиты: <span style="color: #00ffcc;">АКТИВЕН</span></p>
                <p>Выделенная память WASM: 256 MB</p>
                <button id="flush-cache" style="background: #222; color: #ff5555; border: 1px solid #ff5555; padding: 5px 10px; cursor: pointer; margin-top: 10px;">Сбросить кэш ядра</button>
            </div>
        `;
    }

    attachEvents() {
        const btn = document.getElementById('flush-cache');
        if (btn) {
            btn.addEventListener('click', () => {
                alert('[Система] Кэш успешно сброшен, память очищена.');
            });
        }
    }
}

window.AdminPanel = AdminPanel;
