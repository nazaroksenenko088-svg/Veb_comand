// Настройка загрузчика Monaco
require.config({ paths: { 'vs': 'https://cdnjs.cloudflare.com/ajax/libs/monaco-editor/0.38.0/min/vs' }});

require(['vs/editor/editor.main'], function() {
    // 1. Инициализация редактора
    window.editor = monaco.editor.create(document.getElementById('editor-container'), {
        value: '#include <iostream>\n\nint main() {\n    std::cout << "Hello, Cloud IDE V2!" << std::endl;\n    return 0;\n}',
        language: 'cpp',
        theme: 'vs-dark',
        automaticLayout: true, // Важно для планшетов при повороте экрана
        fontSize: 16
    });

    // 2. Логика кастомной консоли разработчика
    const consoleOutput = document.getElementById('console-output');
    const devConsole = document.getElementById('dev-console');
    const toggleBtn = document.getElementById('toggle-console-btn');
    const closeBtn = document.getElementById('close-console-btn');

    // Функция для добавления строк в нашу панель
    function printToConsole(message, type = 'log') {
        const msgElement = document.createElement('div');
        msgElement.className = `console-msg ${type}`;
        // Преобразуем объекты в строку, чтобы они нормально читались
        msgElement.textContent = typeof message === 'object' ? JSON.stringify(message, null, 2) : message;
        consoleOutput.appendChild(msgElement);
        // Автоматическая прокрутка вниз
        consoleOutput.scrollTop = consoleOutput.scrollHeight;
    }

    // Перехватываем стандартный console.log
    const originalLog = console.log;
    console.log = function(...args) {
        printToConsole(args.join(' '));
        originalLog.apply(console, args);
    };

    // Перехватываем ошибки (очень поможет при разработке на планшете)
    const originalError = console.error;
    console.error = function(...args) {
        printToConsole(args.join(' '), 'error');
        originalError.apply(console, args);
    };

    // Перехватываем глобальные ошибки окна
    window.onerror = function(message, source, lineno, colno, error) {
        printToConsole(`${message} (Строка: ${lineno})`, 'error');
    };

    // 3. Управление видимостью консоли (тач-интерфейс)
    toggleBtn.addEventListener('click', () => {
        devConsole.classList.toggle('hidden');
    });

    closeBtn.addEventListener('click', () => {
        devConsole.classList.add('hidden');
    });

    // Тестовый лог при запуске
    console.log("Система инициализирована. Monaco Editor запущен.");
});
