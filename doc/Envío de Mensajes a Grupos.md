# Manual de Referencia - API de Envío de Mensajes a Grupos

## Sistema SMSWhatsApp - Pool de WhatsApp

Este manual documenta las funcionalidades de envío de mensajes a grupos disponibles en el sistema SMSWhatsApp Pool.

## 📋 Tabla de Contenidos

1. [Introducción](#introducción)
2. [Estructura de la API](#estructura-de-la-api)
3. [Control Anti-Ban](#control-anti-ban)
4. [Sistema de Contadores](#sistema-de-contadores)
5. [Endpoints de Envío de Mensajes](#endpoints-de-envío-de-mensajes)
6. [Códigos de Estado](#códigos-de-estado)
7. [Ejemplos de Uso](#ejemplos-de-uso)

---

## 🎯 Introducción

La API de grupos permite enviar diferentes tipos de contenido a grupos de WhatsApp:

- **Mensajes de texto** (con opción TTS)
- **Archivos multimedia** (imágenes, videos, documentos, etc.)
- **Ubicaciones geográficas**

El sistema incluye medidas de protección anti-ban y seguimiento de entregas de mensajes.

---

## 🏗️ Estructura de la API

### URL Base
```
http://mywhatsapp.jca.ec:5433/chat/group/...?number=TOKEN_SMSWHATSAPP
```


### Parámetros Comunes
- `number`: **Token de SmsWhatsApp** del cliente (parámetro query)
- `controlBan`: Booleano para activar control anti-ban (opcional, default: false)

---

## 🛡️ Control Anti-Ban

### ¿Qué es el Control Anti-Ban?

Es un mecanismo que verifica el estado de entrega de mensajes previos antes de enviar nuevos mensajes, previniendo bloqueos de WhatsApp.

### Funcionamiento

1. **SendSeen**: Marca el chat como visto
2. **Typing Simulation**: Simula escritura por 3.2 segundos
3. **Verificación de Mensajes**: Descarga últimos 20 mensajes y verifica ACK
4. **Detección de Bloqueo**: Si hay mensajes sin entregar, detiene el envío

### Parámetros del Control
- `controlBan`: `true` para activar, `false` para desactivar
- Tiempo de espera: 10 segundos si detecta mensajes sin entregar

### Respuesta cuando se previene ban
```json
{
  "status": "ERROR",
  "message": "No se envía para prevenir ban. Hay X mensajes sin recibir en este chat por posible bloqueo.",
  "undeliveredCount": 3,
  "preventedBan": true
}
```

---

## 📊 Sistema de Contadores

### Contadores por Chat
- **undeliveredInThisChat**: Mensajes sin entregar en el chat actual
- **totalUndelivered**: Total de mensajes sin entregar en todos los chats

### Funcionamiento
- Se incrementa antes de enviar cada mensaje
- Se decrementa cuando se recibe confirmación de entrega (ACK > 1)
- Útil para monitoreo y control de calidad de envío

---

## 📤 Endpoints de Envío de Mensajes

### 1. Enviar Mensaje de Texto por ID de Grupo

**Endpoint:** `POST /sendMessageById/:chatid`

**Parámetros URL:**
- `chatid`: ID del grupo (ej: `120363XXXXXX@g.us`)

**Parámetros Query:**
- `number`: **Token de SmsWhatsApp** del cliente

**Body (JSON):**
```json
{
  "message": "Texto del mensaje",
  "tts": false,
  "controlBan": true
}
```

**Respuesta Éxito:**
```json
{
  "status": "SUCCESS",
  "message": "Message sent successfully",
  "id": "3EB0XXXXXXX@c.us_3EB0XXXXXXX",
  "undeliveredInThisChat": 2,
  "totalUndelivered": 15
}
```

---

### 2. Enviar Multimedia por ID de Grupo

**Endpoint:** `POST /SendMediaById/:chatid`

**Parámetros URL:**
- `chatid`: ID del grupo

**Parámetros Query:**
- `number`: **Token de SmsWhatsApp** del cliente

**Body (JSON):**
```json
{
  "media": "base64_string_o_url",
  "type": "image",
  "caption": "Texto opcional",
  "title": "Nombre del archivo",
  "message": "Mensaje adicional",
  "controlBan": true
}
```

**Tipos de Media Soportados:**
- `image`: Imágenes (jpg, png, gif, webp)
- `video`: Videos (mp4, avi, etc.)
- `document`: Documentos (pdf, doc, xls, etc.)
- `audio`: Archivos de audio

---

### 3. Enviar Mensaje de Texto por Nombre de Grupo

**Endpoint:** `POST /sendmessage/:chatname`

**Parámetros URL:**
- `chatname`: Nombre exacto del grupo

**Parámetros Query:**
- `number`: **Token de SmsWhatsApp** del cliente

**Body (JSON):**
```json
{
  "message": "Texto del mensaje",
  "tts": true,
  "controlBan": false
}
```

---

### 4. Enviar Multimedia por Nombre de Grupo

**Endpoint:** `POST /sendmedia/:chatname`

**Parámetros URL:**
- `chatname`: Nombre exacto del grupo

**Parámetros Query:**
- `number`: **Token de SmsWhatsApp** del cliente

**Body (JSON):**
```json
{
  "media": "base64_string_o_url",
  "type": "video",
  "caption": "Descripción del video",
  "title": "video.mp4",
  "controlBan": true
}
```

---

### 5. Enviar Ubicación por Nombre de Grupo

**Endpoint:** `POST /sendlocation/:chatname`

**Parámetros URL:**
- `chatname`: Nombre exacto del grupo

**Parámetros Query:**
- `number`: **Token de SmsWhatsApp** del cliente

**Body (JSON):**
```json
{
  "latitude": -0.180653,
  "longitude": -78.467834,
  "description": "Quito, Ecuador",
  "address": "Centro Histórico",
  "url": "https://maps.google.com/?q=-0.180653,-78.467834",
  "controlBan": true
}
```

---

### 6. Enviar Ubicación por ID de Grupo

**Endpoint:** `POST /sendlocationById/:chatid`

**Parámetros URL:**
- `chatid`: ID del grupo

**Parámetros Query:**
- `number`: **Token de SmsWhatsApp** del cliente

**Body (JSON):**
```json
{
  "latitude": -0.180653,
  "longitude": -78.467834,
  "description": "Ubicación específica",
  "controlBan": false
}
```

---

## 📋 Códigos de Estado

### Estados de Éxito
- `"SUCCESS"`: Operación completada correctamente
- `"success"`: Operación completada (formato alternativo)

### Estados de Error
- `"ERROR"`: Error general en la operación
- `"error"`: Error específico (formato alternativo)

### Mensajes de Error Comunes
- `"Client no found"`: Sesión de WhatsApp no inicializada
- `"No se pudo crear grupo"`: Error al crear grupo
- `"Grupo no existe"`: El grupo especificado no fue encontrado
- `"No se envía para prevenir ban..."`: Control anti-ban activado

---

## 💡 Ejemplos de Uso

### Ejemplo 1: Enviar mensaje de texto básico

```bash
curl -X POST "https://mywhatsapp.jca.ec:5433/group/sendMessageById/120363XXXXXX@g.us?number=TOKEN_SMSWHATSAPP" \
  -H "Content-Type: application/json" \
  -d '{
    "message": "Hola a todos en el grupo!",
    "controlBan": true
  }'
```

### Ejemplo 2: Enviar imagen con control anti-ban

```bash
curl -X POST "https://mywhatsapp.jca.ec:5433/group/SendMediaById/120363XXXXXX@g.us?number=TOKEN_SMSWHATSAPP" \
  -H "Content-Type: application/json" \
  -d '{
    "media": "data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQ...",
    "type": "image",
    "caption": "Imagen de ejemplo",
    "controlBan": true
  }'
```

### Ejemplo 3: Enviar ubicación

```bash
curl -X POST "https://mywhatsapp.jca.ec:5433/group/sendlocationById/120363XXXXXX@g.us?number=TOKEN_SMSWHATSAPP" \
  -H "Content-Type: application/json" \
  -d '{
    "latitude": -0.180653,
    "longitude": -78.467834,
    "description": "Oficina Central",
    "controlBan": true
  }'
```

### Ejemplo 4: Enviar mensaje por nombre de grupo

```bash
curl -X POST "https://mywhatsapp.jca.ec:5433/group/sendmessage/Grupo%20de%20Trabajo?number=TOKEN_SMSWHATSAPP" \
  -H "Content-Type: application/json" \
  -d '{
    "message": "Reunión mañana a las 10:00 AM",
    "tts": false,
    "controlBan": false
  }'
```
