# 🔗 SMSWhatsApp Webhook Documentation

SMSWhatsApp permite que tus aplicaciones reciban notificaciones en tiempo real (Push) cada vez que ocurre un evento en tu cuenta de WhatsApp (mensajes recibidos, entrega de mensajes, llamadas entrantes, etc.).

---

## 🛠️ Registro de Webhooks

Para comenzar a recibir notificaciones, debes configurar la URL de tu servidor mediante el endpoint `setWebhook`.

**POST** `https://mywhatsapp.jca.ec:5433/auth/setWebhook?number=TOKEN_SMSWHATSAPP`

### Body (JSON)
```json
{
  "webhookUrl": "https://tu-servidor.com/webhook"
}
```

### Ejemplo con cURL
```bash
curl -X POST "https://mywhatsapp.jca.ec:5433/auth/setWebhook?number=TOKEN_SMSWHATSAPP" \
     -H "Content-Type: application/json" \
     -d '{"webhookUrl": "https://tu-api.com/v1/whatsapp-webhook"}'
```

---

## 📋 Lista de Eventos y Payloads

Todas las peticiones enviadas a tu webhook son de tipo **POST** con formato **JSON**.

### 1. Mensajes Recibidos (`content: "message"`)
Se dispara cuando recibes un mensaje nuevo o envías uno desde el dispositivo.

```json
{
  "number": "TOKEN_SMSWHATSAPP",
  "content": "message",
  "messageId": "false_593999999999@c.us_705C8AA536FF8F65CD",
  "from": "593912345678@c.us",
  "to": "593984958499@c.us",
  "fromMe": false,
  "body": "Hola, ¿cómo estás?",
  "type": "chat",
  "timestamp": 1719598097,
  "quotedMessage": null,
  "hasMedia": false,
  "hasQuoteMsg": false
}
```

### 2. Multimedia (`content: "media"`)
Se envía inmediatamente después de un evento `message` si el mensaje contiene archivos (imagen, audio, video, etc.).

```json
{
  "number": "TOKEN_SMSWHATSAPP",
  "content": "media",
  "mediaKey": "XZ7ICZsETL7H/PARAq/+4ETotAbW4wEXeAT7+cDZ4M4=",
  "mediaData": "BASE64_STRING_DEL_ARCHIVO_COMPLETO",
  "mimeType": "image/jpeg",
  "fileName": "foto.jpg"
}
```

### 3. Estados de Entrega (`content: "ack"`)
Informa si el mensaje fue enviado (1), recibido en el dispositivo (2) o leído/reproducido (3).

```json
{
  "number": "TOKEN_SMSWHATSAPP",
  "content": "ack",
  "messageId": "true_593999999999@c.us_598740991526F70A89D883A5EB29B5EB",
  "ack": 2
}
```

### 4. Llamadas Entrantes (`content: "call"`)
Recibe una notificación cuando alguien intenta llamar o hacer una videollamada.

```json
{
  "number": "TOKEN_SMSWHATSAPP",
  "content": "call",
  "id": "123456789",
  "from": "593912345678@c.us",
  "fromMe": false,
  "isGroup": false,
  "isVideo": false,
  "participants": [],
  "timestamp": 1719598100
}
```

### 5. Desconexión (`content: "disconnected"`)
Notifica si la sesión de WhatsApp se cierra manualmente o por errores críticos.

```json
{
  "number": "TOKEN_SMSWHATSAPP",
  "content": "disconnected",
  "reason": "LOGOUT",
  "other": "..."
}
```

---

## 💻 Ejemplos de Implementación

### Node.js (Express)
```javascript
const express = require('express');
const app = express();

app.use(express.json({ limit: '100mb' }));

app.post('/webhook', (req, res) => {
    const { number, content, ...data } = req.body;
    console.log(`Evento [${content}] recibido para token: ${number}`);

    switch (content) {
        case 'message':
            console.log('Mensaje:', data.body);
            break;
        case 'media':
            console.log('Archivo recibido:', data.fileName);
            // El buffer del archivo está en data.mediaData (base64)
            break;
        case 'call':
            console.log('Llamada de:', data.from);
            break;
        case 'disconnected':
            console.warn('Sesión desconectada:', data.reason);
            break;
    }

    res.status(200).send('OK');
});

app.listen(3000, () => console.log('Servidor webhook en puerto 3000'));
```

### Python (Flask)
```python
from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route('/webhook', methods=['POST'])
def webhook():
    payload = request.get_json()
    token = payload.get('number')
    event_type = payload.get('content')
    
    print(f"Evento {event_type} recibido para {token}")

    if event_type == 'message':
        print(f"Mensaje de {payload.get('from')}: {payload.get('body')}")
    elif event_type == 'media':
        mime = payload.get('mimeType')
        print(f"Archivo recibido tipo: {mime}")
    elif event_type == 'call':
        print(f"Llamada entrante de: {payload.get('from')}")
    elif event_type == 'disconnected':
        print(f"ALERTA: Sesion {token} desconectada")

    return jsonify({"status": "received"}), 200

if __name__ == '__main__':
    app.run(port=5000)
```

---

## 🛡️ Detalles Técnicos y Retries

1.  **Buffer de Seguridad**: Si tu servidor de webhook está caído, SMSWhatsApp guarda las notificaciones en un buffer local e intenta reenviarlas automáticamente cuando tu servidor vuelva a estar online.
2.  **Tiempo de Respuesta**: Tu webhook debe responder con un `HTTP 200 OK` en menos de 5 segundos.
3.  **Lid Resolution**: Los números de teléfono siempre se envían en formato internacional (`5939...`) incluso si WhatsApp usa IDs internos (@lid).
4.  **Base64**: Las imágenes y audios se envían en el campo `mediaData` como cadenas Base64 completas.

