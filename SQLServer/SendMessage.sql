Alter Procedure [dbo].[SendWhatsApp] 
	(@Destination NVarChar(100), @Message NVarChar(Max), @MimeType NVarChar(Max) = '',
	 @Media NVarChar(Max) = '', @FileName NVarChar(Max) = '', @Token NVarChar(Max) = '', @TypeDest Char(1) = 'C')

As 
Begin
	-- Variables para SMSWhatsApp
	Declare @MsgContent 	NVarChar(Max);
	Declare @UrlApiRest 	NVarChar(Max);
	Declare @Phone_Group	NVarChar(Max);
	Declare @Registered		NVarChar(Max);

	-- Token de SMSWhatsApp (ID del Servicio) Si no se envía como parámetro, debe colocarselo en la siguiente línea
	If @Token = ''
		Set @Token = '[TOKEN SMSWHATAPP]';

	-- Validación del Contacto o Grupo, según sea el caso
	If @TypeDest = 'C'
		Begin
			Set @Phone_Group = Replace(Replace(Replace(RTrim(@Destination), ' ', ''), '-', ''), '+', '');
			Set @Registered  = dbo.httpGet('https://mywhatsapp.jca.ec:5433/contact/isregistereduser/' + @Phone_Group + '?number=' + @Token);
		End
	  Else
	    Begin
			Set @Phone_Group = @Destination;
			Set @Registered  = dbo.httpGet('https://mywhatsapp.jca.ec:5433/group/isregisteredgroup/' + @Phone_Group + '?number=' + @Token);
		End
	
	-- Se procederá a enviar el mensaje si pasa la validación previa del destinatario
	IF (@Registered LIKE '{"status":"success"%')
	Begin
		-- Envío de mensajes SIN adjuntos (solo textos)
		IF (@MimeType = '')
			Begin
				If @TypeDest = 'G'
					Set @UrlApiRest = 'http://mywhatsapp.jca.ec:5001/group/sendmessage/' + @Phone_Group + '?number=' + @Token;
				  Else
					Set @UrlApiRest = 'http://mywhatsapp.jca.ec:5001/chat/sendmessage/' + @Phone_Group + '?number=' + @Token;
				
				Set @MsgContent = '{
									"message":"' + @Message + '",
									"typing":"3",
									"nowait":"true"
									}';
			End
		  Else
		    -- Envío de mensajes CON adjuntos
			Begin
				If @TypeDest = 'G'
					Set @UrlApiRest = 'http://mywhatsapp.jca.ec:5001/group/sendmedia/' + @Phone_Group + '?number=' + @Token;
				Else
					Set @UrlApiRest = 'http://mywhatsapp.jca.ec:5001/chat/sendmedia/' + @Phone_Group + '?number=' + @Token;

				Set @MsgContent = '{
									"message": "' + @Message + '",
									"typing":"3",
									"nowait":"true",
									"type": "' + @MimeType + '",
									"media": "' + @Media + '",
									"title": "' + @FileName + '"
									}';
			End
		Exec webRequest @UrlApiRest, '', 'application/json', @MsgContent;
	End
End
