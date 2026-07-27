const SystemFeatures = {
    modules: ['WASM_Bridge', 'Terminal_UI', 'V86_Emulator', 'Rust_Security'],
    
    listModules() {
        console.log("[FEATURES] Активные модули системы:");
        this.modules.forEach(m => console.log(` - ${m}`));
    },

    getModuleCount() {
        return this.modules.length;
    }
};

window.SystemFeatures = SystemFeatures;
