# Sistema de Encuestas WhatsApp - Documentación

## Descripción General

Este sistema permite crear y gestionar encuestas (polls) en WhatsApp utilizando la librería whatsapp-web.js. Las encuestas son una funcionalidad nativa de WhatsApp que permite hacer preguntas con múltiples opciones de respuesta. El sistema está integrado con el pool de múltiples clientes WhatsApp.

## Base URL

La base URL para realizar las peticiones es:
`https://mywhatsapp.jca.ec:5433`


## Características Principales

- ✅ Crear encuestas con hasta 12 opciones
- ✅ Soporte para respuestas únicas o múltiples
- ✅ Seguimiento en tiempo real de votos
- ✅ Almacenamiento de resultados en memoria por cliente
- ✅ API REST para gestión completa
- ✅ Limpieza automática de encuestas antiguas
- ✅ Multi-cliente: Cada token gestiona sus propias encuestas
- ✅ Integración completa con el sistema de logs

## Endpoints Disponibles

**Nota importante**: Todos los endpoints requieren el parámetro `?number=` en la query string, que corresponde al token del cliente WhatsApp.

### 1. Crear Encuesta
**POST** `/poll/create?number=TOKEN_CLIENTE`

Crea y envía una nueva encuesta a un chat de WhatsApp.

**Query Parameters:**
- `number` (requerido): Token del cliente WhatsApp

**Body:**
```json
{
    "chatId": "593999999999@c.us",
    "pregunta": "¿Cuál es tu lenguaje de programación favorito?",
    "opciones": ["JavaScript", "Python", "Java", "C++", "Otro"],
    "multipleAnswers": false
}
```

**Respuesta exitosa:**
```json
{
    "status": "SUCCESS",
    "pollId": "true_593999999999@c.us_3EB0123456789ABCDEF",
    "poll": {
        "pregunta": "¿Cuál es tu lenguaje de programación favorito?",
        "opciones": ["JavaScript", "Python", "Java", "C++", "Otro"],
        "multipleAnswers": false
    },
    "message": "Encuesta creada exitosamente"
}
```

### 2. Obtener Resultados de Encuesta
**GET** `/poll/results/:pollId?number=TOKEN_CLIENTE`

Obtiene los resultados actuales de una encuesta específica.

**Query Parameters:**
- `number` (requerido): Token del cliente WhatsApp

**Ejemplo:** `GET /poll/results/true_593999999999@c.us_3EB0123456789ABCDEF?number=TOKEN_CLIENTE`

**Respuesta:**
```json
{
    "status": "SUCCESS",
    "success": true,
    "pollId": "true_593999999999@c.us_3EB0123456789ABCDEF",
    "pregunta": "¿Cuál es tu lenguaje de programación favorito?",
    "multipleAnswers": false,
    "createdAt": "2025-09-12T15:30:00.000Z",
    "resultados": {
        "JavaScript": 5,
        "Python": 3,
        "Java": 2,
        "C++": 1,
        "Otro": 0
    },
    "totalVotantes": 11,
    "totalVotos": 11,
    "votantes": ["593999999991@c.us", "593999999992@c.us", ...]
}
```

### 3. Listar Todas las Encuestas
**GET** `/poll/all?number=TOKEN_CLIENTE`

Obtiene todas las encuestas activas del cliente especificado con sus resultados.

**Query Parameters:**
- `number` (requerido): Token del cliente WhatsApp

**Respuesta:**
```json
{
    "status": "SUCCESS",
    "totalPolls": 3,
    "polls": [
        {
            "pollId": "...",
            "pregunta": "...",
            "resultados": {...},
            ...
        }
    ]
}
```

### 4. Obtener Detalles de Votantes
**GET** `/poll/voters/:pollId?number=TOKEN_CLIENTE`

Obtiene información detallada sobre quién votó y qué opciones seleccionó.

**Query Parameters:**
- `number` (requerido): Token del cliente WhatsApp

**Respuesta:**
```json
{
    "status": "SUCCESS",
    "success": true,
    "pollId": "...",
    "pregunta": "¿Cuál es tu lenguaje favorito?",
    "votantes": [
        {
            "voterId": "593999999991@c.us",
            "opciones": ["JavaScript"],
            "timestamp": "2025-09-12T15:31:00.000Z"
        },
        {
            "voterId": "593999999992@c.us",
            "opciones": ["Python", "Java"],
            "timestamp": "2025-09-12T15:32:00.000Z"
        }
    ],
    "totalVotantes": 2
}
```

### 5. Eliminar Encuesta
**DELETE** `/poll/:pollId?number=TOKEN_CLIENTE`

Elimina una encuesta del registro (no del chat).

**Query Parameters:**
- `number` (requerido): Token del cliente WhatsApp

**Respuesta:**
```json
{
    "status": "SUCCESS",
    "message": "Encuesta eliminada del registro"
}
```

### 6. Limpiar Encuestas Antiguas
**POST** `/poll/clean?number=TOKEN_CLIENTE`

Elimina del registro todas las encuestas antiguas (más de 24 horas) del cliente especificado.

**Query Parameters:**
- `number` (requerido): Token del cliente WhatsApp

**Respuesta:**
```json
{
    "status": "SUCCESS",
    "message": "Se eliminaron 5 encuestas antiguas"
}
```

### 7. Resultados Globales Tabulados (NUEVO)
**GET** `/poll/global-results?number=TOKEN_CLIENTE&pregunta=PREGUNTA`

Obtiene resultados tabulados de todas las encuestas con pregunta similar, ideal para encuestas masivas enviadas a múltiples chats.

**Query Parameters:**
- `number` (requerido): Token del cliente WhatsApp
- `pregunta` (requerido): Pregunta a buscar
- `exactMatch` (opcional): `true` para búsqueda exacta, `false` para parcial (default: false)
- `hoursAgo` (opcional): Horas hacia atrás para buscar (default: 24)

**Ejemplo:** 
```
GET /poll/global-results?number=TOKEN&pregunta=lenguaje%20favorito&exactMatch=false&hoursAgo=48
```

**Respuesta:**
```json
{
    "status": "SUCCESS",
    "success": true,
    "pregunta": "lenguaje favorito",
    "preguntaOriginal": "¿Cuál es tu lenguaje de programación favorito?",
    "opciones": ["JavaScript", "Python", "Java", "C++", "Otro"],
    "totalEncuestas": 20,
    "totalVotantes": 157,
    "totalVotos": 157,
    "resultados": {
        "JavaScript": 65,
        "Python": 48,
        "Java": 25,
        "C++": 12,
        "Otro": 7
    },
    "porcentajes": {
        "JavaScript": "41.40%",
        "Python": "30.57%",
        "Java": "15.92%",
        "C++": "7.64%",
        "Otro": "4.46%"
    },
    "ranking": [
        { "opcion": "JavaScript", "votos": 65, "porcentaje": "41.40%" },
        { "opcion": "Python", "votos": 48, "porcentaje": "30.57%" },
        { "opcion": "Java", "votos": 25, "porcentaje": "15.92%" },
        { "opcion": "C++", "votos": 12, "porcentaje": "7.64%" },
        { "opcion": "Otro", "votos": 7, "porcentaje": "4.46%" }
    ],
    "resumenPorTipo": {
        "individual": { "encuestas": 18, "votantes": 18 },
        "grupo": { "encuestas": 2, "votantes": 139 }
    },
    "detallesPorChat": [
        {
            "pollId": "true_593999999999@c.us_3EB0...",
            "chatId": "593999999999@c.us",
            "tipoChat": "individual",
            "createdAt": "2025-09-16T10:00:00.000Z",
            "votantes": 1,
            "resultados": { "JavaScript": 1, "Python": 0, ... }
        },
        // ... más detalles
    ]
}
```

### 8. Listar Preguntas Únicas
**GET** `/poll/questions?number=TOKEN_CLIENTE`

Obtiene una lista de todas las preguntas únicas de encuestas recientes con su frecuencia.

**Query Parameters:**
- `number` (requerido): Token del cliente WhatsApp
- `hoursAgo` (opcional): Horas hacia atrás para buscar (default: 24)

**Respuesta:**
```json
{
    "status": "SUCCESS",
    "totalPreguntas": 5,
    "hoursAgo": 24,
    "preguntas": [
        {
            "pregunta": "¿Cuál es tu lenguaje de programación favorito?",
            "count": 20,
            "primeraVez": "2025-09-16T08:00:00.000Z",
            "ultimaVez": "2025-09-16T14:30:00.000Z"
        },
        {
            "pregunta": "¿Asistirás a la reunión del viernes?",
            "count": 15,
            "primeraVez": "2025-09-16T09:00:00.000Z",
            "ultimaVez": "2025-09-16T13:00:00.000Z"
        }
        // ... más preguntas
    ]
}
```

## Limitaciones y Consideraciones

### Límites de WhatsApp
- **Pregunta**: Máximo 255 caracteres
- **Opciones**: Entre 2 y 12 opciones
- **Texto por opción**: Máximo 100 caracteres
- **Votantes**: Sin límite establecido

### Aspectos Técnicos
1. **Almacenamiento**: 
   - Los resultados se guardan en memoria organizados por cliente/token
   - **Persistencia automática**: Cada encuesta se guarda en archivos JSON individuales en `buffer/polls/[TOKEN]/[POLL_ID].json`
   - Al reiniciar el proceso, todas las encuestas se cargan automáticamente desde disco
2. **Eventos de voto**: Se capturan automáticamente mediante el evento `vote_update` y se procesan con `processPollVote(number, vote)`
3. **Identificación**: Las encuestas se identifican por el ID del mensaje y se organizan por token del cliente
4. **Actualización**: Los votos se actualizan en tiempo real cuando los usuarios cambian su selección
5. **Estructura de datos**: `encuestasActivas[number][pollId]` donde `number` es el token del cliente

## Recolector Global de Resultados

### Concepto
El recolector global permite tabular resultados de encuestas similares enviadas a múltiples chats. Es ideal para:
- Encuestas masivas a clientes individuales
- Misma pregunta enviada a diferentes grupos
- Análisis consolidado de opiniones

### Características del Recolector

1. **Búsqueda Inteligente**: 
   - Por coincidencia parcial o exacta de pregunta
   - Filtrado por tiempo (últimas X horas)
   - Detección automática de encuestas similares
   - **Lee directamente desde archivos JSON persistentes**

2. **Tabulación Avanzada**:
   - Suma total de votos por opción
   - Cálculo de porcentajes globales
   - Ranking de opciones más votadas
   - Separación por tipo de chat (individual/grupo)
   - **Resultados completos incluso después de reiniciar**

3. **Análisis Detallado**:
   - Total de votantes únicos (evita duplicados)
   - Desglose por cada encuesta individual
   - Resumen estadístico completo
   - **Datos históricos preservados en disco**

### Flujo de Uso Típico

```bash
# 1. Enviar misma encuesta a múltiples contactos
POST /poll/create?number=TOKEN
{
    "chatId": "593991111111@c.us",
    "pregunta": "¿Cuál es tu lenguaje de programación favorito?",
    "opciones": ["JavaScript", "Python", "Java", "C++", "Otro"]
}
# Repetir para contactos: 593992222222@c.us, 593993333333@c.us, etc.

# 2. Esperar a que voten los usuarios

# 3. Ver todas las preguntas únicas enviadas
GET /poll/questions?number=TOKEN&hoursAgo=24

# 4. Obtener resultados globales tabulados
GET /poll/global-results?number=TOKEN&pregunta=lenguaje%20favorito&hoursAgo=24
```

## Casos de Uso

### Ejemplo 1: Encuesta Simple
```bash
# Crear encuesta de opción única
POST /poll/create?number=TOKEN_CLIENTE
Content-Type: application/json

{
    "chatId": "120363123456789012@g.us",
    "pregunta": "¿Asistirás a la reunión del viernes?",
    "opciones": ["Sí", "No", "Tal vez"],
    "multipleAnswers": false
}
```

### Ejemplo 2: Encuesta Múltiple
```bash
# Crear encuesta de opción múltiple
POST /poll/create?number=TOKEN_CLIENTE
Content-Type: application/json

{
    "chatId": "593999999999@c.us",
    "pregunta": "¿Qué días puedes asistir?",
    "opciones": ["Lunes", "Martes", "Miércoles", "Jueves", "Viernes"],
    "multipleAnswers": true
}
```

### Ejemplo 3: Verificar Resultados
```bash
# Obtener resultados de una encuesta
GET /poll/results/true_593999999999@c.us_3EB0123456789ABCDEF?number=TOKEN_CLIENTE
```

## Integración con el Sistema

El módulo de encuestas se integra completamente con el sistema MyWhatsApp Pool:

1. **Multi-Cliente**: Cada token/cliente gestiona sus propias encuestas de forma independiente
2. **Cliente WhatsApp**: Utiliza el cliente activo identificado por el token (`number`)
3. **Logging**: Registra eventos en el sistema de logs centralizado con `helper.addEventLog()`
4. **Eventos**: Escucha automáticamente los votos mediante el evento `vote_update`
5. **API REST**: Expone endpoints bajo la ruta `/poll` siguiendo el patrón del sistema
6. **Autenticación**: Valida que el cliente esté inicializado y autenticado antes de cada operación

