# SMSWhatsApp Webhook Documentation

SMSWhatsApp es un servicio que permite a los programadores enviar mensajes mediante WhatsApp.
Esta documentación explica cómo tus aplicaciones pueden recibir notificaciones en tiempo real utilizando webhooks.

## Registro de Webhooks

Para registrar un webhook, los clientes deben ejecutar el siguiente endpoint con un `body` que contenga la URL del webhook:

POST https://mywhatsapp.jca.ec:5433/auth/setWebhook?number={token}

### Body del Request

```json
{
  "webhookUrl": "url"
}
```

## Definir el Webhook con curl
```bash
curl -X POST https://mywhatsapp.jca.ec:5433/auth/setWebhook?number=your_token_here \
     -H "Content-Type: application/json" \
     -d '{
           "webhookUrl": "https://your-webhook-url.com/webhook"
         }'
```
## Implementación de un Webhook en Node.js
Aquí hay un ejemplo de cómo puedes implementar un webhook en un servidor Node.js para recibir notificaciones de mensajes en tiempo real.

Código de Ejemplo
```javascript
const express = require('express');
const bodyParser = require('body-parser');

const app = express();
const PORT_WEB = process.env.PORT || 3000; // Puerto para el servidor web

// Aumentar el límite de tamaño del cuerpo de la solicitud
app.use(bodyParser.json({ limit: '100mb' }));
app.use(bodyParser.urlencoded({ limit: '100mb', extended: true }));

// Endpoint para el webhook
app.post('/webhook', async (req, res) => {
    let { content, ...data } = req.body;

    switch (content) {
        case 'message':
            // Procesar mensaje
            console.log('Mensaje recibido:', data);
            break;
        case 'ack':
            // Procesar ACK
            console.log('ACK recibido:', data);
            break;
        case 'media':
            // Procesar media
            console.log('Media recibida:', data);
            break;
        default:
            console.log('Tipo de contenido desconocido:', content);
    }

    // Responder con éxito
    res.status(200).send('Datos recibidos con éxito');
});

// Iniciar el servidor web
app.listen(PORT_WEB, () => {
    console.log(`Servidor web escuchando en el puerto ${PORT_WEB}`);
});
```
## Implementación de un Webhook en Python
```python
from flask import Flask, request, jsonify

app = Flask(__name__)
PORT_WEB = 5025  # Puerto para el servidor web

# Endpoint para el webhook
@app.route('/webhook', methods=['POST'])
def webhook():
    data = request.get_json()
    content = data.pop('content', None)

    if content == 'message':
        # Procesar mensaje
        print('Mensaje recibido:', data)
    elif content == 'ack':
        # Procesar ACK
        print('ACK recibido:', data)
    elif content == 'media':
        # Procesar media
        try:
            data = save_media_data(data)
        except Exception as error:
            print("Error al guardar media", error)
        print('Media recibida:', data)
    else:
        print('Tipo de contenido desconocido:', content)

    try:
        save_buffer({
            'content': content,
            **data
        })
    except Exception as error:
        print("Error al guardar datos en archivo", error)

    # Responder con éxito
    return jsonify({'message': 'Datos recibidos con éxito'}), 200

def save_media_data(data):
    # Implementar lógica para guardar datos multimedia
    pass

def save_buffer(data):
    # Implementar lógica para guardar datos en archivo
    pass

# Iniciar el servidor web
if __name__ == '__main__':
    app.run(port=PORT_WEB)
```
### Datos Recibidos
A continuación se describen los diferentes tipos de datos que puedes recibir a través del webhook.

#### Mensajes de Texto
```json
{
    "number": "TOKEN",
    "content": "message",
    "messageId": "false_593123456789@c.us_705C8AA536FF8F65CD",
    "from": "593123456789@c.us",
    "to": "593123456789@c.us",
    "fromMe": false,
    "body": "Mensaje de texto",
    "type": "chat",
    "timestamp": 1719598097,
    "quotedMessage": null,
    "hasMedia": false,
    "hasQuoteMsg": false
}
```

#### Descripción de los Campos:

* number: Token del usuario.
* content: Tipo de contenido, en este caso "message".
* messageId: Identificador único del mensaje.
* from: Número de teléfono del remitente.
* to: Número de teléfono del destinatario.
* fromMe: Indica si el mensaje fue enviado por el usuario (true) o recibido (false).
* body: Cuerpo del mensaje de texto.
* type: Tipo de mensaje, en este caso "chat", si es un mensaje de voz será "ptt".
* timestamp: Marca de tiempo del mensaje.
* quotedMessage: Mensaje citado, si aplica.
* hasMedia: Indica si el mensaje tiene contenido multimedia (true o false).
* hasQuoteMsg: Indica si el mensaje tiene una cita (true o false).
* Mensajes de Multimedia

```json
{
    "number": "TOKEN",
    "content": "media",
    "mediaKey": "XZ7ICZsETL7H/PARAq/+4ETotAbW4wEXeAT7+cDZ4M4=",
    "mediaData": "https://mywhatsapp.jca.ec/assets/buffer/archivo.ogg",
    "mimeType": "audio/ogg; codecs=opus",
    "fileName": "audio.ogg"
}
```
#### Descripción de los Campos:

* number: Token del usuario.
* content: Tipo de contenido, en este caso "media".
* mediaKey: Clave del medio, utilizada para identificar el contenido multimedia.
* mediaData: URL del archivo.
* mimeType: Tipo MIME del contenido multimedia, en este caso "audio/ogg; codecs=opus".
* fileName: Nombre del archivo.

#### Mensaje Recibido/Leído
```json
{
    "number": "TOKEN",
    "content": "ack",
    "messageId": "false_593123456789@c.us_598740991526F70A89D883A5EB29B5EB",
    "ack": 2
}
```
#### Descripción de los Campos:

* number: Token del usuario.
* content: Tipo de contenido, en este caso "ack".
* messageId: Identificador único del mensaje.
ack:
1: Mensaje enviado.
2: Mensaje leído.
3: Multimedia reproducido (en caso de ser un vídeo o audio).
