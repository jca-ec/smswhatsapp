## Verificar si un número de teléfono pertenece a WhatsApp

Esta operación te permite verificar si un número de teléfono específico pertenece a WhatsApp como cuenta válida.
A continuación, se muestra cómo puedes usar esta operación con diferentes lenguajes de programación:

**URL**
```
https://mywhatsapp.jca.ec:5433/contact/isregistereduser/{phone_number}?number={token}
```

**Método HTTP**
```
GET
```

**Parámetros de URL**
- `{phone_number}`: El número de teléfono que deseas verificar si pertenece a WhatsApp.
- `{token}`: Tu token de SMSWhatsApp, para practicas usa `Phone03`.

### Ejemplos de uso

#### cURL
```bash
curl --location 'https://mywhatsapp.jca.ec:5433/contact/isregistereduser/124567890?number=Phone03'
```

#### Python
```python
import requests

phone_number = "124567890"
token = "Phone03"

url = f"https://mywhatsapp.jca.ec:5433/contact/isregistereduser/{phone_number}?number={token}"
response = requests.get(url)

print(response.json())
```

#### Node.js
```javascript
const axios = require('axios');

const phone_number = "124567890";
const token = "Phone03";

const url = `https://mywhatsapp.jca.ec:5433/contact/isregistereduser/${phone_number}?number=${token}`;

axios.get(url)
  .then(response => {
    console.log(response.data);
  })
  .catch(error => {
    console.error(error);
  });
```

**Respuesta**
La respuesta de esta operación será un JSON que indica si el número de teléfono pertenece a WhatsApp o no.

Recuerda que puedes utilizar estos ejemplos en cURL, Python y Node.js para realizar la verificación del número de teléfono en tu API REST. Solo necesitas reemplazar los valores de `1234567890` por el número telefónico que deseas consultar y `Phone03` con el token de tu licencia de SMSWhatsApp, Phone03 es una licencia de prueba.

> **Nota:** Al enviar un número telefónico por WhatsApp, asegúrate de incluir el código internacional del país, el código de área o ciudad (si es necesario) y el número de teléfono completo sin signo de más (+), espacios ni guiones. Por ejemplo, para un número en Estados Unidos, el formato sería: 1XXXXXXXXXX. Para un número de Ecuador sería: 5939XXXXXXXX.
