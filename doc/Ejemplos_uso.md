# Ejemplos de Uso - Nuevas Funcionalidades WhatsApp API

Este documento contiene ejemplos prácticos de uso con cURL para todas las nuevas funcionalidades agregadas.

---

## 📋 1. Chat Management

### Marcar chat como no leído
```bash
curl -X POST "https://mywhatsapp.jca.ec:5433/chat/markunread/5491234567890@c.us?number=5491234567890"
```

### Limpiar mensajes de un chat
```bash
curl -X POST "https://mywhatsapp.jca.ec:5433/chat/clearmessages/5491234567890@c.us?number=5491234567890"
```

---

## 👤 2. Profile Management

### Establecer foto de perfil (desde URL)
```bash
curl -X POST "https://mywhatsapp.jca.ec:5433/chat/setprofilepicture?number=5491234567890" \
  -H "Content-Type: application/json" \
  -d '{
    "media": "https://example.com/profile-pic.jpg",
    "type": "image/jpeg"
  }'
```

### Establecer foto de perfil (desde base64)
```bash
curl -X POST "https://mywhatsapp.jca.ec:5433/chat/setprofilepicture?number=5491234567890" \
  -H "Content-Type: application/json" \
  -d '{
    "media": "/9j/4AAQSkZJRgABAQEAYABgAAD...",
    "type": "image/jpeg"
  }'
```

### Eliminar foto de perfil
```bash
curl -X DELETE "https://mywhatsapp.jca.ec:5433/chat/deleteprofilepicture?number=5491234567890"
```

### Establecer nombre de visualización
```bash
curl -X POST "https://mywhatsapp.jca.ec:5433/chat/setdisplayname?number=5491234567890" \
  -H "Content-Type: application/json" \
  -d '{
    "displayName": "Bot de Soporte"
  }'
```

### Establecer estado (bio)
```bash
curl -X POST "https://mywhatsapp.jca.ec:5433/chat/setstatus?number=5491234567890" \
  -H "Content-Type: application/json" \
  -d '{
    "status": "Disponible 24/7 para ayudarte"
  }'
```

### Obtener contactos bloqueados
```bash
curl -X GET "https://mywhatsapp.jca.ec:5433/chat/getblockedcontacts?number=5491234567890"
```

---

## 🔍 3. Búsqueda

### Buscar mensajes
```bash
curl -X POST "https://mywhatsapp.jca.ec:5433/chat/searchmessages?number=5491234567890" \
  -H "Content-Type: application/json" \
  -d '{
    "query": "factura",
    "options": {
      "page": 1,
      "limit": 20
    }
  }'
```

---

## 🏷️ 4. Labels (WhatsApp Business)

### Obtener todas las etiquetas
```bash
curl -X GET "https://mywhatsapp.jca.ec:5433/chat/getlabels?number=5491234567890"
```

### Obtener etiquetas de un chat
```bash
curl -X GET "https://mywhatsapp.jca.ec:5433/chat/getchatlabels/5491234567890@c.us?number=5491234567890"
```

### Agregar etiquetas a chats
```bash
curl -X POST "https://mywhatsapp.jca.ec:5433/chat/addoreditlabels?number=5491234567890" \
  -H "Content-Type: application/json" \
  -d '{
    "labelIds": ["1", "2"],
    "chatIds": ["5491234567890@c.us", "5499876543210@c.us"]
  }'
```

---

## 👥 5. Advanced Group Features

### Aceptar invitación de grupo
```bash
curl -X POST "https://mywhatsapp.jca.ec:5433/group/acceptinvite?number=5491234567890" \
  -H "Content-Type: application/json" \
  -d '{
    "inviteCode": "InV1T3C0d3ExAmpl3"
  }'
```

### Salir de un grupo
```bash
curl -X POST "https://mywhatsapp.jca.ec:5433/group/leave/1234567890-1234567890@g.us?number=5491234567890"
```

### Cambiar nombre del grupo
```bash
curl -X POST "https://mywhatsapp.jca.ec:5433/group/setsubject/1234567890-1234567890@g.us?number=5491234567890" \
  -H "Content-Type: application/json" \
  -d '{
    "subject": "Equipo de Ventas 2024"
  }'
```

### Cambiar descripción del grupo
```bash
curl -X POST "https://mywhatsapp.jca.ec:5433/group/setdescription/1234567890-1234567890@g.us?number=5491234567890" \
  -H "Content-Type: application/json" \
  -d '{
    "description": "Grupo oficial del equipo de ventas. Solo mensajes relacionados con trabajo."
  }'
```

### Restringir edición a solo admins
```bash
curl -X POST "https://mywhatsapp.jca.ec:5433/group/setinfoadminsonly/1234567890-1234567890@g.us?number=5491234567890" \
  -H "Content-Type: application/json" \
  -d '{
    "adminsOnly": true
  }'
```

### Permitir edición a todos
```bash
curl -X POST "https://mywhatsapp.jca.ec:5433/group/setinfoadminsonly/1234567890-1234567890@g.us?number=5491234567890" \
  -H "Content-Type: application/json" \
  -d '{
    "adminsOnly": false
  }'
```

---

## 📢 6. Channels (Broadcast Channels)

### Crear un canal
```bash
curl -X POST "https://mywhatsapp.jca.ec:5433/channel/create?number=5491234567890" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Noticias de la Empresa",
    "options": {
      "description": "Canal oficial de noticias y actualizaciones"
    }
  }'
```

### Listar todos los canales
```bash
curl -X GET "https://mywhatsapp.jca.ec:5433/channel/list?number=5491234567890"
```

### Buscar canales
```bash
curl -X POST "https://mywhatsapp.jca.ec:5433/channel/search?number=5491234567890" \
  -H "Content-Type: application/json" \
  -d '{
    "searchOptions": {
      "query": "tecnologia",
      "limit": 10
    }
  }'
```

### Suscribirse a un canal
```bash
curl -X POST "https://mywhatsapp.jca.ec:5433/channel/subscribe/123456789@newsletter?number=5491234567890"
```

### Desuscribirse de un canal
```bash
curl -X POST "https://mywhatsapp.jca.ec:5433/channel/unsubscribe/123456789@newsletter?number=5491234567890" \
  -H "Content-Type: application/json" \
  -d '{
    "options": {
      "revokeAdmin": false
    }
  }'
```

### Obtener canal por código de invitación
```bash
curl -X GET "https://mywhatsapp.jca.ec:5433/channel/byinvitecode/InV1T3C0d3?number=5491234567890"
```

### Eliminar un canal
```bash
curl -X DELETE "https://mywhatsapp.jca.ec:5433/channel/delete/123456789@newsletter?number=5491234567890"
```

---

## 🔗 Testing con Postman

Si prefieres usar Postman, aquí tienes cómo configurar las peticiones:

### Ejemplo: Crear Canal

1. **Method**: POST
2. **URL**: `https://mywhatsapp.jca.ec:5433/channel/create?number=5491234567890`
3. **Headers**:
   ```
   Content-Type: application/json
   ```
4. **Body** (raw JSON):
   ```json
   {
     "title": "Canal de Prueba",
     "options": {
       "description": "Este es un canal de prueba"
     }
   }
   ```

### Ejemplo: Buscar Mensajes

1. **Method**: POST
2. **URL**: `https://mywhatsapp.jca.ec:5433/chat/searchmessages?number=5491234567890`
3. **Headers**:
   ```
   Content-Type: application/json
   ```
4. **Body** (raw JSON):
   ```json
   {
     "query": "hola",
     "options": {
       "page": 1,
       "limit": 50
     }
   }
   ```

---

## 📝 Notas de Uso

### Formato de IDs:

- **Chat Individual**: `5491234567890@c.us` (número + @c.us)
- **Grupo**: `1234567890-1234567890@g.us` (timestamp-timestamp@g.us)
- **Canal**: `123456789@newsletter` (id@newsletter)
- **LID (anónimo)**: `1234567890@lid` (id@lid)

### Parámetro `number`:

Este parámetro es el **token de SmsWhatsApp** y siempre debe incluirse como query parameter para identificar el cliente WhatsApp:
```
?number=TOKEN_SMSWHATSAPP
```

### Respuestas Típicas:

**Éxito**:
```json
{
  "status": "SUCCESS",
  "message": "Operación completada exitosamente",
  "data": { /* datos adicionales */ }
}
```

**Error**:
```json
{
  "status": "ERROR",
  "message": "Descripción del error"
}
```

---

## 🚀 Script de Testing Completo

Aquí hay un script bash que prueba todas las funcionalidades:

```bash
#!/bin/bash

# Configuración
BASE_URL="https://mywhatsapp.jca.ec:5433"
NUMBER="TOKEN_SMSWHATSAPP" # El token de su cliente SmsWhatsApp
CHAT_ID="${NUMBER}@c.us"
GROUP_ID="1234567890-1234567890@g.us"

echo "=== Testing WhatsApp API - Nuevas Funcionalidades ==="

# 1. Profile Management
echo -e "\n--- Profile Management ---"
curl -X POST "${BASE_URL}/chat/setdisplayname?number=${NUMBER}" \
  -H "Content-Type: application/json" \
  -d '{"displayName":"Bot Test"}'

curl -X POST "${BASE_URL}/chat/setstatus?number=${NUMBER}" \
  -H "Content-Type: application/json" \
  -d '{"status":"Testing API"}'

# 2. Chat Management
echo -e "\n--- Chat Management ---"
curl -X POST "${BASE_URL}/chat/markunread/${CHAT_ID}?number=${NUMBER}"

# 3. Search
echo -e "\n--- Search ---"
curl -X POST "${BASE_URL}/chat/searchmessages?number=${NUMBER}" \
  -H "Content-Type: application/json" \
  -d '{"query":"hola","options":{"limit":10}}'

# 4. Labels
echo -e "\n--- Labels ---"
curl -X GET "${BASE_URL}/chat/getlabels?number=${NUMBER}"

# 5. Group Features
echo -e "\n--- Group Features ---"
curl -X POST "${BASE_URL}/group/setsubject/${GROUP_ID}?number=${NUMBER}" \
  -H "Content-Type: application/json" \
  -d '{"subject":"Test Group"}'

# 6. Channels
echo -e "\n--- Channels ---"
curl -X GET "${BASE_URL}/channel/list?number=${NUMBER}"

echo -e "\n\n=== Testing Complete ==="
```

Guarda este script como `test_api.sh`, dale permisos de ejecución y ejecuta:
```bash
chmod +x test_api.sh
./test_api.sh
```

---

## 🔐 Seguridad

**Importante**: En producción, considera agregar:
- Autenticación con tokens JWT o API Keys
- Rate limiting para prevenir abuso
- HTTPS en lugar de HTTP
- Validación estricta de parámetros de entrada
- Sanitización de datos para prevenir injection attacks
