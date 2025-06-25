# 📊 Documentación - Sistema de Contadores y Control de Ban

## 🎯 Descripción General

Este sistema implementa un contador de mensajes sin recibir por chat y funcionalidades avanzadas de **prevención de ban** para la API de WhatsApp. 

### Características principales:
- ✅ **Contador por chat individual** de mensajes con ACK ≤ 1
- ✅ **Control inteligente de ban** con comportamiento humano simulado
- ✅ **Verificación de último mensaje** para detectar chats desbloqueados
- ✅ **Información en tiempo real** en todas las respuestas de envío
- ✅ **Gestión temporal en memoria** (se reinicia al reiniciar servicio)

---

## 📋 Nuevos Endpoints

### 1. 📈 Consultar contador de un chat específico

**GET** `/undelivered-count/:chatid`

Obtiene el número de mensajes sin recibir para un chat específico.

#### Parámetros:
- **`number`** (query, requerido): Número del cliente WhatsApp
- **`chatid`** (path, requerido): ID del chat a consultar

#### Ejemplo de solicitud:
```
GET /undelivered-count/5491112345678@c.us?number=token_sms_whatsapp
```

#### Respuesta exitosa:
```json
{
  "status": "success",
  "chatId": "5491112345678@c.us",
  "undeliveredCount": 3,
  "message": "Contador obtenido exitosamente"
}
```

---

### 2. 📊 Consultar todos los contadores

**GET** `/undelivered-count-all`

Obtiene **solo** los contadores de chats que tienen mensajes sin recibir (> 0). Los chats con contador en 0 son filtrados.

#### Parámetros:
- **`number`** (query, requerido): Número del cliente WhatsApp

#### Ejemplo de solicitud:
```
GET /undelivered-count-all?number=token_sms_whatsapp
```

#### Respuesta exitosa:
```json
{
  "status": "success",
  "message": {
    "number": "token_sms_whatsapp",
    "undeliveredMessagesByChat": {
      "5491112345678@c.us": 3,
      "5491187654321@c.us": 1,
      "120363043211234567@g.us": 2
    },
    "totalUndelivered": 6,
    "chatsWithUndeliveredMessages": 3
  }
}
```

#### Campos de respuesta:
- **`undeliveredMessagesByChat`**: Solo chats con contador > 0
- **`totalUndelivered`**: Suma total de mensajes sin recibir
- **`chatsWithUndeliveredMessages`**: Cantidad de chats con mensajes pendientes

---

### 3. 🔄 Reiniciar contador de un chat

**POST** `/reset-undelivered-count/:chatid`

Reinicia (pone en 0) el contador de mensajes sin recibir para un chat específico.

#### Parámetros:
- **`number`** (query, requerido): Número del cliente WhatsApp
- **`chatid`** (path, requerido): ID del chat a reiniciar

#### Ejemplo de solicitud:
```
POST /reset-undelivered-count/5491112345678@c.us?number=token_sms_whatsapp
```

#### Respuesta exitosa:
```json
{
  "status": "success",
  "chatId": "5491112345678@c.us",
  "message": "Contador reiniciado exitosamente"
}
```

---

## 🛡️ Nuevo Parámetro: Control de Ban 

### Descripción
Se agregó el parámetro **`controlBan`** a **TODOS** los endpoints de envío de mensajes para activar comportamiento de prevención de ban **con nueva lógica inteligente**.

### Endpoints que soportan `controlBan`:

#### **Chatting.js:**
- `POST /sendmessage/:phone`
- `POST /sendmedia/:phone`
- `POST /sendlocation/:phone`
- `POST /sendButtons/:chatid`
- `POST /sendList/:chatid`

#### **Group.js:**
- `POST /sendMessageById/:chatid`
- `POST /SendMediaById/:chatid`
- `POST /sendmessage/:chatname`
- `POST /sendmedia/:chatname`
- `POST /sendlocation/:chatname`
- `POST /sendlocationById/:chatid`

### Funcionamiento del Control de Ban (MEJORADO)

Cuando **`controlBan: true`**, el sistema ejecuta la siguiente secuencia:

1. **🔍 SendSeen obligatorio** del chat de destino
2. **⌨️ Typing por 3.2 segundos exactos**
3. **📥 Descarga últimos 20 mensajes** del chat
4. **✅ NUEVO: Verifica si el último mensaje es del destinatario**
   - **Si el último mensaje NO es fromMe:** Chat desbloqueado → **Envía inmediatamente**
   - **Si el último mensaje SÍ es fromMe:** Continúa con verificaciones
5. **🔢 Cuenta mensajes con ACK ≤ 1** (solo si último mensaje es nuestro)
6. **⏳ Si hay mensajes sin entregar:** Espera 10 segundos
7. **🔄 Re-verificación** después de la espera:
   - Verifica nuevamente si último mensaje es del destinatario
   - Si aún es nuestro, cuenta mensajes pendientes
8. **🚫 Si aún hay mensajes pendientes:** Bloquea envío

### Lógica del "Chat Desbloqueado"

**¿Por qué funciona este criterio?**

✅ **Si el último mensaje es del destinatario** (`!fromMe`):
- Significa que **recibió** nuestros mensajes anteriores
- **Respondió** después de recibirlos  
- El chat está **activo y desbloqueado**
- **Seguro enviar** → Procede inmediatamente

❌ **Si el último mensaje es nuestro** (`fromMe`):
- Posible que no haya visto nuestros mensajes
- Necesita **verificación adicional de ACK**
- Aplica lógica de **prevención de ban**

### Ejemplo de uso:

```json
{
  "message": "Hola, ¿cómo estás?",
  "controlBan": true
}
```

### Respuestas del Control de Ban:

#### Chat desbloqueado:
```json
{
  "status": "success",
  "message": "Mensaje enviado exitosamente",
  "chatUnlocked": true,
  "undeliveredInThisChat": 2,
  "totalUndelivered": 5
}
```

#### Ban prevenido:
```json
{
  "status": "error",
  "message": "No se envía para prevenir ban. Hay 3 mensajes sin recibir en este chat por posible bloqueo.",
  "undeliveredCount": 3,
  "preventedBan": true
}
```

---

## 📊 Información Agregada a Respuestas

**TODAS** las respuestas exitosas de envío ahora incluyen:

```json
{
  "status": "success",
  "message": "Mensaje enviado exitosamente",
  "id": "3EB0C0A5F7E4D2B1C8...",
  "undeliveredInThisChat": 2,
  "totalUndelivered": 5
}
```

### Campos agregados:
- **`undeliveredInThisChat`**: Mensajes sin recibir en el chat específico **ANTES** del envío actual
- **`totalUndelivered`**: Total de mensajes sin recibir en **TODOS** los chats **ANTES** del envío actual
- **`id`**: ID del mensaje enviado (para tracking)

**Nota importante:** Los contadores muestran el estado **ANTES** del envío actual, no incluyen el mensaje recién enviado.

---

## 🔧 Ejemplos Completos

### Envío con chat desbloqueado:

```bash
curl -X POST "http://localhost:3000/sendmessage/5491112345678?number=token_sms_whatsapp" \
  -H "Content-Type: application/json" \
  -d '{
    "message": "Hola mundo",
    "controlBan": true
  }'
```

### Respuesta (último mensaje del destinatario):
```json
{
  "status": "success", 
  "message": "Mensaje enviado exitosamente a 5491112345678@c.us",
  "id": "3EB0C0A5F7E4D2B1C8A9F6E3D5B7A1",
  "undeliveredInThisChat": 0,
  "totalUndelivered": 2,
  "fastDelivery": true
}
```

---

## ⚙️ Configuración y Consideraciones

### Algoritmo de ACK:
- **ACK 0**: Mensaje enviado
- **ACK 1**: Mensaje entregado al servidor WhatsApp  
- **ACK 2**: Mensaje entregado al dispositivo
- **ACK 3**: Mensaje leído

### Contadores:
- Se incrementan **ANTES** del envío
- Se decrementan cuando ACK pasa de ≤1 a >1
- Muestran estado **ANTES** del mensaje actual
- Incluyen **solo mensajes enviados** (`fromMe: true`)

### Control de Ban Inteligente:
- **Prioriza** respuesta del destinatario sobre ACK
- **Envío rápido** si el chat está desbloqueado
- **Prevención robusta** si hay señales de bloqueo
- **Doble verificación** tras espera de 10 segundos

### Timing Optimizado:
- **0 segundos** si último mensaje es del destinatario
- **3.2 segundos** de typing (solo si es necesario)
- **10 segundos** de espera si hay mensajes pendientes
- **20 mensajes** máximo descargados para verificación

---

## 🚨 Códigos de Estado

| Código | Descripción | Acción |
|--------|-------------|---------|
| `success` + último mensaje del destinatario | Envío rápido - chat desbloqueado | ✅ Continuar normalmente |
| `success` + verificación ACK pasada | Envío tras verificación completa | ✅ Continuar |
| `error` + `preventedBan: true` | Envío bloqueado por prevención de ban | ⏳ Esperar y reintentar |
| `error` | Error general de envío | ❌ Revisar parámetros |

---

## 📝 Casos de Uso Optimizados

### 🚀 Envío rápido (chat activo):
```json
{
  "message": "Respuesta rápida...",
  "controlBan": true
}
```
**→ Envío inmediato si el destinatario respondió recientemente**

### 🛡️ Envío seguro (chat inactivo):
```json
{
  "message": "Mensaje promocional...",
  "controlBan": true
}
```
**→ Verificación completa si no hay respuestas recientes**

### 📊 Monitoreo inteligente:
1. Verificar contadores antes del envío
2. Activar control de ban para máxima seguridad
3. El sistema detecta automáticamente chats activos vs inactivos

Esta implementación mejorada proporciona **máxima velocidad** para chats activos y **máxima protección** para chats de riesgo, optimizando tanto la experiencia del usuario como la prevención de suspensiones. 
