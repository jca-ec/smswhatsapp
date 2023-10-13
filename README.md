# SMSWhatsApp API

SMSWhatsApp API es una DLL de 32 bits y un servicio API REST que permite a los desarrolladores conectar sus aplicaciones a WhatsApp para enviar mensajes de texto, audio, imágenes, vídeos, PDF y administrar grupos, entre otras funcionalidades.

## Características

- Envío de mensajes de texto.
- Envío de mensajes de audio.
- Envío de imágenes y vídeos.
- Envío de archivos PDF.
- Administración de grupos de WhatsApp.
- Otras funcionalidades avanzadas.

## Enviando mensaje con Api Rest

markdown
Copy code
## Uso de la API para enviar un mensaje de texto

Para enviar un mensaje de texto a un número de teléfono específico, utiliza el siguiente endpoint y los parámetros correspondientes:

### Endpoint

`POST https://mywhatsapp.jca.ec:5433/chat/sendmessage/:phone?number=token`

### Parámetros

- **phone** (obligatorio): Número de teléfono al que se enviará el mensaje.
- **number** (obligatorio): Token de tu licencia de SMSWhatsApp, para pruebas usa el token Phone03.

### Body

- **message** (obligatorio): Mensaje de texto que se enviará.
- **quoted**: Código único de mensaje citado (opcional).
- **typing**: Envía simulación de escritura (opcional).
- **nowait**: No espera confirmación de mensaje envíado (opcional).

### Ejemplo

```bash
curl --location 'https://mywhatsapp.jca.ec:5433/chat/sendmessage/123456789?number=Phone03' \
--header 'Content-Type: application/json' \
--data '{
    "message": "Hola Mundo!",   
    "typing": "true"
}'
```

Respuesta
La API responderá según el éxito o fracaso de la operación.

Código de respuesta 200 si el mensaje se envió exitosamente.
Código de respuesta 400 si faltan parámetros obligatorios o hay un error en la solicitud.

```json
{
  "success": true,
  "message": "Mensaje enviado con éxito",
  "id": "Código único del mensaje envíado"
}
```

Recuerda reemplazar 123456789 con el número de teléfono al que deseas enviar el mensaje y personalizar el contenido del mensaje según tus necesidades.

***NOTA***: Mira un ejemplo más completo en: https://github.com/jca-ec/smswhatsapp/blob/main/doc.md 

## Ejemplos en varios lenguajes

Echa un vistazo a cada carpeta de este proyecto para ver ejemplos de código en varios lenguajes de programación que muestran cómo utilizar la API.

- [C#](https://github.com/jca-ec/smswhatsapp/blob/main/NetCore/Program.cs)
- [PHP](https://github.com/jca-ec/smswhatsapp/tree/main/PHP)
- [Python](https://github.com/jca-ec/smswhatsapp/tree/main/Python)
- [SQL Server](https://github.com/jca-ec/smswhatsapp/tree/main/SQLServer)
- [Visual Basic 6](https://github.com/jca-ec/smswhatsapp/tree/main/VB6.0)
- [Visual Fox Pro](https://github.com/jca-ec/smswhatsapp/tree/main/Visual%20FoxPro)
- [WinDev](https://github.com/jca-ec/smswhatsapp/tree/main/WinDev) 

## Demo en línea

Prueba un demo de envío de mensajes a WhatsApp usando [https://mywhatsapp.jca.ec/demo](https://mywhatsapp.jca.ec/demo)

## Requisitos del Sistema

- DLL de 32 bits compatible con lenguajes de programación de 32bits como: VisualFoxPro, Visual Basic, etc..
- Acceso a Internet para la API REST, compatible con todos los lenguajes de programación.

## Instalación

1. Descarga la DLL desde [Mega](https://mega.nz/folder/wYRnUYKJ#y0eV2vy-Bp1bx361Wm18IA/file/1MwSGaLB) el archivo SMSWhatsApp.exe.
2. Sigue las instrucciones de instalación.

## Problemas y Sugerencias

Si encuentras algún problema o tienes sugerencias, por favor crea un [issue](https://github.com/jca-ec/smswhatsapp/issues) en este repositorio.

## Contacto

Jairo Cedeño

Telef.: +593 98 495 8499

Correo: soporte@jca.ec

[https://mywhatsapp.jca.ec/](https://mywhatsapp.jca.ec/)

[wa.me/593984958499](https://wa.me/593984958499)

---

© 2023 Jairo Cedeño
