// Переключение вкладок
window.openTab = function(tabId) {
    document.querySelectorAll('.tab-content').forEach(tab => {
        tab.classList.remove('active');
    });
    document.querySelectorAll('.tab-btn').forEach(btn => {
        btn.classList.remove('active');
    });
    
    document.getElementById(tabId).classList.add('active');
    event.currentTarget.classList.add('active');
};

// Смена тем оформления
window.changeTheme = function() {
    const theme = document.getElementById('theme-select').value;
    document.documentElement.setAttribute('data-theme', theme);
    localStorage.setItem('cyber_theme', theme);
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
    
    if (prompts[preset]) {
        promptSpan.innerText = prompts[preset];
    }
};

// Очистка терминала
window.clearTerm = function() {
    document.getElementById('term-out').innerHTML = '';
};

// Универсальная функция копирования кода для шпаргалок
window.copyCode = function(btn) {
    const codeBlock = btn.parentElement;
    let text = codeBlock.innerText;
    // Убираем текст кнопки "Copy" из буфера обмена
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
