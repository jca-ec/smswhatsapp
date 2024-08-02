# Endpoint: /chat/LLMGenerate/
## Descripción
El endpoint /chat/LLMGenerate/ está diseñado para interactuar con un modelo de inteligencia artificial que genera respuestas automáticas a partir de un conjunto de mensajes proporcionados por el usuario. Este endpoint toma los últimos 10 mensajes de una conversación, junto con un systemMessage que establece el contexto de la interacción, para crear una respuesta coherente y relevante.

## Funcionamiento
### 1. Recopilación de Mensajes:
   El sistema obtiene los últimos 10 mensajes de una conversación. Estos mensajes proporcionan el contexto necesario para que el modelo de lenguaje entienda la conversación actual.
   
### 2. Contextualización con systemMessage:
   Se incluye un systemMessage que actúa como un marco de referencia para la conversación. Este mensaje puede contener instrucciones sobre cómo debe comportarse el modelo, qué tipo de respuestas debe proporcionar, o cualquier otra información relevante para guiar la generación de la respuesta.

### 3. Generación de Respuesta:
   El modelo de inteligencia artificial procesa los mensajes y el systemMessage para generar una respuesta automática. La respuesta está diseñada para ser coherente con el contexto y cumplir con las directrices establecidas en el systemMessage.

### 4.  Devolución de Respuesta:
   El endpoint devuelve la respuesta generada, la cual puede ser enviada de vuelta al usuario o cliente final.

## Ejemplo de Uso con `curl`
Supongamos que quieres generar una respuesta para un cliente utilizando el endpoint /chat/LLMGenerate/. Aquí te mostramos cómo hacerlo mediante curl:

### Datos de Ejemplo
* ID del Teléfono: 593980462125
* Token de Autenticación: your_auth_token
* URL de la API: https://mywhatsapp.jca.ec:5433/chat/LLMGenerate/
* systemMessage de Ejemplo
```json
{
  "systemMessage": "Esta es una conversación con un asistente virtual que proporciona soporte técnico y administrativo para Gigamax. Responde exclusivamente en español y ofrece soluciones a problemas relacionados con los servicios de internet proporcionados por Gigamax."
}
```

### Comando curl
```bash
Copiar código
curl -X POST 'https://mywhatsapp.jca.ec:5433/chat/LLMGenerate/593980462125?number=your_auth_token&limit=10' \
-H 'Content-Type: application/json' \
-d '{
  "systemMessage": "Esta es una conversación con un asistente virtual que proporciona soporte técnico y administrativo para Gigamax. Responde exclusivamente en español y ofrece soluciones a problemas relacionados con los servicios de internet proporcionados por Gigamax."
}'
```
### Explicación del Comando
* -X POST: Especifica que se está realizando una solicitud POST.
* URL: https://mywhatsapp.jca.ec:5433/chat/LLMGenerate/593980462125?number=your_auth_token&limit=10
* 593980462125: El ID del teléfono del cliente para el cual se está generando la respuesta.
* your_auth_token: El token de autenticación necesario para autorizar la solicitud.
* limit=10: Parámetro que indica que se deben considerar los últimos 10 mensajes para generar la respuesta.
* -H 'Content-Type: application/json': Indica que el cuerpo de la solicitud está en formato JSON.
* -d: Proporciona el cuerpo de la solicitud, que incluye el systemMessage.

### Respuesta Esperada
La respuesta del endpoint será un objeto JSON que contiene el estado de la operación y el mensaje generado por el modelo de inteligencia artificial. Un ejemplo de respuesta exitosa podría ser:

```json
{
  "status": "success",
  "message": "Gracias por contactar con Gigamax. ¿En qué puedo ayudarte hoy?"
}
```
## Notas Adicionales
* Personalización: El systemMessage puede ser personalizado para diferentes escenarios de negocio o tipos de interacciones.
* Seguridad: Asegúrate de proteger tu token de autenticación y manejar adecuadamente cualquier información sensible.
Este enfoque permite automatizar las respuestas a las consultas de los clientes, mejorando la eficiencia y la consistencia del servicio al cliente.
