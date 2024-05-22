*: Script modelo para enviar mensajes a WhatsApp usando apiRest con Visual FoxPro
*: Queda a control y criterio de quienes lo usen con sus licencias.
*: Aplicar las validaciones respectivamente y control de errores.

*: Aquí va el código, el resto es solo colocar las URLS correspondientes
*: Si tiene licencia del Servicio SMSWhatsApp por favor solicitar por correo sus urls

*: La URL a la que desea enviar la solicitud POST, ponerla aquí
*: 593984958499 representa el NÚMERO DESTINO
*: Phone03 es el identificador del cliente, para éste caso es la DEMO

cUrlApi = 'https://mywhatsapp.jca.ec:5433/chat/sendmedia/'
cDestino= '593984958499'
cToken  = 'Phone03'
cUrlPost= cUrlApi + cDestino + '?number=' + cToken 


*: NOTA: Recomendamos USAR simulación de escritura, adicionando 2 campos
*:       (nowait -> true / false | typing -> Segundos), muestro a continuación:
*: si se usa nowait -> false el sistema esperará hasta que se envié respuesta del envío con ID del mensaje enviado
*: PARÁMETROS:
*: 		caption: Es el texto que va al pie de la imágen
*:      type   : Es el tipo de adjunto, es importante conocer en mime type dependiendo de lo que desea adjuntar
*:      title  : se coloca el nombre del archivo y la extensión respectiva, OJO considerar el type
*:      media  : su contenido debe ir enviado en base64
*:      message: UNICAMENTE se usa en reemplazo de caption cuando se desea el texto separado del adjunto

Text To cBodyJson TextMerge NoShow Pretext 15
	{
	    "caption": "Este es un mensaje usando apiRest desde Visual FoxPro con SMSWhatsApp",
	    "nowait" : "true",
	    "typing" : "2",
	    "type"   : "application/pdf",
	    "title"  : "Factura.pdf",
	    "media"  : "<<Strconv(FileToStr('C:\Users\Desarrollo\Downloads\Documentos\Factura.pdf'),13)>>"
	}
EndText
oWS  = CreateObject('WinHTTP.WinHTTPRequest.5.1')
ows.Open('POST', cUrlPost, .F.)
oWS.SetRequestHeader('Content-Type', 'application/json')
oWS.Send(cBodyJson)
MessageBox(oWS.ResponseText)
