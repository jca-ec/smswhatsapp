*: Script modelo para enviar mensajes a WhatsApp usando apiRest con Visual FoxPro
*: Queda a control y criterio de quienes lo usen con sus licencias.
*: Aplicar las validaciones respectivamente y control de errores.

*: Aqu� va el c�digo, el resto es solo colocar las URLS correspondientes
*: Si tiene licencia del Servicio SMSWhatsApp por favor solicitar por correo sus urls

*: La URL a la que desea enviar la solicitud POST, ponerla aqu�
*: 593984958499 representa el N�MERO DESTINO
*: Phone03 es el identificador del cliente, para �ste caso es la DEMO

cUrlApi = 'https://mywhatsapp.jca.ec:5433/chat/sendmessage/'
cDestino= '593984958499'
cToken  = 'Phone03'
cUrlPost= cUrlApi + cDestino + '?number=' + cToken 


*: NOTA: Recomendamos USAR simulaci�n de escritura, adicionando 2 campos
*:       (nowait -> true / false | typing -> Segundos), muestro a continuaci�n:
*: si se usa nowait -> false el sistema esperar� hasta que se envi� respuesta del env�o con ID del mensaje enviado

Text To cBodyJson TextMerge NoShow Pretext 15
	{
	    "message": "Este es un mensaje usando apiRest desde Visual FoxPro con SMSWhatsApp",
	    "nowait" : "true",
	    "typing" : "2"
	}
EndText
oWS  = CreateObject('WinHTTP.WinHTTPRequest.5.1')
ows.Open('POST', cUrlPost, .F.)
oWS.SetRequestHeader('Content-Type', 'application/json')
oWS.Send(cBodyJson)
MessageBox(oWS.ResponseText)
