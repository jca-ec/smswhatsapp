<?php
// Aquí va el código, el resto es solo colocar las URLS correspondientes
// Si tiene licencia del Servicio SMSWhatsApp por favor solicitar por correo sus urls

// La URL a la que desea enviar la solicitud POST, ponerla aquí
$url = 'AquiColocarLaURLCorrespondienteAlClienteConLicenciaSMSWhatsApp';

// Los datos que desea enviar a través de POST, ver los parámetros que requiere según sea el caso 
// Los datos son enviados en una estructura json
$fields = [
    'message' => 'Hola Mundo, estamos usando el Servicio SMSWhatsApp, gracias por su preferencia',
    'typing'  => '3',
    'nowait'  => 'true'
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