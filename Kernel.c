#include <emscripten/emscripten.h>

EMSCRIPTEN_KEEPALIVE
int kernel_status_code() {
    // Возвращаем статус успешной инициализации ядра
    return 0x5349474d; // 'SIGM' в HEX
}

EMSCRIPTEN_KEEPALIVE
const char* get_kernel_version() {
    return "Polygon-Kernel v1.0.4-wasm";
}
