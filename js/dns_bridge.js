// js/dns_bridge.js

class SecureDNS {
    constructor() {
        // Тот самый защищенный сервер, который ты просил
        this.endpoint = "https://security.cloudflare-dns.com/dns-query";
    }

    // Функция для безопасного резолва доменов
    async resolve(domain) {
        try {
            const response = await fetch(`${this.endpoint}?name=${domain}&type=A`, {
                headers: {
                    "Accept": "application/dns-json"
                }
            });
            
            const data = await response.json();
            
            if (data.Status === 0 && data.Answer) {
                const ip = data.Answer[0].data;
                console.log(`[DNS Shield] Успешно: ${domain} -> ${ip}`);
                return ip;
            } else {
                console.warn(`[DNS Shield] Не удалось найти IP для ${domain}`);
                return null;
            }
        } catch (error) {
            console.error("[DNS Shield] Ошибка соединения с DNS:", error);
            return null;
        }
    }
}

// Инициализируем наш щит
const dnsShield = new SecureDNS();

// Тестовый запрос, чтобы проверить работу в консоли браузера
// dnsShield.resolve("github.com").then(ip => console.log(ip));
