// Глобальное состояние приложения (fallback-инициализация)
window.appState = window.appState || {
    level: 1,
    xp: 0,
    coins: 0,
    currentOS: 'debian',
    currentLang: 'python',
    theme: localStorage.getItem('cyber_theme') || 'cyberpunk',
    geminiKey: localStorage.getItem('gemini_api_key') || '',
    scripts: []
};

// Функция уведомлений
window.showNotification = window.showNotification || function(msg) {
    alert(msg);
};

// Обновление UI статистики
window.updateStatsUI = window.updateStatsUI || function() {
    const lvlTxt = document.getElementById('lvl-txt');
    const xpTxt = document.getElementById('xp-txt');
    const coinsTxt = document.getElementById('coins-txt');
    const xpFill = document.getElementById('xp-fill');
    
    if (lvlTxt) lvlTxt.innerText = `LVL ${appState.level}`;
    if (xpTxt) xpTxt.innerText = `${appState.xp} XP`;
    if (coinsTxt) coinsTxt.innerText = `💰 ${appState.coins} CC`;
    if (xpFill) {
        let pct = Math.min(100, (appState.xp / (appState.level * 100)) * 100);
        xpFill.style.width = `${pct}%`;
    }
};

// Сохранение статистики
window.saveStats = window.saveStats || function() {
    localStorage.setItem('stats', JSON.stringify({
        level: appState.level,
        xp: appState.xp,
        coins: appState.coins
    }));
};

// Добавление опыта
window.updateXP = window.updateXP || function(amount) {
    appState.xp += amount;
    let neededXP = appState.level * 100;
    while (appState.xp >= neededXP) {
        appState.xp -= neededXP;
        appState.level++;
        neededXP = appState.level * 100;
        showNotification(`🎉 LEVEL UP! Level ${appState.level}`);
    }
    updateStatsUI();
    saveStats();
};

// Переключение вкладок
window.openTab = function(tabId, evt) {
    document.querySelectorAll('.tab-content').forEach(tab => {
        tab.classList.remove('active');
    });
    document.querySelectorAll('.tab-btn').forEach(btn => {
        btn.classList.remove('active');
    });
    
    const targetTab = document.getElementById(tabId);
    if (targetTab) targetTab.classList.add('active');
    
    const currentBtn = evt ? evt.currentTarget : (window.event ? window.event.currentTarget : null);
    if (currentBtn) {
        currentBtn.classList.add('active');
    }
};

// Смена тем оформления
window.changeTheme = function(themeName) {
    const theme = themeName || document.getElementById('theme-select')?.value || 'cyberpunk';
    document.documentElement.setAttribute('data-theme', theme);
    document.body.className = `theme-${theme}`;
    localStorage.setItem('cyber_theme', theme);
    localStorage.setItem('theme', theme);
    appState.theme = theme;
    
    const sel1 = document.getElementById('theme-select');
    const sel2 = document.getElementById('admin-theme');
    if (sel1 && sel1.value !== theme) sel1.value = theme;
    if (sel2 && sel2.value !== theme) sel2.value = theme;
};

// Переключение пресетов терминала
window.changeOSPreset = function() {
    const preset = document.getElementById('os-preset-select').value;
    const promptSpan = document.getElementById('term-prompt');
    
    const prompts = {
        debian: 'root@debian:~#',
        termux: 'u0_a123@termux:~$',
        kali: 'root@kali:~#',
        arch: 'root@archiso ~ #',
        windows: 'C:\\CyberStation>'
    };
    
    if (prompts[preset] && promptSpan) {
        promptSpan.innerText = prompts[preset];
    }
};

// Ввод команд в терминале
window.handleTermInput = function(e) {
    if (e.key === 'Enter') {
        const input = document.getElementById('term-input');
        const termOut = document.getElementById('term-out');
        const prompt = document.getElementById('term-prompt')?.innerText || 'root@debian:~#';
        if (!input || !termOut) return;
        
        const cmd = input.value.trim();
        if (!cmd) return;
        
        termOut.innerHTML += `${prompt} ${cmd}\n`;
        
        const lower = cmd.toLowerCase();
        if (lower === 'clear' || lower === 'cls') {
            termOut.innerHTML = '';
        } else if (lower === 'help') {
            termOut.innerHTML += `Доступные команды:\n  help      - вызов справки\n  cls, clear - очистка терминала\n  neofetch  - информация о системе\n  date      - текущая дата\n  whoami    - текущий пользователь\n`;
        } else if (lower === 'neofetch') {
            termOut.innerHTML += `\n OS: Cyber Command OS v4.0 PRO\n Host: Web Terminal\n Kernel: 5.15.0-cyber\n Shell: bash 5.2.15\n CPU: Virtual Cyber Engine (8)\n Memory: 4096MB / 16384MB\n\n`;
        } else if (lower === 'date') {
            termOut.innerHTML += `${new Date().toLocaleString()}\n`;
        } else if (lower === 'whoami') {
            termOut.innerHTML += `cyber_agent_root\n`;
        } else {
            termOut.innerHTML += `bash: ${cmd}: command not found\n`;
        }
        
        input.value = '';
        termOut.scrollTop = termOut.scrollHeight;
    }
};

// Очистка терминала
window.clearTerm = function() {
    const termOut = document.getElementById('term-out');
    if (termOut) termOut.innerHTML = '';
};

// Универсальная функция копирования кода
window.copyCode = function(btn) {
    const codeBlock = btn.parentElement;
    let text = codeBlock.innerText;
    text = text.replace('Copy', '').trim();
    
    navigator.clipboard.writeText(text).then(() => {
        const originalText = btn.innerText;
        btn.innerText = 'Copied!';
        btn.style.color = 'var(--accent-green)';
        setTimeout(() => {
            btn.innerText = originalText;
            btn.style.color = '';
        }, 2000);
    });
};

// Инициализация Monaco Editor
let monacoEditorInstance = null;

window.initMonaco = function() {
    if (typeof require !== 'undefined' && document.getElementById('editor-container')) {
        require.config({ paths: { vs: 'https://cdnjs.cloudflare.com/ajax/libs/monaco-editor/0.38.0/min/vs' } });
        require(['vs/editor/editor.main'], function () {
            monacoEditorInstance = monaco.editor.create(document.getElementById('editor-container'), {
                value: '// Cyber Command Station Code Editor\nconsole.log("System Ready");\n',
                language: 'python',
                theme: 'vs-dark',
                automaticLayout: true
            });
        });
    }
};

// Смена языка в Monaco
window.changeLang = function() {
    const lang = document.getElementById('lang-select').value;
    if (monacoEditorInstance && window.monaco) {
        monaco.editor.setModelLanguage(monacoEditorInstance.getModel(), lang);
    }
};
