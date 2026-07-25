const CyberUI = (() => {
    try {
        return {
            switchTab(tabId, btn) {
                document.querySelectorAll('.tab-content').forEach(el => el.classList.remove('active'));
                document.querySelectorAll('.nav-btn').forEach(el => el.classList.remove('active'));
                document.getElementById(tabId).classList.add('active');
                btn.classList.add('active');
                if (tabId === 'ide') CyberEditor.layout();
            },
            toast(msg) {
                const container = document.getElementById('toast-container');
                if(!container) return;
                const toast = document.createElement('div');
                toast.className = 'cyber-toast';
                toast.innerText = `>> ${msg}`;
                container.appendChild(toast);
                setTimeout(() => toast.remove(), 2500);
            }
        };
    } catch(e) {
        console.error("UI Module Error:", e);
        return { switchTab(){}, toast(){} };
    }
})();

let editorInstance = null;
const CyberEditor = (() => {
    try {
        require.config({ paths: { 'vs': 'https://cdnjs.cloudflare.com/ajax/libs/monaco-editor/0.45.0/min/vs' }});
        require(['vs/editor/editor.main'], function() {
            try {
                editorInstance = monaco.editor.create(document.getElementById('monaco-editor-container'), {
                    value: '// Cyber OS Modular Core Ready\nint main() {\n    return 0;\n}',
                    language: 'cpp',
                    theme: 'vs-dark',
                    automaticLayout: false,
                    fontSize: 15,
                    minimap: { enabled: false }
                });
            } catch(innerErr) {
                console.error("Monaco create error:", innerErr);
            }
        });

        return {
            layout() {
                if(editorInstance) {
                    setTimeout(() => editorInstance.layout(), 50);
                }
            },
            insert(text) {
                if(!editorInstance) return;
                const selection = editorInstance.getSelection();
                editorInstance.executeEdits("macro", [{ range: selection, text: text, forceMoveMarkers: true }]);
                editorInstance.focus();
            }
        };
    } catch(e) {
        console.error("Editor Module Error:", e);
        return { layout(){}, insert(){} };
    }
})();
