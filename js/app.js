// js/app.js

let codeEditor = null;

// Шаблоны кода под разные языки
const codeTemplates = {
    rust: `// Rust Core Component\nfn main() {\n    println!("System online. Route: security.cloudflare-dns.com");\n}`,
    cpp: `// C++ Native Loader\n#include <iostream>\n\nint main() {\n    std::cout << "Command Center C++ Engine Active" << std::endl;\n    return 0;\n}`,
    c: `// C System Kernel\n#include <stdio.h>\n\nvoid init() {\n    printf("Kernel initialized.\\n");\n}`,
    csharp: `// C# Backend Utility\nusing System;\n\nclass Program {\n    static void Main() {\n        Console.WriteLine("C# Subsystem Loaded");\n    }\n}`,
    javascript: `// JS High-Level Orchestrator\nconsole.log("JavaScript Bridge Running");`
};

// Смена языка в Monaco
function changeLanguage(lang) {
    if (!codeEditor) return;
    const model = codeEditor.getModel();
    monaco.editor.setModelLanguage(model, lang);
    if (codeTemplates[lang]) {
        codeEditor.setValue(codeTemplates[lang]);
    }
    console.log(`[Monaco] Язык переключен на: ${lang}`);
}

// Переключение вкладок
function switchTab(tabId) {
    document.querySelectorAll('.tab-content').forEach(content => content.classList.remove('active'));
    document.querySelectorAll('.menu-item').forEach(item => item.classList.remove('active'));
    
    const targetTab = document.getElementById(tabId);
    const targetMenu = document.querySelector(`[data-tab="${tabId}"]`);
    
    if (targetTab) targetTab.classList.add('active');
    if (targetMenu) targetMenu.classList.add('active');
}

// Инициализация Monaco
function initMonaco() {
    if (typeof require === 'undefined') return;

    require.config({ paths: { 'vs': 'https://cdnjs.cloudflare.com/ajax/libs/monaco-editor/0.45.0/min/vs' }});
    require(['vs/editor/editor.main'], function() {
        codeEditor = monaco.editor.create(document.getElementById('editor-container'), {
            value: codeTemplates.rust,
            language: 'rust',
            theme: 'vs-dark',
            automaticLayout: true,
            fontSize: 14,
            minimap: { enabled: true }
        });
    });
}

// === Навигация Стрелочками ===
function initKeyboardNav() {
    const items = document.querySelectorAll('.menu-item');
    let currentIndex = 0;

    // Клик мышкой/тапом
    items.forEach((item, index) => {
        item.addEventListener('click', () => {
            currentIndex = index;
            switchTab(item.getAttribute('data-tab'));
        });
    });

    // Обработка клавиш (Стрелочки и F12)
    document.addEventListener('keydown', (e) => {
        // Игнорируем если ввод идет в Monaco или DevTools input
        if (e.target.tagName === 'INPUT' || e.target.closest('.monaco-editor')) {
            if (e.key === 'F12') {
                e.preventDefault();
                toggleDevTools();
            }
            return;
        }

        if (e.key === 'ArrowDown') {
            e.preventDefault();
            currentIndex = (currentIndex + 1) % items.length;
            items[currentIndex].focus();
            switchTab(items[currentIndex].getAttribute('data-tab'));
        } else if (e.key === 'ArrowUp') {
            e.preventDefault();
            currentIndex = (currentIndex - 1 + items.length) % items.length;
            items[currentIndex].focus();
            switchTab(items[currentIndex].getAttribute('data-tab'));
        } else if (e.key === 'F12' || (e.ctrlKey && e.shiftKey && e.key === 'I')) {
            e.preventDefault();
            toggleDevTools();
        }
    });
}

// === Встроенные DevTools ===
function toggleDevTools() {
    const panel = document.getElementById('devtools-panel');
    panel.classList.toggle('devtools-hidden');
    if (!panel.classList.contains('devtools-hidden')) {
        document.getElementById('devtools-input').focus();
    }
}

// Перехват console.log/error/warn в DevTools
(function hookConsole() {
    const oldLog = console.log;
    const oldErr = console.error;
    const oldWarn = console.warn;

    function appendDevLog(msg, type = 'info') {
        const logsContainer = document.getElementById('devtools-logs');
        if (!logsContainer) return;
        const line = document.createElement('div');
        line.className = `dev-log dev-${type}`;
        line.textContent = `[${new Date().toLocaleTimeString()}] ${msg}`;
        logsContainer.appendChild(line);
        logsContainer.scrollTop = logsContainer.scrollHeight;
    }

    console.log = function(...args) {
        oldLog.apply(console, args);
        appendDevLog(args.join(' '), 'info');
    };
    console.error = function(...args) {
        oldErr.apply(console, args);
        appendDevLog(args.join(' '), 'error');
    };
    console.warn = function(...args) {
        oldWarn.apply(console, args);
        appendDevLog(args.join(' '), 'warn');
    };
})();

// Выполнение JS прямо из консоли DevTools
function handleDevToolsExec(event) {
    if (event.key === 'Enter') {
        const input = event.target;
        const code = input.value.trim();
        if (!code) return;

        console.log(`> ${code}`);
        try {
            const result = eval(code);
            console.log(`< ${result}`);
        } catch (err) {
            console.error(err.message);
        }
        input.value = '';
    }
}

document.addEventListener('DOMContentLoaded', () => {
    initMonaco();
    initKeyboardNav();
});
