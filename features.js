const CyberDevTools = (() => {
    try {
        const getTime = () => {
            const d = new Date();
            return `${d.getHours().toString().padStart(2,'0')}:${d.getMinutes().toString().padStart(2,'0')}:${d.getSeconds().toString().padStart(2,'0')}`;
        };

        const print = (msg, type = 'log') => {
            const area = document.getElementById('dt-console-output');
            if(!area) return;
            const div = document.createElement('div');
            div.className = `console-line ${type}`;
            div.innerHTML = `<span class="c-time">${getTime()}</span><span class="c-type">[${type.toUpperCase()}]</span><span class="c-text">${msg}</span>`;
            area.appendChild(div);
            area.scrollTop = area.scrollHeight;
        };

        const origLog = console.log, origErr = console.error, origWarn = console.warn;
        console.log = function(...args) { print(args.join(' '), 'log'); origLog.apply(console, args); };
        console.error = function(...args) { print(args.join(' '), 'error'); origErr.apply(console, args); };
        console.warn = function(...args) { print(args.join(' '), 'warn'); origWarn.apply(console, args); };

        return {
            switchTab(dtId, btn) {
                document.querySelectorAll('.dt-panel-body').forEach(el => el.classList.remove('active'));
                document.querySelectorAll('.dt-tab-btn').forEach(el => el.classList.remove('active'));
                document.getElementById(`dt-panel-${dtId}`).classList.add('active');
                btn.classList.add('active');
                if(dtId === 'storage') CyberDevTools.updateStorage();
            },
            print,
            clearConsole() { document.getElementById('dt-console-output').innerHTML = ''; },
            runCmd() {
                const input = document.getElementById('dt-js-input');
                if(!input || !input.value) return;
                const cmd = input.value;
                print(`> ${cmd}`, 'system');
                try {
                    const res = eval(cmd);
                    if(res !== undefined) print(JSON.stringify(res), 'log');
                } catch(e) { print(e.message, 'error'); }
                input.value = '';
            },
            updateStorage() {
                const table = document.getElementById('storage-table');
                if(!table) return;
                let html = '<tr><th>Key</th><th>Value</th></tr>';
                for (let i = 0; i < localStorage.length; i++) {
                    const k = localStorage.key(i);
                    html += `<tr><td>${k}</td><td style="word-break:break-all;">${localStorage.getItem(k)}</td></tr>`;
                }
                table.innerHTML = html;
            }
        };
    } catch(e) {
        console.error("DevTools Module Error:", e);
        return { print(){}, switchTab(){}, clearConsole(){}, runCmd(){}, updateStorage(){} };
    }
})();

// Network Interceptor
const CyberNetwork = (() => {
    try {
        const origFetch = window.fetch;
        window.fetch = async function(...args) {
            const url = args[0];
            const method = (args[1] && args[1].method) ? args[1].method : 'GET';
            const time = new Date().toLocaleTimeString();
            try {
                const res = await origFetch.apply(this, args);
                const table = document.getElementById('network-table');
                if(table) {
                    table.insertRow(-1).innerHTML = `<td style="color:var(--text-dim);">${time}</td><td style="color:var(--info);">${method}</td><td>${url}</td><td style="color:var(--accent);">${res.status}</td>`;
                }
                return res;
            } catch (err) {
                const table = document.getElementById('network-table');
                if(table) {
                    table.insertRow(-1).innerHTML = `<td style="color:var(--text-dim);">${time}</td><td style="color:var(--info);">${method}</td><td>${url}</td><td style="color:var(--danger);">FAIL</td>`;
                }
                throw err;
            }
        };
    } catch(e) {
        console.error("Network Module Error:", e);
    }
})();

document.addEventListener('DOMContentLoaded', () => {
    const input = document.getElementById('dt-js-input');
    if(input) {
        input.addEventListener('keypress', e => {
            if(e.key === 'Enter') CyberDevTools.runCmd();
        });
    }
});
