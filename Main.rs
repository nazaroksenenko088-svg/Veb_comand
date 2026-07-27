use wasm_bindgen::prelude::*;

#[wasm_bindgen]
pub fn rust_security_check(input: &str) -> String {
    if input == "sigma_access" {
        format!("[RUST_CORE] Доступ разрешен. Угрозы не обнаружены.")
    } else {
        format!("[RUST_CORE] Ошибка: Неверный ключ безопасности для '{}'.", input)
    }
}
