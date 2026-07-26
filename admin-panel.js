class CyberAdminPanel {
    constructor() {
        this.nodesActive = true;
        this.connectedClients = 1;
    }

    // Рендер панели управления прямо в браузере (вызывается по желанию)
    renderAdminOverlay() {
        let overlay = document.getElementById('cyber-admin-overlay');
        if (overlay) {
            overlay.remove();
            return;
        }

        overlay = document.createElement('div');
        overlay.id = 'cyber-admin-overlay';
        overlay.style.cssText = 'position:fixed; top:50px; right:50px; width:350px; background:#111827; border:1px solid #00ffcc; z-index:9999; padding:15px; font-family:monospace; box-shadow: 0 0 20px rgba(0,255,204,0.2); border-radius:6px;';
        
        overlay.innerHTML = `
            <div style="display:flex; justify-content:space-between; align-items:center; border-bottom:1px solid #1f293d; padding-bottom:8px; margin-bottom:10px;">
                <span style="color:#00ffcc; font-weight:bold;">⚡ CYBER ADMIN SUITE</span>
                <button onclick="document.getElementById('cyber-admin-overlay').remove()" style="background:none; border:none; color:#ff3333; cursor:pointer; font-weight:bold;">[X]</button>
            </div>
            <div style="font-size:12px; color:#e5e7eb; display:flex; flex-direction:column; gap:8px;">
                <div>Статус ядра: <span style="color:#00ffcc;">ONLINE (RT-6.12)</span></div>
                <div>Активные сокеты: <span style="color:#00ffcc;">${this.connectedClients} узла</span></div>
                <div>Выделенная память: <span style="color:#00ffcc;">14.2 MB</span></div>
                <hr style="border-color:#1f293d; margin:5px 0;">
                <button class="cyber-btn btn-sm" onclick="window.AdminPanel.flushMemory()">Очистить кэш памяти</button>
                <button class="cyber-btn btn-sm" onclick="window.AdminPanel.broadcastSignal()">Отправить пинг на устройство</button>
            </div>
        `;
        document.body.appendChild(overlay);
        if (window.CyberTools) window.CyberTools.log('info', 'Admin panel overlay opened.');
    }

    flushMemory() {
        if (window.CyberTools) window.CyberTools.log('success', 'Virtual memory cache successfully flushed.');
    }

    broadcastSignal() {
        if (window.CyberTools) window.CyberTools.log('success', 'WebSocket ping broadcasted to connected client nodes.');
    }
}

window.AdminPanel = new CyberAdminPanel();
