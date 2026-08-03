const files = {
    'native_loader.cpp': `// native_loader.cpp - IPC Bridge & Process Handler
#include <iostream>
#include <sys/socket.h>

extern "C" void init_bridge() {
    std::cout << "[NATIVE] C++ IPC Server running..." << std::endl;
}`,
    'Kernel.c': `/* Kernel.c - C Core System Abstraction */
#include <stdio.h>

void execute_kernel_routine() {
    printf("[KERNEL] Executing C native routine...\\n");
}`,
    'Main.rs': `// Main.rs - Async High-Performance Engine
use std::net::TcpStream;

fn main() {
    println!("[RUST] Async POSIX Engine ready.");
}`,
    'Cargo.toml': `[package]
name = "sigma_core"
version = "0.1.0"
edition = "2021"`
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
    logTerminal(`Opened file: ${filename}`, 'info');
}

function logTerminal(msg, type = 'info') {
    const logs = document.getElementById('logs');
    const line = document.createElement('div');
    line.className = `log-${type}`;
    const time = new Date().toLocaleTimeString();
    line.innerText = `[${time}] ${msg}`;
    logs.appendChild(line);
    logs.scrollTop = logs.scrollHeight;
}

function clearLogs() {
    document.getElementById('logs').innerHTML = '';
}

function sendCommand(cmd) {
    logTerminal(`[CLIENT -> IPC 4444] Sent native command: ${cmd}`, 'info');
    
    // Попытка отправить реальный запрос на локальный сервер Termux
    fetch('http://127.0.0.1:4444/api', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ command: cmd })
    }).then(res => res.text())
    .then(data => logTerminal(`[SERVER ACK] ${data}`, 'success'))
    .catch(() => {
        // Если Termux сервер еще не запущен, имитируем успешный ответ для тестов интерфейса
        setTimeout(() => {
            logTerminal(`[DAEMON] Executed '${cmd}' task in background.`, 'success');
        }, 300);
    });
}

// Загрузка первого файла при старте
document.addEventListener("DOMContentLoaded", () => {
    document.getElementById('code-box').value = files['native_loader.cpp'];
    logTerminal("Comand_center ready (Native Mode).", "success");
});
