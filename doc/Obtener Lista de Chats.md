# Manual de Referencia - API de Obtener Lista de Chats

## Sistema SMSWhatsApp - Pool de WhatsApp

Este manual documenta las funcionalidades disponibles para obtener la lista de chats desde el sistema SMSWhatsApp Pool.

## 📋 Tabla de Contenidos

1. [Introducción](#introducción)
2. [Estructura de la API](#estructura-de-la-api)
3. [Endpoints Principales](#endpoints-principales)
4. [Parámetros de Consulta](#parámetros-de-consulta)
5. [Formatos de Respuesta](#formatos-de-respuesta)
6. [Ejemplos de Uso](#ejemplos-de-uso)

---

## 🎯 Introducción

La API de chats permite obtener información sobre todas las conversaciones disponibles en una sesión de WhatsApp, incluyendo:

- **Chats individuales** (con contactos)
- **Grupos de WhatsApp**
- **Chats archivados y silenciados**
- **Información de estado** (mensajes no leídos, etc.)

El sistema incluye funcionalidades avanzadas como resolución de identificadores `@lid` y filtrado inteligente.

---

## 🏗️ Estructura de la API

### URL Base
```
http://mywhatsapp.jca.ec:5433/chat/chatting/...?number=TOKEN_SMSWHATSAPP
```

### Cliente Requerido
Todos los endpoints requieren que la sesión de WhatsApp esté inicializada y autenticada.

---

## 📤 Endpoints Principales

### 1. Obtener Todos los Chats

**Endpoint:** `GET /getchats`

**Descripción:** Obtiene la lista completa de chats disponibles en la sesión.

**Parámetros de Consulta:**
- `number`: **Requerido** - **Token de SmsWhatsApp** del cliente
- `onlyunread`: **Opcional** - Si `true`, filtra solo chats con mensajes no leídos
- `limit`: **Opcional** - Número máximo de chats a devolver (default: 1000)
- `includePushname`: **Opcional** - Si `true`, incluye nombres de push para chats individuales
- `lite`: **Opcional** - Si `true`, devuelve versión simplificada de los datos

**Respuesta Éxito:**
```json
{
  "status": "success",
  "message": [
    {
      "id": {
        "_serialized": "593999999999@c.us"
      },
      "name": "Juan Pérez",
      "isGroup": false,
      "isReadOnly": false,
      "archived": false,
      "isMuted": false,
      "pinned": false,
      "timestamp": 1703123456,
      "unreadCount": 3,
      "lastMessage": {
        "id": {
          "fromMe": false,
          "_serialized": "false_593999999999@c.us_ABC123"
        },
        "body": "Hola, ¿cómo estás?",
        "timestamp": 1703123456,
        "from": "593999999999@c.us"
      }
    }
  ]
}
```

---

### 2. Obtener Chat Específico por ID

**Endpoint:** `GET /getchatbyid/:chatid`

**Descripción:** Obtiene información detallada de un chat específico.

**Parámetros URL:**
- `chatid`: ID del chat (ej: `593999999999@c.us` o `120363XXXXXX@g.us`)

**Parámetros de Consulta:**
- `number`: **Requerido** - **Token de SmsWhatsApp** del cliente

**Respuesta Éxito:**
```json
{
  "status": "success",
  "message": {
    "id": {
      "_serialized": "593999999999@c.us"
    },
    "name": "Juan Pérez",
    "isGroup": false,
    "isReadOnly": false,
    "archived": false,
    "isMuted": false,
    "pinned": false,
    "timestamp": 1703123456,
    "unreadCount": 3
  }
}
```

---

### 3. Contadores de Mensajes Sin Entregar

#### Obtener Contador por Chat
**Endpoint:** `GET /undelivered-count/:chatid`

**Parámetros URL:**
- `chatid`: ID del chat

**Parámetros de Consulta:**
- `number`: **Requerido** - **Token de SmsWhatsApp** del cliente

**Respuesta:**
```json
{
  "status": "success",
  "message": {
    "chatId": "593999999999@c.us",
    "undeliveredCount": 5
  }
}
```

#### Obtener Todos los Contadores
**Endpoint:** `GET /undelivered-count-all`

**Parámetros de Consulta:**
- `number`: **Requerido** - **Token de SmsWhatsApp** del cliente

**Respuesta:**
```json
{
  "status": "success",
  "message": {
    "number": "593999999999",
    "undeliveredMessagesByChat": {
      "593999999999@c.us": 3,
      "120363XXXXXX@g.us": 7
    },
    "totalUndelivered": 10,
    "chatsWithUndeliveredMessages": 2
  }
}
```

#### Reiniciar Contador por Chat
**Endpoint:** `POST /reset-undelivered-count/:chatid`

**Parámetros URL:**
- `chatid`: ID del chat

**Parámetros de Consulta:**
- `number`: **Requerido** - **Token de SmsWhatsApp** del cliente

**Respuesta:**
```json
{
  "status": "success",
  "message": "Contador reiniciado para chat 593999999999@c.us"
}
```

---

## 🔧 Parámetros de Consulta

### Parámetros del Endpoint `/getchats`

| Parámetro | Tipo | Default | Descripción |
|-----------|------|---------|-------------|
| `number` | string | - | **Requerido**. **Token de SmsWhatsApp** del cliente |
| `onlyunread` | boolean | false | Filtrar solo chats con mensajes no leídos |
| `limit` | number | 1000 | Límite máximo de chats a devolver |
| `includePushname` | boolean | false | Incluir nombres de push para chats individuales |
| `lite` | boolean | false | Versión simplificada de respuesta |

### Modo Lite
Cuando `lite=true`, la respuesta incluye solo campos esenciales:

```json
{
  "id": "593999999999@c.us",
  "name": "Juan Pérez",
  "pushName": "Juan",
  "isGroup": false,
  "isReadOnly": false,
  "archived": false,
  "isMuted": false,
  "pinned": false,
  "timestamp": 1703123456,
  "unreadCount": 3
}
```

---

## 📋 Formatos de Respuesta

### Estructura Completa de Chat

```json
{
  "id": {
    "_serialized": "593999999999@c.us"
  },
  "name": "Juan Pérez",
  "pushname": "Juan",
  "isGroup": false,
  "isReadOnly": false,
  "archived": false,
  "isMuted": false,
  "pinned": false,
  "timestamp": 1703123456,
  "unreadCount": 3,
  "muteExpiration": 0,
  "lastMessage": {
    "id": {
      "fromMe": false,
      "_serialized": "false_593999999999@c.us_ABC123"
    },
    "body": "Mensaje de ejemplo",
    "timestamp": 1703123456,
    "from": "593999999999@c.us",
    "to": "593988888888@c.us",
    "type": "chat",
    "ack": 1,
    "hasMedia": false
  }
}
```

### Campos Importantes

| Campo | Tipo | Descripción |
|-------|------|-------------|
| `id._serialized` | string | ID único del chat |
| `name` | string | Nombre del contacto o grupo |
| `pushname` | string | Nombre de push (solo contactos) |
| `isGroup` | boolean | `true` si es un grupo |
| `isReadOnly` | boolean | `true` si el chat es de solo lectura |
| `archived` | boolean | `true` si el chat está archivado |
| `isMuted` | boolean | `true` si el chat está silenciado |
| `pinned` | boolean | `true` si el chat está fijado |
| `timestamp` | number | Timestamp del último mensaje |
| `unreadCount` | number | Número de mensajes no leídos |

### Identificadores de Chat

- **Contactos individuales:** `593999999999@c.us`
- **Grupos:** `120363XXXXXX@g.us`
- **Identificadores LID:** `XXXXXXXXXXXXX@lid` (automáticamente resueltos a números)

---

## 💡 Ejemplos de Uso

### Ejemplo 1: Obtener todos los chats

```bash
curl "https://mywhatsapp.jca.ec:5433/chat/chatting/getchats?number=TOKEN_SMSWHATSAPP"
```

### Ejemplo 2: Obtener solo chats con mensajes no leídos

```bash
curl "https://mywhatsapp.jca.ec:5433/chat/chatting/getchats?number=TOKEN_SMSWHATSAPP&onlyunread=true"
```

### Ejemplo 3: Obtener chats con límite y modo lite

```bash
curl "https://mywhatsapp.jca.ec:5433/chat/chatting/getchats?number=TOKEN_SMSWHATSAPP&limit=50&lite=true"
```

### Ejemplo 4: Obtener chats con nombres de push

```bash
curl "https://mywhatsapp.jca.ec:5433/chat/chatting/getchats?number=TOKEN_SMSWHATSAPP&includePushname=true"
```

### Ejemplo 5: Obtener chat específico

```bash
curl "https://mywhatsapp.jca.ec:5433/chat/chatting/getchatbyid/593999999999@c.us?number=TOKEN_SMSWHATSAPP"
```

### Ejemplo 6: Obtener contadores de mensajes sin entregar

```bash
# Contador específico de un chat
curl "https://mywhatsapp.jca.ec:5433/chat/chatting/undelivered-count/593999999999@c.us?number=TOKEN_SMSWHATSAPP"

# Todos los contadores
curl "https://mywhatsapp.jca.ec:5433/chat/chatting/undelivered-count-all?number=TOKEN_SMSWHATSAPP"
```

### Ejemplo 7: Reiniciar contador de un chat

```bash
curl -X POST "https://mywhatsapp.jca.ec:5433/chat/chatting/reset-undelivered-count/593999999999@c.us?number=TOKEN_SMSWHATSAPP"
```

---

## ⚠️ Consideraciones Importantes

### Resolución de @lid
- El sistema automáticamente intenta resolver identificadores `@lid` a números telefónicos
- Si la resolución falla, mantiene el identificador `@lid` original

### Límites y Rendimiento
- Default limit: 1000 chats
- Para mejor rendimiento, usar `lite=true` cuando no se necesiten todos los campos
- El parámetro `includePushname` puede afectar el rendimiento

### Estados de Error
- `"Client no found"`: Sesión no inicializada
- `"getchatserror"`: Error general al obtener chats
- `"please enter valid phone number"`: ID de chat inválido

### Gestión de Memoria
- Los contadores de mensajes sin entregar se mantienen en memoria
- Se reinician automáticamente cuando se resuelve la entrega

