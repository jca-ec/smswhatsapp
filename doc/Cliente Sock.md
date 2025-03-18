# Cliente Sock para SMSWhatsApp

Ejemplo de como crear un cliente Sock para SMSWhatsApp mediante una conexión de Socket, esto permitirá recibir notificaciones en tiempo real sobre mensajes recibidos, multimedia y notificaciones de mensajes leídos.

## Funcionalidad del Servidor Sock

- El servidor Sock está disponible en la dirección `mywhatsapp.jca.ec` en el puerto `5026`.
- Los desarrolladores pueden conectarse mediante sus clientes de Socket en cualquier lenguaje de programación.
- Al conectarse, deben enviar su respectivo token para autenticarse.
- El servidor almacenará los últimos 50 eventos y los enviará tan pronto se conecten al servidor.

## Activación del Wenhook local en SMSWhatsApp para usar el Sock
- Se debe establecer mediante una petición POST con las credenciales correspondientes a la licencia deseada.
- Para registrar un webhook, los clientes deben ejecutar el siguiente endpoint con un `body` que contenga la URL del webhook local:

POST https://mywhatsapp.jca.ec:5433/auth/setWebhook?number={token}
### Body del Request
```json
{
  "webhookUrl": "http://mywhatsapp.jca.ec:5025/webhook"
}
```

### Datos recibidos

Al conectarse al servidor socket, recibirás notificaciones en tiempo real sobre mensajes de WhatsApp.
Los datos se envían en formato JSON y contienen información detallada sobre cada evento.
A continuación se describen los diferentes tipos de datos que puedes recibir:

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

##### Descripción de los Campos:

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

#### Mensajes de Multimedia
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

##### Descripción de los Campos:

* number: Token del usuario.
* content: Tipo de contenido, en este caso "media".
* mediaKey: Clave del medio, utilizada para identificar el contenido multimedia.
* mediaData: URL del archivo.
* mimeType: Tipo MIME del contenido multimedia, en este caso "audio/ogg; codecs=opus".
* fileName: Nombre del archivo.

#### Mensaje recibido/leído

```json
{
    "number": "TOKEN",
    "content": "ack",
    "messageId": "false_593123456789@c.us_598740991526F70A89D883A5EB29B5EB",
    "ack": 2
}
```

##### Descripción de los Campos:

* number: Token del usuario.
* content: Tipo de contenido, en este caso "ack".
* messageId: Identificador único del mensaje.
* ack: 1 - Mensaje envíado, 2 - Mensaje leído, 3 - Multimedia reproducido, en caso de ser un vídeo o audio.

### Ejemplos de Clientes

#### Cliente en Node.js
```javascript
const net = require('net');

const client = net.createConnection({
    host: 'mywhatsapp.jca.ec',
    port: 5026
}, () => {
    console.log('Connected to server');
    
    // Enviar token al servidor
    client.write('TOKEN');
});

client.on('data', (data) => {
    // Mostrar datos recibidos en pantalla
    console.log(data.toString());
});

client.on('end', () => {
    console.log('Disconnected from server');
});
```

#### Cliente en C#
```csharp
using System;
using System.Net.Sockets;
using System.Text;

class Program
{
    static void Main(string[] args)
    {
        string server = "mywhatsapp.jca.ec";
        int port = 5026;
        string token = "TOKEN";

        try
        {
            TcpClient client = new TcpClient(server, port);
            NetworkStream stream = client.GetStream();

            // Enviar token al servidor
            byte[] data = Encoding.ASCII.GetBytes(token);
            stream.Write(data, 0, data.Length);
            Console.WriteLine("Connected to server");

            // Leer datos del servidor
            byte[] buffer = new byte[1024];
            int bytesRead;
            while ((bytesRead = stream.Read(buffer, 0, buffer.Length)) != 0)
            {
                string responseData = Encoding.ASCII.GetString(buffer, 0, bytesRead);
                Console.WriteLine("Received: {0}", responseData);
            }

            // Cerrar conexión
            stream.Close();
            client.Close();
        }
        catch (Exception e)
        {
            Console.WriteLine("Exception: {0}", e);
        }
    }
}
```

#### Cliente en Python
```python
import socket

server = 'mywhatsapp.jca.ec'
port = 5026
token = 'TOKEN'

try:
    client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    client.connect((server, port))
    print('Connected to server')

    # Enviar token al servidor
    client.sendall(token.encode())

    while True:
        data = client.recv(1024)
        if not data:
            break
        print('Received:', data.decode())

    client.close()
except Exception as e:
    print(f'Exception: {e}')
```

#### Cliente en Visual FoxPro

Usar el formulario que ha sido agregado en la ruta: [Formulario WinSock](https://github.com/jca-ec/smswhatsapp/tree/main/WinSocket)

