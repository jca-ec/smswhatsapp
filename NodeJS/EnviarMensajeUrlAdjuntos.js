const axios = require('axios');

// La URL a la que desea enviar la solicitud POST
// 593984958499 representa el NÚMERO DESTINO
// Phone03 es el identificador del cliente, para este caso es la DEMO
const url = 'http://mywhatsapp.jca.ec:5001/chat/sendmedia/593984958499?number=Phone03';

// Los datos que desea enviar a través de POST, ver los parámetros que requiere según sea el caso 
// Los datos son enviados en una estructura json
// NOTA: para que el servicio descargue un adjunto desde una url los parámetros:
//       media debe contener la url correcta del pdf
//       captión reemplaza a message, UNICAMENTE si desea adjuntar textos al pie del pdf
const data = {
    caption: 'Estimado cliente, gracias por preferirnos aquí está su factura',
    typing: '3',
    nowait: 'true',
    type: 'application/pdf',
    title: 'Factura.pdf',
    media: 'https://www.bolsadeproductos.cl/application/normativas/Manual+de+Operaciones+con+Facturas.pdf'
};

// Realizar la solicitud POST usando axios
axios.post(url, data)
    .then(response => {
        // Se muestra el resultado obtenido, erroneo / correcto
        console.log(response.data);
    })
    .catch(error => {
        // En caso de error, se muestra el mensaje de error
        console.error(error.message);
    });
