// js/app.js

// Переключение вкладок
function switchTab(tabId) {
    document.querySelectorAll('.tab-content').forEach(content => {
        content.classList.remove('active');
    });
    
    const targetTab = document.getElementById(tabId);
    if (targetTab) {
        targetTab.classList.add('active');
    }
}

// Инициализация Monaco Editor
let codeEditor = null;

function initMonaco() {
    if (typeof require === 'undefined') return;

    require.config({ paths: { 'vs': 'https://cdnjs.cloudflare.com/ajax/libs/monaco-editor/0.45.0/min/vs' }});
    require(['vs/editor/editor.main'], function() {
        codeEditor = monaco.editor.create(document.getElementById('editor-container'), {
            value: `// Command Center Core Logic\n// Compiled Wasm target: Rust / C / C++\n\nfn main() {\n    println!("System online. Route: security.cloudflare-dns.com");\n}`,
            language: 'rust',
            theme: 'vs-dark',
            automaticLayout: true,
            fontSize: 14,
            minimap: { enabled: true }
        });
        console.log('[App] Monaco Editor успешно запущен.');
    });
}

// Загрузчик Wasm-модулей из папки /core
async function loadWasmCore(wasmPath) {
    try {
        const response = await fetch(wasmPath);
        const bytes = await response.arrayBuffer();
        const { instance } = await WebAssembly.instantiate(bytes);
        console.log(`[Wasm Loader] Модуль ${wasmPath} загружен.`, instance.exports);
        return instance.exports;
    } catch (err) {
        console.error(`[Wasm Loader] Ошибка загрузки ${wasmPath}:`, err);
        return null;
    }
}

document.addEventListener('DOMContentLoaded', () => {
    initMonaco();
});
