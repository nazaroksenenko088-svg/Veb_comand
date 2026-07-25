let editor;

require.config({ paths: { 'vs': 'https://cdnjs.cloudflare.com/ajax/libs/monaco-editor/0.34.1/min' }});

window.addEventListener('DOMContentLoaded', () => {
    require(['vs/editor/editor.main'], function() {
        const editorContainer = document.getElementById('editor');
        if (!editorContainer) return;

        editor = monaco.editor.create(editorContainer, {
            value: `#include <iostream>\n#include <vector>\n\nusing namespace std;\n\nint main() {\n    cout << "Cyber OS C++ Kernel Online!" << endl;\n    vector<string> modules = {"VFS", "X11", "Termux-Shell"};\n    for(const auto& m : modules) {\n        cout << "Loaded module: " << m << endl;\n    }\n    return 0;\n}`,
            language: 'cpp',
            theme: 'vs-dark',
            automaticLayout: true,
            fontSize: 14,
            minimap: { enabled: false }
        });

        CyberVFS.init();
        print("Cyber OS Core v3.5 [C++ & X11 Engine] запущен успешно.", "info");
        print("Введите 'help' для просмотра доступных команд.", "system");
    });
});
