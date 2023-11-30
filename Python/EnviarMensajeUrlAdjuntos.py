import requests
import json

# Aquí va el código, el resto es solo colocar las URLS correspondientes
# Si tiene licencia del Servicio SMSWhatsApp por favor solicitar por correo sus urls

# La URL a la que desea enviar la solicitud POST, ponerla aquí
# 593984958499 representa el NÚMERO DESTINO
# Phone03 es el identificador del cliente, para éste caso es la DEMO
url = 'http://mywhatsapp.jca.ec:5001/chat/sendmedia/593984958499?number=Phone03'

# Los datos que desea enviar a través de POST, ver los parámetros que requiere según sea el caso 
# Los datos son enviados en una estructura json
fields = {
    'caption': 'Hola Mundo, estamos usando el Servicio SMSWhatsApp, gracias por su preferencia',
    'typing': '3',
    'nowait': 'true',
    'type': 'application/pdf',
    'title': 'Factura.pdf',
    'media' : 'https://mywhatsapp.jca.ec/assets/pdf/vivir.pdf'
}

# Convertir los datos a formato json
json_data = json.dumps(fields)

# Establecer los headers para la petición POST
headers = {'Content-type': 'application/json'}

# Realizar la petición POST
response = requests.post(url, data=json_data, headers=headers)

# Mostrar el resultado obtenido, erroneo / correcto
print(response.text)
