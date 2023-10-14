## Enviar un archivo PDF por WhatsApp

Esta operación te permite enviar un archivo PDF en formato Base64 por WhatsApp. A continuación, se muestra cómo puedes usar esta operación con diferentes lenguajes de programación:

**URL**
```
https://mywhatsapp.jca.ec:5433/chat/sendmedia/{phone_number}?number={token}
```

**Método HTTP**
```
POST
```

**Parámetros de URL**
- `{phone_number}`: El número de teléfono al que deseas enviar el archivo PDF.
- `{token}`: Tu número de teléfono.

**Encabezados**
- `Content-Type: application/json`

**Cuerpo de la solicitud**
```json
{
    "caption" : "Hola Mundo, estamos usando el Servicio SMSWhatsApp, gracias por su preferencia",
    "typing"  : "3",
    "nowait"  : "true",
    "type"    : "application/pdf",
    "title"   : "Factura.pdf",
    "media"   : "BASE64"
}
```

### Ejemplos de uso

#### cURL
```bash
curl --location 'https://mywhatsapp.jca.ec:5433/chat/sendmedia/123456789?number=Phone03' \
--header 'Content-Type: application/json' \
--data '{
    "caption" : "Hola Mundo, estamos usando el Servicio SMSWhatsApp, gracias por su preferencia",
    "typing"  : "3",
    "nowait"  : "true",
    "type"    : "application/pdf",
    "title"   : "Factura.pdf",
    "media"   : "BASE64"
}'
```

#### Python (utilizando la biblioteca requests)
```python
import requests
import json
import base64

phone_number = "123456789"
token = "Phone03"

url = f"https://mywhatsapp.jca.ec:5433/chat/sendmedia/{phone_number}?number={token}"

headers = {
    "Content-Type": "application/json"
}

# Leer el archivo PDF y convertirlo a Base64
with open('ruta_del_archivo.pdf', 'rb') as file:
    pdf_data = file.read()
    pdf_base64 = base64.b64encode(pdf_data).decode('utf-8')

data = {
    "caption": "Hola Mundo, estamos usando el Servicio SMSWhatsApp, gracias por su preferencia",
    "typing": "3",
    "nowait": "true",
    "type": "application/pdf",
    "title": "Factura.pdf",
    "media": pdf_base64
}

response = requests.post(url, headers=headers, data=json.dumps(data))

print(response.json())
```

#### Node.js (utilizando Axios)
```javascript
const axios = require('axios');
const fs = require('fs');

const phone_number = "123456789";
const token = "Phone03";

const url = `https://mywhatsapp.jca.ec:5433/chat/sendmedia/${phone_number}?number=${token}`;

const headers = {
  "Content-Type": "application/json"
};

// Leer el archivo PDF y convertirlo a Base64
const pdfData = fs.readFileSync('ruta_del_archivo.pdf');
const pdfBase64 = pdfData.toString('base64');

const data = {
  caption: "Hola Mundo, estamos usando el Servicio SMSWhatsApp, gracias por su preferencia",
  typing: "3",
  nowait: "true",
  type: "application/pdf",
  title: "Factura.pdf",
  media: pdfBase64
};

axios.post(url, data, { headers })
  .then(response => {
    console.log(response.data);
  })
  .catch(error => {
    console.error(error);
  });
```

**Respuesta**
La respuesta de esta operación será un JSON que indica si el archivo PDF se envió correctamente por WhatsApp.

Recuerda que puedes utilizar estos ejemplos en cURL, Python y Node.js para realizar el envío del archivo PDF en formato Base64 por WhatsApp en tu API REST. Solo necesitas reemplazar los valores de `{phone_number}` y `{token}` con los números de teléfono deseados, y personalizar los valores en el cuerpo de la solicitud según tus necesidades.

> **Nota:** Al enviar un número telefónico por WhatsApp, asegúrate de incluir el código internacional del país, el código de área o ciudad (si es necesario) y el número de teléfono completo sin signo de más (+), espacios ni guiones. Por ejemplo, para un número en Estados Unidos, el formato sería: 1XXXXXXXXXX. Para un número de Ecuador sería: 5939XXXXXX.
