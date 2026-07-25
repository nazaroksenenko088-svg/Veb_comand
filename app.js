let editor;

require.config({ paths: { 'vs': 'https://cdnjs.cloudflare.com/ajax/libs/monaco-editor/0.34.1/min' }});

require(['vs/editor/editor.main'], function() {
    editor = monaco.editor.create(document.getElementById('editor'), {
        value: `#include <iostream>\nusing namespace std;\n\nint main() {\n    cout << "Cyber OS Debian Kernel Initialized!" << endl;\n    return 0;\n}`,
        language: 'cpp',
        theme: 'vs-dark',
        automaticLayout: true,
        fontSize: 14,
        minimap: { enabled: false }
    });

    // Инициализируем VFS и выводим приветствие
    CyberVFS.init();
    print("Cyber OS Core v3.0 [Debian/Termux-X11 Simulation Engine] успешно запущен.", "info");
    print("Введите 'help' для просмотра доступных команд терминала.", "system");
});
