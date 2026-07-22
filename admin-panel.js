/**
 * CYBER OS - ADMIN CORE MODULE
 * Файл: admin_panel.js
 */
const AdminCore = {
    state: {
        lvl: 1,
        xp: 0,
        cpu: 12,
        ram: 340
    },

    init() {
        this.loadState();
        this.startMetricsLoop();
        console.log("[ADMIN_CORE] Initialized successfully.");
    },

    toggle() {
        const panel = document.getElementById('admin-panel');
        if (panel) {
            panel.style.display = (panel.style.display === 'flex') ? 'none' : 'flex';
        }
    },

    addXP(amount) {
        this.state.xp += amount;
        if (this.state.xp >= 100) {
            this.state.lvl += Math.floor(this.state.xp / 100);
            this.state.xp = this.state.xp % 100;
            console.log(`[LEVEL UP] Reached Level ${this.state.lvl}`);
        }
        this.saveState();
        this.updateUI();
    },

    updateUI() {
        const lvlEl = document.getElementById('lvl-txt');
        const xpEl = document.getElementById('xp-txt');
        if (lvlEl) lvlEl.innerText = `LVL ${this.state.lvl}`;
        if (xpEl) xpEl.innerText = `${this.state.xp} XP`;
    },

    saveState() {
        localStorage.setItem('cyber_admin_state', JSON.stringify(this.state));
    },

    loadState() {
        const saved = localStorage.getItem('cyber_admin_state');
        if (saved) {
            this.state = { ...this.state, ...JSON.parse(saved) };
        }
        this.updateUI();
    },

    startMetricsLoop() {
        setInterval(() => {
            // Симуляция живых метрик
            this.state.cpu = Math.floor(Math.random() * 25) + 5;
            this.state.ram = 320 + Math.floor(Math.random() * 50);
            
            const cpuEl = document.getElementById('sys-cpu');
            const ramEl = document.getElementById('sys-ram');
            
            if (cpuEl) cpuEl.innerText = `${this.state.cpu}%`;
            if (ramEl) ramEl.innerText = `${this.state.ram}MB / 1024MB`;
        }, 3000);
    },

    exportConfig() {
        const configData = {
            adminState: this.state,
            vault: JSON.parse(localStorage.getItem('cyber_vault') || '[]'),
            theme: localStorage.getItem('cyber_theme') || 'cyberpunk'
        };
        const blob = new Blob([JSON.stringify(configData, null, 2)], { type: 'application/json' });
        const a = document.createElement('a');
        a.href = URL.createObjectURL(blob);
        a.download = `cyber_os_config_${Date.now()}.json`;
        a.click();
        console.log("[ADMIN_CORE] Config exported.");
    },

    hardReset() {
        if (confirm("ВНИМАНИЕ: Сбросить все сохраненные данные, настройки и скрипты из Vault?")) {
            localStorage.clear();
            location.reload();
        }
    }
};

// Инициализация при загрузке страницы
document.addEventListener('DOMContentLoaded', () => AdminCore.init());
