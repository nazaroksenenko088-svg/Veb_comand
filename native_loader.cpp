#include <iostream>
#include <emscripten/emscripten.h>

extern "C" {
    EMSCRIPTEN_KEEPALIVE
    void init_native_loader() {
        std::cout << "[NATIVE_LOADER] C++ мост успешно активирован в памяти браузера." << std::endl;
    }

    EMSCRIPTEN_KEEPALIVE
    int calculate_checksum(int a, int b) {
        return (a ^ b) + 0x2A;
    }
}
