# SMSWhatsApp: DLL y ApiRest

SMSWhatsApp es un servicio de mensajería a WhatsApp que puede ser usado mediante una DLL realizada en 32 bits ambiente Windows y ApiRest para todo tipo de lenguaje de programación y/o plataformas webs; ésto les permite a los desarrolladores conectar sus aplicaciones a WhatsApp para enviar mensajes con textos, audios, imágenes, vídeos, PDFs, administrar grupos, listas de difusión y entre otras funcionalidades.

## Características

- ### Enviar mensajes:
  - Puedes enviar gran cantidad de mensajes sencillos, adicional decorarlos con el uso de emojis.
  - Se permiten enviar todo tipo de adjuntos:
    - PDFs, imágenes, audios, videos, y mas tipos de archivos.
    - Envío de urls como adjuntos, el receptor recibirá anexo el adjunto contenido de la url de internet.
    - Se puede anexar una explicación textual a todos los archivos adjuntos.

- ### Recibir mensajes:
  - Recuperar mensajes de chats leidos y pendientes de lectura, muy útil para la elaboración de bots asistentes.
  - Reenviar mensajes recibidos.
  - Responder a mensajes recibidos.
  - Generar reacciones a mensajes recibidos.
  - Marcar chats como leidos.
  - Borrar chats y sus mensajes.
  - y mas opciones...

- ### Otras utilidades:
- Activar la DLL usando Licencia + Token DLL  o usando activación mediante ID del Servicio (Token apiRest).
- Administración de grupos de WhatsApp: Crear/adicionar/eliminar/promover participantes dentro de un grupo.
- Obtener lista de contactos de WhatsApp del número vinculado al servicio.
- Obtener lista de grupos y lista de sus respectivos participantes.
- Verificar si un contacto o destinatario es una cuenta válida en WhatsAppp.
- Verificar el estado de un mensaje enviado: Enviado / Recibido / Leido.
- Otras funcionalidades avanzadas.

## Enviando mensaje con Api Rest

## Ejemplo: Uso del endPoint para enviar un mensaje de texto

Para enviar un mensaje de texto a un número de teléfono específico (número en formato internacional), utilizar el siguiente endpoint y los parámetros correspondientes:

### Endpoint

`POST https://smswhatsapp.net:5433/chat/sendmessage/phone?number=myTokenApiRest`

#### Parámetros:

- **phone**  (obligatorio): Número de teléfono (en formato internacional) al que se enviará el mensaje.
- **number** (obligatorio): Token del servicio ApiRest o ID del servicio, para pruebas usa el token Phone03.

#### Body

- **message** (obligatorio): Contenido del mensaje de texto ha enviar.
- **quoted**: Código único de mensaje citado, es decir si estamos haciendo un reenvío de un mensaje recibido (opcional).
- **typing**: Envía simulación de escritura, el valor es numérico (opcional).
- **nowait**: No espera confirmación de mensaje envíado (opcional).

### Ejemplo

```bash
curl --location 'https://mywhatsapp.jca.ec:5433/chat/sendmessage/123456789?number=Phone03' \
--header 'Content-Type: application/json' \
--data '{
    "message": "Hola Mundo!",
    "typing": 1,
    "nowait": "true"
}'
```

Respuesta:
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

Recuerda reemplazar 123456789 con el número de teléfono (en formato internacional) al que deseas enviar el mensaje y personalizar el contenido del mensaje según tus necesidades.

***NOTA***: Mira un ejemplo más completo en: [https://github.com/jca-ec/smswhatsapp/blob/main/doc.md](https://github.com/jca-ec/smswhatsapp/tree/main/doc) 

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

Prueba un demo de envío de mensajes a WhatsApp usando [Demo](https://smswhatsapp.net/demo)

## Requisitos del Sistema

- DLL de 32 bits compatible con lenguajes de programación de 32bits como: VisualFoxPro, Visual Basic, etc..
- Acceso a Internet para la API REST, compatible con todos los lenguajes de programación, no necesitas instalar componentes, solo usar.

## Instalación para usar la DLL de SMSWhatsApp

1. Descarga la DLL desde [GitHub](https://github.com/jca-ec/smswhatsapp/blob/main/SMSWhatsApp.exe) el archivo SMSWhatsApp.exe.
2. Sigue las instrucciones de instalación.

## Problemas y Sugerencias

Si encuentras algún problema o tienes sugerencias, por favor crea un [issue](https://github.com/jca-ec/smswhatsapp/issues) en este repositorio.

## Contacto

Jairo Cedeño Adrián

Móvil.: +593 984 958 499

Correo: soporte@jca.ec

[https://mywhatsapp.jca.ec/](https://mywhatsapp.jca.ec/)

[wa.me/593984958499](https://wa.me/593984958499)

---

© 2024 Jairo Cedeño Adrián
