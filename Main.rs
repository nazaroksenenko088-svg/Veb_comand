use tokio::net::TcpListener;
use tokio_tungstenite::accept_async;
use futures_util::{StreamExt, SinkExt};

#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    let addr = "127.0.0.1:8080";
    let listener = TcpListener::bind(&addr).await?;
    println!("[Rust Core] WebSocket dispatcher active on: {}", addr);

    while let Ok((stream, _)) = listener.accept().await {
        tokio::spawn(async move {
            let ws_stream = accept_async(stream).await.expect("Failed to accept");
            let (mut write, mut read) = ws_stream.split();

            while let Some(msg) = read.next().await {
                if let Ok(msg) = msg {
                    if msg.is_text() || msg.is_binary() {
                        println!("[Dispatcher] Received command: {}", msg);
                        // Здесь в будущем пушим команду дальше в игру/клиент
                        let response = format!("ACK: {}", msg);
                        let _ = write.send(tokio_tungstenite::tungstenite::Message::Text(response)).await;
                    }
                }
            }
        });
    }

    Ok(())
          }
