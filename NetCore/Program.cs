// Aquí va el código, el resto es solo colocar las URLS correspondientes
// Si tiene licencia del Servicio SMSWhatsApp por favor solicitar por correo sus urls
// Puede eliminar o quitar lo que desee, el resto ya es carpintería de cada programador

// La URL a la que desea enviar la solicitud POST, ponerla aquí
// 593984958499 representa el NÚMERO DESTINO, debe ser puesto en formato internacional
// Phone03 es el identificador del cliente, para éste caso en la DEMO es Phone03
// typing es simulación de escritura y se le coloca la cantidad de segundos
// nowait se le colocar true o false   true NO espera respuesta y false si lo hace

using System;
using System.Collections.Generic;
using System.IO;
using System.Net.Http;
using System.Text;

namespace EjemploWhatsApp
{
    class Program
    {
        static void Main(string[] args)
        {
			// Llama a función asincrona psot()	
            post();
			
			// Hace una pausa dramática mientras espera el resultado.
            Console.ReadKey(); 
        }

        static async void post()
        {
            // Leer un archivo y pasarlo a un vector de bytes (Byte[]). 
            Byte[] bytes = File.ReadAllBytes("C:/Users/miusuario/Imágenes/Envía mensajes de Whatsapp.png");
            
            // Convierte el vector de bytes a base64 y lo guarda en variable de tipo String.
            String fileBase64 = Convert.ToBase64String(bytes);

            // Crea un objeto con la estructura para el body que se enviará en el Post Request al servidor SMSWhatsApp
            var body = new
            {
                message = "Bienvenido a MyWhatsApp", // Mensaje de WhatsApp
                typing = "3"
                nowait = "true"
                type = "image/png", // MimeType correspondiente al archivo leído
                media = fileBase64 // Contiene un archivo que en formato base64
            };

            // Crea un nuevo cliente de HTTP conection
            using (HttpClient client = new HttpClient())
            {
                try
                {
                    // Realiza una solicitud POST al url de MyWhatsApp.jca.ec 
                    var r = await client.PostAsync(
                        "http://mywhatsapp.jca.ec:5001/chat/sendmedia/593984958499?number=Phone03",
                        new StringContent(
                            Newtonsoft.Json.JsonConvert.SerializeObject(body),  // Convierte en String objeto body
                            Encoding.UTF8, // Se usará el Encode UTF8 para el request
                            "application/json" // Tipo de datos manejado en el request
                        ));
                    
					// Lee la respuesta del servidor en formato String
                    Console.WriteLine(await r.Content.ReadAsStringAsync() 
                    );
                }
                catch (Exception e)
                {
                    Console.WriteLine(e);
                }
            }
        }
    }
}
