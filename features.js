// --- QUEST HUB & PROOFS ---
window.spinAll = function() {
    const grid = document.getElementById('grid');
    grid.innerHTML = `
        <div class="card" style="border:1px solid var(--accent);">
            <h4 style="color:var(--accent); margin-top:0;">⚡ Активный кибер-квест</h4>
            <p style="font-size:0.85rem;">Задача: Написать скрипт автоматизации бэкапов на Python или Bash.</p>
            <p style="font-size:0.8rem; color:var(--text-muted);">Награда: +150 XP, +50 CC</p>
        </div>
    `;
};

window.toggleProofModal = function() {
    const modal = document.getElementById('proof-modal');
    modal.style.display = modal.style.display === 'none' ? 'block' : 'none';
};

window.submitTaskProof = function() {
    const text = document.getElementById('proof-text').value;
    if (!text) {
        alert('Пожалуйста, введи текстовый отчет!');
        return;
    }
    alert('Доказательства отправлены! Награды зачислены.');
    document.getElementById('proof-text').value = '';
    window.toggleProofModal();
};

// --- GEMINI AI ---
window.saveGeminiKey = function() {
    const key = document.getElementById('gemini-key-input').value;
    if (key) {
        localStorage.setItem('gemini_api_key', key);
        document.getElementById('key-status').innerText = '✅ Ключ успешно сохранен в памяти!';
        document.getElementById('key-status').style.color = 'var(--accent-green)';
    }
};

window.wipeContext = function() {
    document.getElementById('chat-msgs').innerHTML = '<div class="chat-msg chat-ai">Контекст очищен. Начинаем с чистого листа!</div>';
    document.getElementById('token-count').innerText = '0 / 32000';
    document.getElementById('token-fill').style.width = '0%';
};

window.loadPrompt = function() {
    const select = document.getElementById('prompt-deck');
    const input = document.getElementById('chat-input');
    const prompts = {
        refactor_cs: 'Сделай рефакторинг этого кода на C# для улучшения производительности:',
        ui_gen: 'Сгенерируй современный адаптивный CSS/HTML интерфейс для:',
        debug: 'Найди логическую ошибку и утечку памяти в этом куске кода:',
        optimize: 'Оптимизируй алгоритм по времени выполнения:',
        security: 'Проверь этот код на уязвимости (инъекции, переполнение буфера):'
    };
    if (prompts[select.value]) {
        input.value = prompts[select.value];
    }
};

window.sendGeminiMsg = function() {
    const input = document.getElementById('chat-input');
    const msgs = document.getElementById('chat-msgs');
    if (!input.value.trim()) return;

    msgs.innerHTML += `<div class="chat-msg" style="background:rgba(255,255,255,0.05); padding:8px; border-radius:6px; margin-bottom:8px;"><strong>Ты:</strong> ${input.value}</div>`;
    
    const userQuery = input.value;
    input.value = '';

    setTimeout(() => {
        msgs.innerHTML += `<div class="chat-msg chat-ai" style="background:rgba(168,85,247,0.1); padding:8px; border-radius:6px; margin-bottom:8px; border-left:3px solid var(--accent-purple);"><strong>Gemini:</strong> Запрос принят. Подключи API ключ для генерации реального ответа!</div>`;
        msgs.scrollTop = msgs.scrollHeight;
    }, 500);
};

// --- MONACO VS CODE ---
window.changeLang = function() {
    // Интеграция с Monaco Editor (если редактор инициализирован)
    console.log("Language changed to:", document.getElementById('lang-select').value);
};

// --- SCRIPT VAULT ---
window.addScript = function() {
    const name = document.getElementById('script-name').value;
    const path = document.getElementById('script-path').value;
    const desc = document.getElementById('script-desc').value;
    
    if (!name) {
        alert('Введи имя скрипта!');
        return;
    }

    const grid = document.getElementById('vault-grid');
    grid.innerHTML += `
        <div class="card">
            <h4 style="color:var(--accent-green); margin-top:0;">📜 ${name}</h4>
            <p style="font-size:0.8rem; color:var(--text-muted);">Путь: ${path || 'Не указан'}</p>
            <p style="font-size:0.85rem;">${desc || 'Без описания'}</p>
            <button class="btn btn-outline" style="width:100%; font-size:0.75rem;" onclick="alert('Запуск ${name}...')">▶ Запустить</button>
        </div>
    `;
    
    document.getElementById('script-name').value = '';
    document.getElementById('script-path').value = '';
    document.getElementById('script-desc').value = '';
};

// --- RADIO & POMODORO ---
window.playRadio = function(genre) {
    const audio = document.getElementById('audio-player');
    const streams = {
        lofi: 'https://stream.zeno.fm/f3wvbbqmdg8uv',
        synthwave: 'https://stream.zeno.fm/0r0xa792cheuv',
        darksynth: 'https://stream.zeno.fm/91568hx51rhvv'
    };
    if (streams[genre]) {
        audio.src = streams[genre];
        audio.play().catch(() => alert('Автовоспроизведение заблокировано браузером. Нажми Play вручную.'));
    }
};

window.stopRadio = function() {
    const audio = document.getElementById('audio-player');
    audio.pause();
    audio.currentTime = 0;
};

let pomodoroTimer = null;
window.startPomodoro = function() {
    if (pomodoroTimer) return;
    let mins = parseInt(document.getElementById('pomodoro-min').value) || 25;
    let totalSecs = mins * 60;
    let currentSecs = totalSecs;

    pomodoroTimer = setInterval(() => {
        let m = Math.floor(currentSecs / 60);
        let s = currentSecs % 60;
        document.getElementById('pomodoro-display').innerText = `${m.toString().padStart(2, '0')}:${s.toString().padStart(2, '0')}`;
        
        let progress = ((totalSecs - currentSecs) / totalSecs) * 100;
        document.getElementById('pomodoro-bar').style.width = `${progress}%`;

        if (currentSecs <= 0) {
            clearInterval(pomodoroTimer);
            pomodoroTimer = null;
            alert('Сессия завершена! Отличная работа!');
        }
        currentSecs--;
    }, 1000);
};

window.pausePomodoro = function() {
    clearInterval(pomodoroTimer);
    pomodoroTimer = null;
};

window.resetPomodoro = function() {
    clearInterval(pomodoroTimer);
    pomodoroTimer = null;
    let mins = document.getElementById('pomodoro-min').value || 25;
    document.getElementById('pomodoro-display').innerText = `${mins.toString().padStart(2, '0')}:00`;
    document.getElementById('pomodoro-bar').style.width = '0%';
};
