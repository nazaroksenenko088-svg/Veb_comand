// Мост для работы с Cloudflare DNS over HTTPS (DoH)
const dnsShield = {
    endpoint: 'https://security.cloudflare-dns.com/dns-query',
    
    async resolve(domain) {
        try {
            console.log(`[DNS Shield] Запрашиваю маршрут для: ${domain}`);
            const response = await fetch(`${this.endpoint}?name=${domain}&type=A`, {
                headers: { 'Accept': 'application/dns-json' }
            });
            
            if (!response.ok) throw new Error('Ошибка сети при запросе к DNS');
            
            const data = await response.json();
            if (data.Answer && data.Answer.length > 0) {
                const ip = data.Answer[0].data;
                console.log(`[DNS Shield] Успешно. IP: ${ip}`);
                return ip;
            } else {
                console.warn(`[DNS Shield] Маршрут не найден для ${domain}`);
                return null;
            }
        } catch (error) {
            console.error(`[DNS Shield] Ошибка резолва: ${error.message}`);
            return null;
        }
    }
};
