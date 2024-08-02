# SMSWhatsApp IA LLMGenerador

Este proyecto es una implementación de un servicio de respuestas automatizadas usando inteligencia artificial a través de la plataforma SMSWhatsApp. El objetivo es demostrar cómo se pueden automatizar las respuestas a consultas de clientes utilizando modelos de lenguaje avanzados.

## Introducción

En la era digital actual, la capacidad de responder rápidamente a las consultas de los clientes es crucial para el éxito de cualquier negocio. Las respuestas automatizadas con inteligencia artificial ofrecen varias ventajas:

- **Disponibilidad 24/7:** Los asistentes de IA pueden manejar consultas en cualquier momento del día, mejorando la experiencia del cliente.
- **Eficiencia:** Respuestas inmediatas reducen el tiempo de espera para los clientes y aumentan la eficiencia del servicio.
- **Consistencia:** Las respuestas automatizadas garantizan que se proporcione información precisa y coherente.
- **Escalabilidad:** Permite gestionar un gran volumen de consultas simultáneamente sin necesidad de aumentar los recursos humanos.

## Descripción del Proyecto

Este proyecto utiliza el servicio SMSWhatsApp para integrar respuestas automatizadas generadas por inteligencia artificial a través de un modelo de lenguaje natural. El sistema se conecta a la API de SMSWhatsApp para obtener chats no leídos, generar respuestas mediante un modelo de lenguaje, y enviar las respuestas a los usuarios.

### Cómo Funciona

1. **Obtención de Chats:** 
   - El sistema se conecta a la API de SMSWhatsApp para obtener una lista de chats no leídos.

2. **Generación de Respuestas:**
   - Se utiliza un modelo de lenguaje natural para generar una respuesta basada en la información proporcionada por el cliente y el contexto del negocio.

3. **Envío de Respuestas:**
   - Las respuestas generadas son enviadas automáticamente a los clientes a través de la API de SMSWhatsApp.

4. **Marcado de Chats:**
   - Los chats son marcados como leídos una vez que se ha generado y enviado una respuesta.

### Requisitos

- Node.js
- Una cuenta en SMSWhatsApp con acceso a la API

### Instalación

1. Clona este repositorio:

   ```bash
   git clone https://github.com/elhumbertoz/chatbot-ia
   cd chatbot-ia
   ```
2. Instala las dependencias:
   ```bash
   npm install
   ```
3. Configura las variables de entorno en un archivo .env:

```makefile
SMSWHATSAPP_URL=<tu_api_url>
SMSWHATSAPP_TOKEN=<tu_token>
```

### Uso
Para ejecutar el servicio, utiliza el siguiente comando:

```bash
node index.js
```

El sistema se ejecutará de manera continua, verificando los mensajes no leídos y respondiendo automáticamente a ellos.

Contribuciones
Las contribuciones son bienvenidas. Si tienes ideas o mejoras, no dudes en abrir un issue o enviar un pull request.

Licencia
Este proyecto está bajo la licencia MIT. Consulta el archivo LICENSE para más detalles.
