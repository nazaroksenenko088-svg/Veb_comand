let storedState = JSON.parse(localStorage.getItem('CYBER_OS_STATE')) || {};
let cyberState = {
    operator: storedState.operator || "Root",
    keys: Array.isArray(storedState.keys) ? storedState.keys : [],
    plugins: Array.isArray(storedState.plugins) ? storedState.plugins : []
};

function saveState() {
    localStorage.setItem('CYBER_OS_STATE', JSON.stringify(cyberState));
    CyberDevTools.updateStorage();
}

const CyberAI = {
    renderUI() {
        const nameInput = document.getElementById('account-name');
        if(nameInput) nameInput.value = cyberState.operator;

        const keysList = document.getElementById('keys-list');
        if(keysList) {
            keysList.innerHTML = cyberState.keys.map((k, i) => 
                `<div class="list-item"><span>${k.prov} [***]</span><button class="cyber-btn danger btn-sm" onclick="CyberAI.delKey(${i})">X</button></div>`
            ).join('') || '<span style="color:var(--text-dim)">No keys registered.</span>';
        }

        const pluginsList = document.getElementById('plugins-list');
        if(pluginsList) {
            pluginsList.innerHTML = cyberState.plugins.map((p, i) => 
                `<div class="list-item"><span>${p.name}</span><button class="cyber-btn danger btn-sm" onclick="CyberAI.delPlugin(${i})">X</button></div>`
            ).join('') || '<span style="color:var(--text-dim)">No plugins deployed.</span>';
        }
    },
    addKey() {
        const p = document.getElementById('ai-provider').value;
        const k = document.getElementById('api-key-input').value;
        if(!k) return;
        cyberState.keys.push({ prov: p, key: k });
        document.getElementById('api-key-input').value = '';
        saveState(); CyberAI.renderUI(); CyberUI.toast("API Key registered.");
    },
    delKey(i) { cyberState.keys.splice(i, 1); saveState(); CyberAI.renderUI(); },
    addPlugin() {
        const n = document.getElementById('plugin-name').value;
        if(!n) return;
        cyberState.plugins.push({ name: n });
        document.getElementById('plugin-name').value = '';
        saveState(); CyberAI.renderUI(); CyberUI.toast("Plugin deployed.");
    },
    delPlugin(i) { cyberState.plugins.splice(i, 1); saveState(); CyberAI.renderUI(); },
    saveSettings() {
        const nameInput = document.getElementById('account-name');
        if(nameInput) cyberState.operator = nameInput.value;
        saveState(); CyberUI.toast("Settings saved.");
    },
    clearData() {
        if(confirm("Wipe system state?")) {
            localStorage.removeItem('CYBER_OS_STATE');
            location.reload();
        }
    }
};

document.addEventListener('DOMContentLoaded', () => {
    CyberAI.renderUI();
});
