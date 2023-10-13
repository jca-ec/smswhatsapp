## API REST para enviar PDF por WhatsApp

Esta API REST te permite enviar una documento PDF por WhatsApp a un número específico. A continuación, se muestra cómo usarla en diferentes lenguajes de programación:

### Ejemplo de uso con cURL

```bash
curl --location "https://mywhatsapp.jca.ec:5433/chat/sendmedia/1234567890?number=Phone03" --header "Content-Type: application/json" --data "{
    \"caption\": \"Estimado cliente, gracias por preferirnos aquí está su factura\",
    \"media\": \"http://gptear.com/assets/docs/0.pdf\",
    \"type\": \"application/pdf\",
    \"title\": \"factura.pdf\"
}"
```

### Ejemplo de uso con Python

```python
import requests

url = "https://mywhatsapp.jca.ec:5433/chat/sendmedia/1234567890?number=Phone03"
headers = {
    "Content-Type": "application/json"
}
data = {
    "caption": "Estimado cliente, gracias por preferirnos aquí está su factura",
    "media": "http://gptear.com/assets/docs/0.pdf",
    "type": "application/pdf",
    "title": "factura.pdf"
}

response = requests.post(url, headers=headers, json=data)
print(response.json())
```

### Ejemplo de uso con JavaScript (Node.js)

```javascript
const axios = require('axios');

const url = "https://mywhatsapp.jca.ec:5433/chat/sendmedia/1234567890?number=Phone03";
const headers = {
    "Content-Type": "application/json"
};
const data = {
    "caption": "Estimado cliente, gracias por preferirnos aquí está su factura",
    "media": "http://gptear.com/assets/docs/0.pdf",
    "type": "application/pdf",
    "title": "factura.pdf"
};

axios.post(url, data, { headers })
    .then(response => {
        console.log(response.data);
    })
    .catch(error => {
        console.error(error);
    });
```

Recuerda reemplazar los valores de `1234567890` con el número de teléfono al que deseas enviar la factura.

Espero que esta documentación te sea útil. Si tienes alguna otra pregunta, ¡no dudes en preguntar!
