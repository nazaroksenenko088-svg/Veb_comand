// features.js - Utility & Script Hub
document.addEventListener("DOMContentLoaded", () => {
    initFeatureHub();
});

function initFeatureHub() {
    const container = document.getElementById('features-container');
    if (!container) return;

    container.innerHTML = `
        <h3>🚀 Панель генерации утилит</h3>
        <p style="color: var(--text-muted); font-size: 13px; margin-bottom: 15px;">
            Создание и экспорт вспомогательных скриптов мониторинга.
        </p>

        <div style="display: flex; flex-direction: column; gap: 15px;">
            <div style="background: var(--bg-tertiary); padding: 12px; border-radius: 6px; border: 1px solid var(--border-color);">
                <h4 style="color: var(--accent-blue); margin-bottom: 6px;">📊 Системный монитор логов</h4>
                <p style="font-size: 12px; color: var(--text-muted); margin-bottom: 10px;">
                    Генерирует скрипт отслеживания системных событий и отправки телеметрии.
                </p>
                <div style="display: flex; gap: 10px; margin-bottom: 8px;">
                    <input type="text" id="endpoint-input" placeholder="Введите целевой endpoint..." style="flex: 1; background: var(--bg-primary); border: 1px solid var(--border-color); color: #fff; padding: 6px 10px; border-radius: 4px; font-size: 12px;">
                    <button class="btn blue sm" onclick="generateMonitorScript()">Сгенерировать</button>
                </div>
                <textarea id="generator-output" class="code-area" style="height: 100px; font-size: 11px;" placeholder="Здесь появится скомпилированный код..."></textarea>
            </div>
        </div>
    `;
}

function generateMonitorScript() {
    const endpoint = document.getElementById('endpoint-input').value.trim() || "http://127.0.0.1:4444/log";
    
    const scriptContent = `-- System Monitor Script (Auto-generated)
local target = "${endpoint}"

function reportStatus(status)
    print("[MONITOR] Status reported: " .. status)
end

reportStatus("ACTIVE")`;

    document.getElementById('generator-output').value = scriptContent;
    logTerminal("Мониторинговый скрипт успешно сгенерирован.", "success");
}
