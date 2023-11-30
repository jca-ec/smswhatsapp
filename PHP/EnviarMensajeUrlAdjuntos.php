<?php
// Aquí va el código, el resto es solo colocar las URLS correspondientes
// Si tiene licencia del Servicio SMSWhatsApp por favor solicitar por correo sus urls

// La URL a la que desea enviar la solicitud POST, ponerla aquí
// 593984958499 representa el NÚMERO DESTINO
// Phone03 es el identificador del cliente, para éste caso es la DEMO
$url = 'http://mywhatsapp.jca.ec:5001/chat/sendmedia/593984958499?number=Phone03';

// Los datos que desea enviar a través de POST, ver los parámetros que requiere según sea el caso 
// Los datos son enviados en una estructura json
// NOTA: para que el servicio descargue un adjunto desde una url los parámetros:
//       media debe contener la url correcta del pdf
//       captión reemplaza a message, UNICAMENTE si desea adjuntar textos al pie del pdf
$fields = [
    'caption' => 'Estimado cliente, gracias por preferirnos aquí está su factura',
    'typing'  => '3',
    'nowait'  => 'true',
    'type'    => 'application/pdf',
    'title'   => 'Factura.pdf',
    'media'   => 'https://mywhatsapp.jca.ec/assets/pdf/vivir.pdf'
];

// Url - los datos para el POST
$fields_string = http_build_query($fields);

// Abriendo la conexión POST
$ch = curl_init();

// Establecer la URL, el número de variables POST, los datos POST
curl_setopt($ch,CURLOPT_URL, $url);
curl_setopt($ch,CURLOPT_POST, true);
curl_setopt($ch,CURLOPT_POSTFIELDS, $fields_string);

// De modo que curl_exec devuelve el contenido sin repetirlo
curl_setopt($ch,CURLOPT_RETURNTRANSFER, true); 

// Ejecutar la petición
$result = curl_exec($ch);

// Se muestra el resultado obtenido, erroneo / correcto
echo $result;

?>
