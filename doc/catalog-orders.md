# 📚 **Catálogos y Órdenes de WhatsApp Business**

## 🔐 **Autenticación y Parámetros Globales**

### **Parámetro `number`**
- **Descripción**: Token de autenticación de SmsWhatsApp
- **Tipo**: `string`
- **Obligatorio**: Sí
- **Ejemplo**: `593985202404`

### **Parámetro `userId`**
- **Descripción**: Número de teléfono del usuario/negocio
- **Tipo**: `string`
- **Formato**: Puede incluir o no `@c.us` (se agrega automáticamente)
- **Ejemplos**: `593985202404` o `593985202404@c.us`

---

## 📦 **ENDPOINTS DE CATÁLOGOS**

### **1. GET /catalog/personal**
Obtiene el catálogo personal del usuario autenticado usando métodos nativos del objeto Product.

#### **Parámetros de Query:**
| Parámetro | Tipo | Obligatorio | Descripción |
|-----------|------|-------------|-------------|
| `number` | string | ✅ | Token de SmsWhatsApp |

#### **Ejemplo cURL:**
```bash
curl -X GET "https://mywhatsapp.jca.ec:5433/catalog/personal?number=593985202404" \
  -H "Content-Type: application/json"
```

#### **Respuesta Exitosa (200):**
```json
{
  "status": "SUCCESS",
  "message": "Catálogo personal obtenido exitosamente",
  "data": {
    "type": "Personal",
    "userId": "593985202404@c.us",
    "isMe": true,
    "productsCount": 2,
    "collectionsCount": 1,
    "products": [
      {
        "id": "9935077999908299",
        "name": "AI SOLUTIONS HUB",
        "price": "$29.99 USD",
        "currency": "USD",
        "availability": "in stock",
        "reviewStatus": "APPROVED",
        "description": "Plataforma de IA para empresas",
        "imageCdnUrl": "https://media-bog2-2.cdn.whatsapp.net/v/t45.5328-4/503472987_1771844430434870_8570606247448612882_n.jpg...",
        "retailerId": "AG001"
      }
    ],
    "collections": [
      {
        "id": "COL_001",
        "name": "Servicios Digitales",
        "reviewStatus": "approved",
        "isHidden": false
      }
    ]
  }
}
```

---

### **2. GET /catalog/external/:businessId**
Obtiene el catálogo de un negocio externo.

#### **Parámetros de URL:**
| Parámetro | Tipo | Descripción |
|-----------|------|-------------|
| `businessId` | string | Número del negocio (con o sin @c.us) |

#### **Parámetros de Query:**
| Parámetro | Tipo | Obligatorio | Descripción |
|-----------|------|-------------|-------------|
| `number` | string | ✅ | Token de SmsWhatsApp |

#### **Ejemplo cURL:**
```bash
curl -X GET "https://mywhatsapp.jca.ec:5433/catalog/external/593984958499?number=593985202404" \
  -H "Content-Type: application/json"
```

#### **Respuesta Exitosa (200):**
```json
{
  "status": "SUCCESS",
  "message": "Catálogo externo obtenido exitosamente",
  "data": {
    "type": "External",
    "businessId": "593984958499@c.us",
    "userId": "593984958499@c.us",
    "isMe": false,
    "productsCount": 8,
    "collectionsCount": 2,
    "products": [
      {
        "id": "PROD_BURGER_001",
        "name": "Hamburguesa Clásica",
        "price": "$8.50 USD",
        "currency": "USD",
        "availability": "in stock",
        "reviewStatus": "APPROVED",
        "description": "Deliciosa hamburguesa con carne, lechuga y tomate",
        "imageCdnUrl": "https://media-bog2-2.cdn.whatsapp.net/...",
        "retailerId": "REST001"
      }
    ],
    "collections": [
      {
        "id": "COL_FOOD",
        "name": "Comidas",
        "reviewStatus": "approved",
        "isHidden": false
      }
    ]
  }
}
```

---

### **3. GET /catalog/collection/:userId/:collectionId/products**
Obtiene productos de una colección específica.

#### **Parámetros de URL:**
| Parámetro | Tipo | Descripción |
|-----------|------|-------------|
| `userId` | string | Número del usuario/negocio |
| `collectionId` | string | ID de la colección |

#### **Parámetros de Query:**
| Parámetro | Tipo | Obligatorio | Descripción |
|-----------|------|-------------|-------------|
| `number` | string | ✅ | Token de SmsWhatsApp |

#### **Ejemplo cURL:**
```bash
curl -X GET "https://mywhatsapp.jca.ec:5433/catalog/collection/593985202404/COL_001/products?number=593985202404" \
  -H "Content-Type: application/json"
```

#### **Respuesta Exitosa (200):**
```json
{
  "status": "SUCCESS",
  "message": "Productos de colección obtenidos exitosamente",
  "data": {
    "id": "COL_001",
    "name": "Servicios Digitales",
    "reviewStatus": "approved",
    "isHidden": false,
    "productsCount": 2,
    "products": [
      {
        "id": "9935077999908299",
        "name": "AI SOLUTIONS HUB",
        "price": "$29.99 USD",
        "currency": "USD",
        "availability": "in stock",
        "reviewStatus": "APPROVED",
        "description": "Plataforma de IA para empresas",
        "imageCdnUrl": "https://media-bog2-2.cdn.whatsapp.net/...",
        "retailerId": "AG001"
      }
    ]
  }
}
```

---

### **4. GET /catalog/product/:userId/:productId**
Obtiene información detallada de un producto específico usando métodos nativos.

#### **Parámetros de URL:**
| Parámetro | Tipo | Descripción |
|-----------|------|-------------|
| `userId` | string | Número del usuario/negocio propietario |
| `productId` | string | ID único del producto |

#### **Parámetros de Query:**
| Parámetro | Tipo | Obligatorio | Descripción |
|-----------|------|-------------|-------------|
| `number` | string | ✅ | Token de SmsWhatsApp |

#### **Ejemplo cURL:**
```bash
curl -X GET "https://mywhatsapp.jca.ec:5433/catalog/product/593985202404/9935077999908299?number=593985202404" \
  -H "Content-Type: application/json"
```

#### **Respuesta Exitosa (200):**
```json
{
  "status": "SUCCESS",
  "message": "Información del producto obtenida exitosamente",
  "data": {
    "id": "9935077999908299",
    "name": "AI SOLUTIONS HUB",
    "price": "$29.99 USD",
    "currency": "USD",
    "availability": "in stock",
    "reviewStatus": "APPROVED",
    "description": "Plataforma de IA para empresas",
    "imageCdnUrl": "https://media-bog2-2.cdn.whatsapp.net/v/t45.5328-4/503472987_1771844430434870_8570606247448612882_n.jpg...",
    "retailerId": "AG001",
    "metadata": {
      "id": "9935077999908299",
      "retailer_id": "AG001",
      "name": "AI SOLUTIONS HUB",
      "description": "Plataforma de IA para empresas",
      "availability": "in stock",
      "reviewStatus": "APPROVED",
      "additionalImageCdnUrl": [],
      "url": "",
      "isHidden": false,
      "imageCdnUrl": "https://media-bog2-2.cdn.whatsapp.net/...",
      "priceAmount1000": 2999000,
      "currency": "USD",
      "price": "",
      "salePriceAmount1000": 0,
      "productImageCount": 1,
      "retailerId": "AG001"
    }
  }
}
```

---

### **5. POST /catalog/send/personal**
Envía el catálogo personal por WhatsApp a un contacto con formateo nativo.

#### **Parámetros de Query:**
| Parámetro | Tipo | Obligatorio | Descripción |
|-----------|------|-------------|-------------|
| `number` | string | ✅ | Token de SmsWhatsApp |

#### **Body (JSON):**
| Campo | Tipo | Obligatorio | Descripción | Valor por Defecto |
|-------|------|-------------|-------------|-------------------|
| `toChat` | string | ✅ | Número del destinatario | - |
| `maxProducts` | number | ❌ | Máximo de productos a enviar | 10 |

#### **Ejemplo cURL:**
```bash
curl -X POST "https://mywhatsapp.jca.ec:5433/catalog/send/personal?number=593985202404" \
  -H "Content-Type: application/json" \
  -d '{
    "toChat": "593969626740@c.us",
    "maxProducts": 5
  }'
```

#### **Mensaje Enviado por WhatsApp:**
```
*Información del Catálogo*
Tipo: Personal
Productos: 2

• AI SOLUTIONS HUB - $29.99 USD
• CONSULTORÍA DIGITAL - $150.00 USD

Enviando 2 productos del catálogo...
```

Seguido de imágenes con caption:
```
*AI SOLUTIONS HUB*
Precio: $29.99 USD
Disponibilidad: in stock
```

#### **Respuesta Exitosa (200):**
```json
{
  "status": "SUCCESS",
  "message": "Catálogo personal enviado exitosamente",
  "data": {
    "totalProducts": 2,
    "sentProducts": 2,
    "toChat": "593969626740@c.us"
  }
}
```

---

### **6. POST /catalog/send/external**
Envía un catálogo externo por WhatsApp a un contacto.

#### **Body (JSON):**
| Campo | Tipo | Obligatorio | Descripción | Valor por Defecto |
|-------|------|-------------|-------------|-------------------|
| `toChat` | string | ✅ | Número del destinatario | - |
| `businessId` | string | ✅ | Número del negocio externo | - |
| `maxProducts` | number | ❌ | Máximo de productos a enviar | 3 |

#### **Ejemplo cURL:**
```bash
curl -X POST "https://mywhatsapp.jca.ec:5433/catalog/send/external?number=593985202404" \
  -H "Content-Type: application/json" \
  -d '{
    "toChat": "593969626740@c.us",
    "businessId": "593984958499",
    "maxProducts": 3
  }'
```

#### **Mensaje Enviado por WhatsApp:**
```
*Información del Catálogo Externo*
Negocio: 593984958499@c.us
Productos: 8
Colecciones: 2

• Hamburguesa Clásica - $8.50 USD
• Pizza Margherita - $12.00 USD
• Coca Cola - $2.50 USD

Imágenes del Catálogo Externo:
```

---

### **7. POST /catalog/send/product**
Envía información de un producto específico por WhatsApp usando datos nativos.

#### **Body (JSON):**
| Campo | Tipo | Obligatorio | Descripción |
|-------|------|-------------|-------------|
| `toChat` | string | ✅ | Número del destinatario |
| `userId` | string | ✅ | Número del propietario del producto |
| `productId` | string | ✅ | ID del producto |

#### **Ejemplo cURL:**
```bash
curl -X POST "https://mywhatsapp.jca.ec:5433/catalog/send/product?number=593985202404" \
  -H "Content-Type: application/json" \
  -d '{
    "toChat": "593969626740@c.us",
    "userId": "593985202404",
    "productId": "9935077999908299"
  }'
```

#### **Mensaje Enviado por WhatsApp:**
```
*Información del Producto*

*Nombre:* AI SOLUTIONS HUB
*ID del Producto:* 9935077999908299
*Descripción:* Plataforma de IA para empresas
*Negocio:* 593985202404@c.us
*Precio:* $29.99 USD
*Moneda:* USD
*Disponibilidad:* in stock
*Estado de Revisión:* APPROVED
```

Seguido de la imagen del producto con caption:
```
*AI SOLUTIONS HUB*
Precio: $29.99 USD
```

---

## 🛒 **ENDPOINTS DE ÓRDENES**

### **1. GET /order/:orderId**
Obtiene información de una orden específica.

#### **Parámetros de URL:**
| Parámetro | Tipo | Descripción |
|-----------|------|-------------|
| `orderId` | string | ID único de la orden |

#### **Parámetros de Query:**
| Parámetro | Tipo | Obligatorio | Descripción |
|-----------|------|-------------|-------------|
| `number` | string | ✅ | Token de SmsWhatsApp |
| `token` | string | ❌ | Token adicional de la orden |
| `chatId` | string | ❌ | ID del chat donde se generó la orden |

#### **Ejemplo cURL:**
```bash
curl -X GET "https://mywhatsapp.jca.ec:5433/order/ORD_123456789?number=593985202404&token=abc123&chatId=593969626740@c.us" \
  -H "Content-Type: application/json"
```

#### **Respuesta Exitosa (200):**
```json
{
  "status": "SUCCESS",
  "message": "Información de la orden obtenida exitosamente",
  "data": {
    "orderId": "ORD_123456789",
    "subtotal": "25.50",
    "total": "27.50",
    "currency": "USD",
    "createdAt": 1699123456789,
    "products": [
      {
        "id": "PROD_123456",
        "name": "Hamburguesa Clásica",
        "price": "8.50",
        "currency": "USD",
        "quantity": 2
      },
      {
        "id": "PROD_789012",
        "name": "Coca Cola",
        "price": "2.50",
        "currency": "USD",
        "quantity": 1
      }
    ]
  }
}
```

---

### **2. POST /order/confirm**
Procesa y confirma una orden recibida.

#### **Body (JSON):**
| Campo | Tipo | Obligatorio | Descripción |
|-------|------|-------------|-------------|
| `orderId` | string | ✅ | ID de la orden |
| `messageId` | string | ✅ | ID del mensaje de orden |
| `customMessage` | string | ❌ | Mensaje personalizado de confirmación |

#### **Ejemplo cURL:**
```bash
curl -X POST "https://mywhatsapp.jca.ec:5433/order/confirm?number=593985202404" \
  -H "Content-Type: application/json" \
  -d '{
    "orderId": "ORD_123456789",
    "messageId": "false_593969626740@c.us_3EB0123456789ABCDEF",
    "customMessage": "¡Gracias por tu orden! La tendremos lista en 30 minutos."
  }'
```

#### **Mensaje de Confirmación Enviado (si no se especifica customMessage):**
```
¡Gracias por tu orden! Tus productos estarán listos pronto.

*Detalles de la Orden:*
• ID de Orden: ORD_123456789
• Subtotal: $25.50 USD
• Total: $27.50 USD

*Productos:*
1. Hamburguesa Clásica
   Precio: $8.50 USD
   Cantidad: 2

2. Coca Cola
   Precio: $2.50 USD
   Cantidad: 1

Procesaremos tu orden y te notificaremos cuando esté lista para recoger/entregar.
```

#### **Respuesta Exitosa (200):**
```json
{
  "status": "SUCCESS",
  "message": "Orden confirmada exitosamente",
  "data": {
    "orderId": "ORD_123456789",
    "orderTotal": "$27.50 USD",
    "productsCount": 2,
    "confirmationSent": true
  }
}
```

---

### **3. GET /order/history**
Obtiene el historial de órdenes procesadas.

#### **Parámetros de Query:**
| Parámetro | Tipo | Obligatorio | Descripción | Valor por Defecto |
|-----------|------|-------------|-------------|-------------------|
| `number` | string | ✅ | Token de SmsWhatsApp | - |
| `limit` | number | ❌ | Límite de mensajes a revisar | 50 |
| `chatId` | string | ❌ | Filtrar por chat específico | - |

#### **Ejemplo cURL:**
```bash
curl -X GET "https://mywhatsapp.jca.ec:5433/order/history?number=593985202404&limit=20&chatId=593969626740@c.us" \
  -H "Content-Type: application/json"
```

#### **Respuesta Exitosa (200):**
```json
{
  "status": "SUCCESS",
  "message": "Historial de órdenes obtenido exitosamente",
  "data": {
    "ordersCount": 3,
    "orders": [
      {
        "messageId": "false_593969626740@c.us_3EB0123456789ABCDEF",
        "orderId": "ORD_123456789",
        "chatId": "593969626740@c.us",
        "chatName": "Cliente Ejemplo",
        "timestamp": 1699123456,
        "order": {
          "subtotal": "25.50",
          "total": "27.50",
          "currency": "USD",
          "createdAt": 1699123456789,
          "productsCount": 2,
          "products": [
            {
              "id": "PROD_123456",
              "name": "Hamburguesa Clásica",
              "price": "8.50",
              "currency": "USD",
              "quantity": 2
            }
          ]
        }
      }
    ]
  }
}
```

---

### **4. PUT /order/:orderId/status**
Actualiza el estado de una orden.

#### **Parámetros de URL:**
| Parámetro | Tipo | Descripción |
|-----------|------|-------------|
| `orderId` | string | ID de la orden |

#### **Body (JSON):**
| Campo | Tipo | Obligatorio | Descripción | Valores Válidos |
|-------|------|-------------|-------------|-----------------|
| `status` | string | ✅ | Nuevo estado de la orden | `pending`, `confirmed`, `preparing`, `ready`, `completed`, `cancelled` |
| `messageId` | string | ✅ | ID del mensaje de orden | - |
| `notifyCustomer` | boolean | ❌ | Notificar al cliente | `true` |
| `customMessage` | string | ❌ | Mensaje personalizado | - |

#### **Ejemplo cURL:**
```bash
curl -X PUT "https://mywhatsapp.jca.ec:5433/order/ORD_123456789/status?number=593985202404" \
  -H "Content-Type: application/json" \
  -d '{
    "status": "ready",
    "messageId": "false_593969626740@c.us_3EB0123456789ABCDEF",
    "notifyCustomer": true,
    "customMessage": "¡Tu orden está lista para recoger!"
  }'
```

#### **Mensaje de Notificación Enviado:**
```
¡Tu orden #ORD_123456789 está lista para recoger/entregar!
```

#### **Respuesta Exitosa (200):**
```json
{
  "status": "SUCCESS",
  "message": "Estado de la orden actualizado exitosamente",
  "data": {
    "orderId": "ORD_123456789",
    "newStatus": "ready",
    "customerNotified": true,
    "timestamp": "2023-11-04T15:30:45.123Z"
  }
}
```

---

### **5. POST /order/quote/info**
Envía información detallada de una orden citada.

#### **Body (JSON):**
| Campo | Tipo | Obligatorio | Descripción |
|-------|------|-------------|-------------|
| `messageId` | string | ✅ | ID del mensaje de orden citado |
| `toChat` | string | ✅ | Destinatario de la información |

#### **Ejemplo cURL:**
```bash
curl -X POST "https://mywhatsapp.jca.ec:5433/order/quote/info?number=593985202404" \
  -H "Content-Type: application/json" \
  -d '{
    "messageId": "false_593969626740@c.us_3EB0123456789ABCDEF",
    "toChat": "593984958499@c.us"
  }'
```

---

### **6. GET /order/report**
Genera un reporte de órdenes por período.

#### **Parámetros de Query:**
| Parámetro | Tipo | Obligatorio | Descripción | Formato |
|-----------|------|-------------|-------------|---------|
| `number` | string | ✅ | Token de SmsWhatsApp | - |
| `startDate` | string | ❌ | Fecha de inicio | `YYYY-MM-DD` |
| `endDate` | string | ❌ | Fecha de fin | `YYYY-MM-DD` |
| `chatId` | string | ❌ | Filtrar por chat específico | - |

#### **Ejemplo cURL:**
```bash
curl -X GET "https://mywhatsapp.jca.ec:5433/order/report?number=593985202404&startDate=2023-11-01&endDate=2023-11-30" \
  -H "Content-Type: application/json"
```

#### **Respuesta Exitosa (200):**
```json
{
  "status": "SUCCESS",
  "message": "Reporte de órdenes generado exitosamente",
  "data": {
    "period": {
      "startDate": "2023-11-01",
      "endDate": "2023-11-30",
      "startTimestamp": 1698796800,
      "endTimestamp": 1701388799
    },
    "summary": {
      "totalOrders": 25,
      "currencyTotals": {
        "USD": 1250.75,
        "EUR": 850.30
      },
      "averageOrderValue": 84.04
    },
    "topProducts": [
      {
        "name": "Hamburguesa Clásica",
        "soldCount": 15,
        "totalRevenue": 127.50,
        "currency": "USD"
      }
    ],
    "orders": [...]
  }
}
```

---

## ❌ **Códigos de Error Comunes**

### **400 - Bad Request**
```json
{
  "status": "ERROR",
  "message": "Los parámetros 'number' y 'businessId' son obligatorios"
}
```

### **404 - Not Found**
```json
{
  "status": "ERROR",
  "message": "Client no encontrado"
}
```

### **500 - Internal Server Error**
```json
{
  "status": "ERROR",
  "message": "Error interno del servidor",
  "error": "Descripción detallada del error"
}
```

---

## 🚀 **Ejemplos de Uso Completo Actualizados**

### **Flujo: Obtener y Enviar Catálogo Personal con Precios Nativos**
```bash
# 1. Obtener catálogo personal (precios formateados automáticamente)
curl -X GET "https://mywhatsapp.jca.ec:5433/catalog/personal?number=593985202404"

# 2. Enviar catálogo a un cliente (usa formateo nativo)
curl -X POST "https://mywhatsapp.jca.ec:5433/catalog/send/personal?number=593985202404" \
  -H "Content-Type: application/json" \
  -d '{"toChat": "593969626740@c.us", "maxProducts": 5}'
```

### **Flujo: Obtener Producto Específico con Formateo Nativo**
```bash
# Obtener producto específico (precio formateado automáticamente)
curl -X GET "https://mywhatsapp.jca.ec:5433/catalog/product/593985202404/9935077999908299?number=593985202404"
```

---
