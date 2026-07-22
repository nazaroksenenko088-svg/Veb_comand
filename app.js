/**
 * CYBER OS - MAIN APP MODULE (v4.2.1)
 * Файл: app.js
 */
const App = {
    scripts: JSON.parse(localStorage.getItem('cyber_vault') || '[]'),
    osPreset: 'windows',

    init() {
        this.initConsoleInterceptor();
        this.loadTheme();
        this.renderVault();
        console.log("[APP_CORE] Cyber OS Main Core Ready.");
    },

    // === ПЕРЕХВАТЧИК ЛОГОВ ДЛЯ SYS_LOGS ===
    initConsoleInterceptor() {
        const devConsoleEl = document.getElementById('custom-dev-console');
        const origLog = console.log;
        const origErr = console.error;

        const appendLog = (msg, type) => {
            if (!devConsoleEl) return;
            const div = document.createElement('div');
            let color = 'var(--text)';
            if (type === 'err') color = '#ef4444';
            if (type === 'eval') color = 'var(--accent)';

            div.style.color = color;
            div.style.borderBottom = '1px solid #1a1a1a';
            div.innerText = `${new Date().toLocaleTimeString()} [${type.toUpperCase()}] > ${msg}`;
            devConsoleEl.appendChild(div);
            devConsoleEl.scrollTop = devConsoleEl.scrollHeight;
        };

        console.log = (...args) => {
            origLog.apply(console, args);
            appendLog(args.map(a => typeof a === 'object' ? JSON.stringify(a) : a).join(' '), 'info');
        };

        console.error = (...args) => {
            origErr.apply(console, args);
            appendLog(args.map(a => typeof a === 'object' ? JSON.stringify(a) : a).join(' '), 'err');
        };
    },

    evalDevCode() {
        const input = document.getElementById('dev-eval-input');
        if (!input || !input.value) return;
        try {
            const res = eval(input.value);
            console.log(res !== undefined ? res : 'executed');
        } catch (e) {
            console.error(e.message);
        }
        input.value = '';
    },

    clearDevConsole() {
        const devConsoleEl = document.getElementById('custom-dev-console');
        if (devConsoleEl) devConsoleEl.innerHTML = '<div style="color: var(--text-muted);">> LOGS CLEARED...</div>';
    },

    // === УПРАВЛЕНИЕ ВКЛАДКАМИ И ТЕМАМИ ===
    openTab(tabId, event) {
        document.querySelectorAll('.tab-content').forEach(t => t.classList.remove('active'));
        document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
        
        document.getElementById(tabId)?.classList.add('active');
        if (event?.currentTarget) event.currentTarget.classList.add('active');
    },

    changeTheme() {
        const theme = document.getElementById('theme-select')?.value || 'cyberpunk';
        document.documentElement.setAttribute('data-theme', theme);
        localStorage.setItem('cyber_theme', theme);
    },

    changeLang() {
        const lang = document.getElementById('lang-select')?.value;
        if (window.editor && lang) {
            monaco.editor.setModelLanguage(window.editor.getModel(), lang);
            console.log(`[EDITOR] Language switched to: ${lang}`);
        }
    },

    loadTheme() {
        const saved = localStorage.getItem('cyber_theme') || 'cyberpunk';
        const select = document.getElementById('theme-select');
        if (select) select.value = saved;
        document.documentElement.setAttribute('data-theme', saved);
    },

    // === ЛОГИКА ТЕРМИНАЛА ===
    changeOSPreset() {
        this.osPreset = document.getElementById('os-preset-select').value;
        const prompt = document.getElementById('term-prompt');
        if (this.osPreset === 'windows') prompt.innerText = 'C:\\System32>';
        if (this.osPreset === 'termux') prompt.innerText = 'termux@android:~$';
        if (this.osPreset === 'debian') prompt.innerText = 'root@debian:~#';
    },

    handleTermInput(e) {
        if (e.key === 'Enter') {
            const input = document.getElementById('term-input');
            const output = document.getElementById('term-out');
            const cmd = input.value.trim();
            if (!cmd) return;

            output.innerText += `\n${document.getElementById('term-prompt').innerText} ${cmd}`;

            if (cmd === 'clear') output.innerText = 'SYSTEM_INITIALIZED...\n';
            else if (cmd === 'help') output.innerText += '\nCommands: help, clear, vault, status';
            else if (cmd === 'vault') output.innerText += '\n' + this.scripts.map(s => `[${s.name}] -> ${s.path}`).join('\n');
            else output.innerText += `\nCommand executed: ${cmd}`;

            input.value = '';
            output.scrollTop = output.scrollHeight;
            if (window.AdminCore) AdminCore.addXP(5);
        }
    },

    // === ХРАНИЛИЩЕ СКРИПТОВ (VAULT) ===
    addScript() {
        const name = document.getElementById('script-name').value;
        const path = document.getElementById('script-path').value;
        if (!name || !path) return;

        this.scripts.push({ name, path });
        localStorage.setItem('cyber_vault', JSON.stringify(this.scripts));
        
        document.getElementById('script-name').value = '';
        document.getElementById('script-path').value = '';
        this.renderVault();
    },

    renderVault() {
        const grid = document.getElementById('vault-grid');
        if (!grid) return;
        grid.innerHTML = '';
        this.scripts.forEach((s, idx) => {
            const div = document.createElement('div');
            div.className = 'brutal-box-sm';
            div.style.cssText = 'display:flex; justify-content:space-between; align-items:center;';
            div.innerHTML = `
                <div>
                    <strong style="color:var(--accent-green);">${s.name}</strong>
                    <div style="font-size:0.75rem; color:var(--text-muted);">${s.path}</div>
                </div>
                <button class="btn brutal-box-sm" style="color:#ef4444; border-color:#ef4444;" onclick="App.deleteScript(${idx})">DEL</button>
            `;
            grid.appendChild(div);
        });
    },

    deleteScript(idx) {
        this.scripts.splice(idx, 1);
        localStorage.setItem('cyber_vault', JSON.stringify(this.scripts));
        this.renderVault();
    },

    // === AI CORE & MONACO EDITOR ===
    saveGeminiKey() {
        const key = document.getElementById('gemini-key-input').value;
        if (key) {
            localStorage.setItem('gemini_api_key', key);
            console.log("API Key Linked.");
        }
    },

    sendGeminiMsg() {
        const input = document.getElementById('chat-input');
        const msgs = document.getElementById('chat-msgs');
        if (!input.value.trim()) return;

        const msgDiv = document.createElement('div');
        msgDiv.innerText = `> ${input.value}`;
        msgs.appendChild(msgDiv);

        input.value = '';
        msgs.scrollTop = msgs.scrollHeight;
        if (window.AdminCore) AdminCore.addXP(10);
    },

    initMonacoDelayed() {
        const container = document.getElementById('editor-container');
        container.innerHTML = '<div style="color:var(--accent);">Loading Monaco Engine...</div>';
        const script = document.createElement('script');
        script.src = "https://cdnjs.cloudflare.com/ajax/libs/monaco-editor/0.38.0/min/vs/loader.min.js";
        script.onload = () => {
            require.config({ paths: { vs: 'https://cdnjs.cloudflare.com/ajax/libs/monaco-editor/0.38.0/min/vs' } });
            require(['vs/editor/editor.main'], () => {
                container.innerHTML = '';
                window.editor = monaco.editor.create(container, {
                    value: "# Cyber OS Code Editor\nprint('Engine Ready')",
                    language: 'python',
                    theme: 'vs-dark'
                });
            });
        };
        document.body.appendChild(script);
    }
};

// === ГЛОБАЛЬНЫЕ АЛИАСЫ (Мост между HTML и объектом App) ===
// Это решает все проблемы с ReferenceError при кликах по кнопкам
window.openTab = (...args) => App.openTab(...args);
window.sendGeminiMsg = (...args) => App.sendGeminiMsg(...args);
window.changeLang = (...args) => App.changeLang(...args);
window.initMonaco = (...args) => App.initMonacoDelayed(...args);
window.initMonacoDelayed = (...args) => App.initMonacoDelayed(...args);
window.saveGeminiKey = (...args) => App.saveGeminiKey(...args);
window.addScript = (...args) => App.addScript(...args);
window.clearDevConsole = (...args) => App.clearDevConsole(...args);
window.evalDevCode = (...args) => App.evalDevCode(...args);
window.changeTheme = (...args) => App.changeTheme(...args);
window.changeOSPreset = (...args) => App.changeOSPreset(...args);

document.addEventListener('DOMContentLoaded', () => App.init());
