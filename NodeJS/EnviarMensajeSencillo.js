const axios = require('axios');

// La URL a la que desea enviar la solicitud POST, ponerla aquí
// 593984958499 representa el NÚMERO DESTINO
// Phone03 es el identificador del cliente, para éste caso es la DEMO
const url = 'http://mywhatsapp.jca.ec:5001/chat/sendmessage/593984958499?number=Phone03';

// Los datos que desea enviar a través de POST, ver los parámetros que requiere según sea el caso 
// Los datos son enviados en una estructura json
const data = {
  message: 'Hola Mundo, estamos usando el Servicio SMSWhatsApp, gracias por su preferencia',
  typing: '3',
  nowait: 'true'
};

// Configuración para la solicitud POST
const config = {
  headers: {
    'Content-Type': 'application/json',
  },
};

// Realizar la solicitud POST con axios
axios.post(url, data, config)
  .then(response => {
    // Se muestra el resultado obtenido, erróneo / correcto
    console.log(response.data);
  })
  .catch(error => {
    // Manejar errores aquí
    console.error('Error en la solicitud:', error.message);
  });
