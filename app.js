let editor;

require.config({ paths: { 'vs': 'https://cdnjs.cloudflare.com/ajax/libs/monaco-editor/0.34.1/min' }});

window.addEventListener('DOMContentLoaded', () => {
    require(['vs/editor/editor.main'], function() {
        const editorContainer = document.getElementById('editor');
        if (!editorContainer) return;

        editor = monaco.editor.create(editorContainer, {
            value: `#include <iostream>\nusing namespace std;\n\nint main() {\n    cout << "Cyber OS Debian Kernel Initialized!" << endl;\n    return 0;\n}`,
            language: 'cpp',
            theme: 'vs-dark',
            automaticLayout: true,
            fontSize: 14,
            minimap: { enabled: false }
        });

        CyberVFS.init();
        print("Cyber OS Core v3.0 [Stable Termux-X11 Edition] запущен.", "info");
        print("Введите 'help' для списка системных команд.", "system");
    });
});
