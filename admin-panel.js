// ============================================================
// ADMIN-PANEL.JS - СИСТЕМНАЯ ПАНЕЛЬ
// ============================================================

let adminPanelOpen = false;
let isDeveloper = false;

// === ОПРЕДЕЛЕНИЕ ПРАВ ДОСТУПА ===
function checkDeveloperStatus() {
    const password = localStorage.getItem('dev_password');
    if (password === 'CYBER_ADMIN_2024') {
        isDeveloper = true;
    }
    return isDeveloper;
}

// === ОТКРЫТИЕ/ЗАКРЫТИЕ АДМИН-ПАНЕЛИ ===
function toggleAdminPanel() {
    const panel = document.getElementById('admin-panel');
    if (!panel) return;
    
    adminPanelOpen = !adminPanelOpen;
    panel.style.display = adminPanelOpen ? 'flex' : 'none';
    
    if (adminPanelOpen) {
        renderAdminContent();
    }
}

// === РЕНДЕРИНГ СОДЕРЖИМОГО ПАНЕЛИ ===
function renderAdminContent() {
    const content = document.getElementById('admin-content');
    if (!content) return;
    
    checkDeveloperStatus();
    
    if (isDeveloper) {
        renderDeveloperConsole(content);
    } else {
        renderProfileSettings(content);
    }
}

// === КОНСОЛЬ РАЗРАБОТЧИКА ===
function renderDeveloperConsole(container) {
    container.innerHTML = `
        <div style="font-size: 0.85rem;">
            <div style="border-bottom: 1px solid var(--border); padding-bottom: 8px; margin-bottom: 8px;">
                <strong style="color: var(--accent);">👨‍💻 DEVELOPER CONSOLE</strong>
            </div>
            
            <div style="margin-bottom: 12px;">
                <label style="color: var(--accent); font-size: 0.8rem;">System Info:</label>
                <div style="background: #020617; border: 1px solid var(--border); padding: 8px; border-radius: 4px; margin-top: 4px; font-size: 0.75rem;">
                    <div>Version: v4.0 PRO</div>
                    <div>OS: ${navigator.userAgent.substring(0, 40)}...</div>
                    <div>Memory: ${navigator.deviceMemory || 'N/A'} GB</div>
                    <div>Cores: ${navigator.hardwareConcurrency || 'N/A'}</div>
                </div>
            </div>
            
            <div style="margin-bottom: 12px;">
                <label style="color: var(--accent-green); font-size: 0.8rem;">Stats Override:</label>
                <div style="display: flex; gap: 4px; margin-top: 4px;">
                    <button class="btn btn-outline" style="flex: 1; padding: 4px 8px; font-size: 0.75rem;" onclick="devAddXP(100)">+100 XP</button>
                    <button class="btn btn-outline" style="flex: 1; padding: 4px 8px; font-size: 0.75rem;" onclick="devAddCoins(500)">+500 CC</button>
                </div>
                <div style="display: flex; gap: 4px; margin-top: 4px;">
                    <button class="btn btn-outline" style="flex: 1; padding: 4px 8px; font-size: 0.75rem;" onclick="devResetStats()">Reset Stats</button>
                    <button class="btn btn-outline" style="flex: 1; padding: 4px 8px; font-size: 0.75rem;" onclick="devLevelUp()">Level +1</button>
                </div>
            </div>
            
            <div style="margin-bottom: 12px;">
                <label style="color: var(--accent-purple); font-size: 0.8rem;">Storage Management:</label>
                <div style="display: flex; gap: 4px; margin-top: 4px;">
                    <button class="btn btn-outline" style="flex: 1; padding: 4px 8px; font-size: 0.75rem;" onclick="devShowStorage()">Show Storage</button>
                    <button class="btn btn-outline" style="flex: 1; padding: 4px 8px; font-size: 0.75rem;" onclick="devClearStorage()">Clear All</button>
                </div>
            </div>
            
            <div style="border-top: 1px solid var(--border); padding-top: 8px;">
                <button class="btn btn-outline" style="width: 100%; padding: 6px; font-size: 0.8rem;" onclick="devLogout()">🚪 Logout Dev</button>
            </div>
        </div>
    `;
}

// === НАСТРОЙКИ ПРОФИЛЯ ===
function renderProfileSettings(container) {
    container.innerHTML = `
        <div style="font-size: 0.85rem;">
            <div style="border-bottom: 1px solid var(--border); padding-bottom: 8px; margin-bottom: 8px;">
                <strong style="color: var(--accent);">⚙️ PROFILE SETTINGS</strong>
            </div>
            
            <div style="margin-bottom: 12px;">
                <label style="color: var(--accent); font-size: 0.8rem;">Имя профиля:</label>
                <input type="text" id="profile-name" placeholder="Введи имя" style="width: 100%; margin-top: 4px; padding: 6px; border-radius: 4px;" value="${localStorage.getItem('profile_name') || 'Cyber Agent'}">
            </div>
            
            <div style="margin-bottom: 12px;">
                <label style="color: var(--accent); font-size: 0.8rem;">Email:</label>
                <input type="email" id="profile-email" placeholder="your@email.com" style="width: 100%; margin-top: 4px; padding: 6px; border-radius: 4px;" value="${localStorage.getItem('profile_email') || ''}">
            </div>
            
            <div style="margin-bottom: 12px;">
                <label style="color: var(--accent); font-size: 0.8rem;">Тема оформления:</label>
                <select id="admin-theme" onchange="changeThemeFromAdmin()" style="width: 100%; margin-top: 4px; padding: 6px; border-radius: 4px;">
                    <option value="cyberpunk">Cyberpunk Dark</option>
                    <option value="matrix">Matrix Green</option>
                    <option value="dracula">Dracula Purple</option>
                    <option value="nord">Nord Cool</option>
                </select>
            </div>
            
            <div style="margin-bottom: 12px;">
                <label style="color: var(--accent-purple); font-size: 0.8rem;">🔐 Dev Mode (пароль):</label>
                <input type="password" id="dev-password" placeholder="Пароль разработчика" style="width: 100%; margin-top: 4px; padding: 6px; border-radius: 4px;">
                <button class="btn btn-purple" style="width: 100%; margin-top: 6px; padding: 6px; font-size: 0.8rem;" onclick="unlockDevMode()">Unlock Dev</button>
            </div>
            
            <div style="border-top: 1px solid var(--border); padding-top: 8px;">
                <button class="btn btn-main" style="width: 100%; padding: 6px; font-size: 0.8rem;" onclick="saveProfileSettings()">💾 Сохранить</button>
            </div>
        </div>
    `;
    
    const select = container.querySelector('#admin-theme');
    if (select && window.appState) {
        select.value = appState.theme;
    }
}

// === DEVELOPER ФУНКЦИИ ===
function devAddXP(amount) {
    if (!isDeveloper) return showNotification('❌ Access Denied');
    updateXP(amount);
    showNotification(`✅ +${amount} XP`);
}

function devAddCoins(amount) {
    if (!isDeveloper) return showNotification('❌ Access Denied');
    appState.coins += amount;
    updateStatsUI();
    saveStats();
    showNotification(`✅ +${amount} CC`);
}

function devResetStats() {
    if (!isDeveloper) return showNotification('❌ Access Denied');
    appState.level = 1;
    appState.xp = 0;
    appState.coins = 0;
    updateStatsUI();
    saveStats();
    showNotification('✅ Stats Reset');
}

function devLevelUp() {
    if (!isDeveloper) return showNotification('❌ Access Denied');
    appState.level++;
    appState.xp = 0;
    updateStatsUI();
    saveStats();
    showNotification(`✅ Level → ${appState.level}`);
}

function devShowStorage() {
    if (!isDeveloper) return;
    console.table({
        stats: localStorage.getItem('stats'),
        cyber_theme: localStorage.getItem('cyber_theme'),
        gemini_key: localStorage.getItem('gemini_api_key') ? '***SET***' : 'NOT SET'
    });
    showNotification('📊 Storage logged to console');
}

function devClearStorage() {
    if (!isDeveloper) return;
    if (confirm('⚠️ Это удалит ВСЕ данные! Продолжить?')) {
        localStorage.clear();
        appState.level = 1;
        appState.xp = 0;
        appState.coins = 0;
        updateStatsUI();
        showNotification('✅ All data cleared');
    }
}

function devLogout() {
    localStorage.removeItem('dev_password');
    isDeveloper = false;
    adminPanelOpen = false;
    document.getElementById('admin-panel').style.display = 'none';
    showNotification('✅ Dev mode disabled');
}

function saveProfileSettings() {
    const name = document.getElementById('profile-name')?.value;
    const email = document.getElementById('profile-email')?.value;
    if (name !== undefined) localStorage.setItem('profile_name', name);
    if (email !== undefined) localStorage.setItem('profile_email', email);
    showNotification('✅ Профиль сохранен');
}

function changeThemeFromAdmin() {
    const select = document.getElementById('admin-theme');
    if (select && typeof changeTheme === 'function') {
        changeTheme(select.value);
    }
}

function unlockDevMode() {
    const passwordInput = document.getElementById('dev-password');
    if (!passwordInput) return;
    if (passwordInput.value === 'CYBER_ADMIN_2024') {
        localStorage.setItem('dev_password', passwordInput.value);
        isDeveloper = true;
        renderAdminContent();
        showNotification('✅ Dev Mode Activated!');
    } else {
        showNotification('❌ Неправильный пароль');
    }
}
