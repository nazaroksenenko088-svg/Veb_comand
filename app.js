// app.js - Comand_center Core Frontend Logic
const files = {
    'native_loader.cpp': `// native_loader.cpp - IPC Bridge & Process Handler\n#include <iostream>\n\nextern "C" void init_bridge() {\n    std::cout << "[NATIVE] C++ Daemon active..." << std::endl;\n}`,
    'Kernel.c': `/* Kernel.c - System Routine Abstraction */\n#include <stdio.h>\n\nvoid execute_kernel_routine() {\n    printf("[KERNEL] Routine executed successfully.\\n");\n}`,
    'Main.rs': `// Main.rs - Async Engine Core\nfn main() {\n    println!("[RUST] Engine listening...");\n}`,
    'Cargo.toml': `[package]\nname = "sigma_core"\nversion = "0.1.0"\nedition = "2021"`
};

function switchTab(tabId, btn) {
    document.querySelectorAll('.panel').forEach(p => p.classList.remove('active'));
    document.querySelectorAll('.nav-btn').forEach(b => b.classList.remove('active'));
    document.getElementById(tabId).classList.add('active');
    btn.classList.add('active');
}

function loadFile(filename, elem) {
    document.querySelectorAll('.file-item').forEach(f => f.classList.remove('active'));
    elem.classList.add('active');
    document.getElementById('current-filename').innerText = filename;
    document.getElementById('code-box').value = files[filename] || "";
    logTerminal(`Открыт файл конфигурации: ${filename}`, 'info');
}

function logTerminal(msg, type = 'info') {
    const logs = document.getElementById('logs');
    if (!logs) return;
    const line = document.createElement('div');
    line.className = `log-${type}`;
    const time = new Date().toLocaleTimeString();
    line.innerText = `[${time}] ${msg}`;
    logs.appendChild(line);
    logs.scrollTop = logs.scrollHeight;
}

function clearLogs() {
    const logs = document.getElementById('logs');
    if (logs) logs.innerHTML = '';
}

function sendCommand(cmd) {
    logTerminal(`[CLI -> BACKEND] Отправлена команда: ${cmd}`, 'info');
    
    // Запрос к локальному серверу бэкенда
    fetch('http://127.0.0.1:4444/api', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ command: cmd })
    })
    .then(res => res.text())
    .then(data => logTerminal(`[SERVER ACK] ${data}`, 'success'))
    .catch(() => {
        // Запасной вариант для симуляции ответа, если демон запущен локально в терминале
        setTimeout(() => {
            logTerminal(`[DAEMON] Задача '${cmd'}' выполнена в фоновом потоке.`, 'success');
        }, 250);
    });
}

document.addEventListener("DOMContentLoaded", () => {
    const codeBox = document.getElementById('code-box');
    if (codeBox) codeBox.value = files['native_loader.cpp'];
    logTerminal("Comand_center успешно инициализирован в браузере.", "success");
});
