*:-----------------------------------------------------------------------------------------------------------------:*
*: Nombre..........: VfpStretch
*: Objetivo........: AutoAjustar objetos dentro de un formulario de manera automática y proporcional
*: Propietario.....: Irwin Rodriguez - Venezuela / Toledo [España]
*: Documentador....: Jairo Cedeño Adrián - Ecuador [Manta]
*: Creación........: 15-Oct-2019
*: Actualización...: 12-Abr-2023 (Jairo Cedeño Adrián)
*:-----------------------------------------------------------------------------------------------------------------:*
Define Class VfpStretch As Custom
	nOriginalHeight		= 0
	nOriginalWidth		= 0
	oForm				= .Null.

	*: Carga incial - INIT de la clase
	Procedure Do (toThisForm As Object)
		With This
			.oForm = toThisForm

			If Type('.oForm') != 'O' Then
				Messagebox('¡Debe crear el objeto VfpStretch dentro de un formulario!', 48, 'Advertencia!')
				Return .F.
			EndIf

			With .oForm
				.MinHeight = .Height
				.MinWidth  = .Width
			
				This.nOriginalHeight = .Height
				This.nOriginalWidth  = .Width
			EndWith

			.SaveContainer(.oForm)
			BindEvent(.oForm, 'Resize', This, 'Stretch', 1)
		EndWith
	EndProc

	*: Restablece las dimensiones originales en Alto y Ancho del formulario
	Procedure ResetSize
		With This.oForm
			.Height = This.nOriginalHeight
			.Width  = This.nOriginalWidth
		EndWith
	EndProc

	*: 	
	Procedure SaveContainer(oContainer As Object)
		With This
			Local oThis 		As Object
			Local cBaseClass 	As String
			.SaveOriginalSize(m.oContainer)
			
			For Each m.oThis In m.oContainer.Controls
				m.cBaseClass = Lower(m.oThis.BaseClass)
			
				IF Upper(m.oThis.Tag) != 'NOSTRETCH' Then
					If !m.cBaseClass == 'custom' Then
						.SaveOriginalSize(m.oThis)
					EndIf

					If Type('m.oThis.Anchor') = 'N' And m.oThis.Anchor > 0 Then
						m.oThis.Anchor = 0
					EndIf

					m.cBaseClass = Lower(m.oThis.BaseClass)
					Do Case
						Case m.cBaseClass == 'container'
							.SaveContainer(m.oThis)
						Case m.cBaseClass == 'pageframe'
							Local oPage
							For Each oPage In m.oThis.Pages
								.SaveContainer(m.oPage)
							EndFor
						Case m.cBaseClass == 'grid'
							Local oColumn
							For Each oColumn In m.oThis.Columns
								.SaveOriginalSize(m.oColumn)
							EndFor
						Case m.cBaseClass $ 'commandgroup,optiongroup'
							Local oButton
							For Each oButton In m.oThis.Buttons
								.SaveOriginalSize(m.oButton)
							EndFor
					EndCase
				EndIf
			EndFor
		EndWith
	EndProc	

	*: Graba las dimensiones originales en los objetos
	Procedure SaveOriginalSize(oObject As Object)
		If PemStatus(m.oObject, 'Width', 5) Then
			If !PemStatus(m.oObject, '_nOriginalWidth', 5) Then
				AddProperty(m.oObject, '_nOriginalWidth', m.oObject.Width)
			EndIf

			If PemStatus(m.oObject, 'Height', 5) Then
				If !PemStatus(m.oObject, '_nOriginalHeight', 5) Then
					AddProperty(m.oObject, '_nOriginalHeight', m.oObject.Height)
				EndIf
				If !PemStatus(m.oObject, '_nOriginalLeft', 5) Then
					AddProperty(m.oObject, '_nOriginalLeft', m.oObject.Left)
				EndIf
				If !PemStatus(m.oObject, '_nOriginalTop', 5) Then
					AddProperty(m.oObject, '_nOriginalTop', m.oObject.Top)
				EndIf
			EndIf
		EndIf

		If PemStatus(m.oObject, 'Fontsize', 5) Then
			AddProperty(m.oObject, '_nOriginalFontsize', m.oObject.FontSize)
		EndIf

		If PemStatus(m.oObject, 'RowHeight', 5) Then
			AddProperty(m.oObject, '_nOriginalRowheight', m.oObject.RowHeight)
		EndIf
	EndProc

	*: Controla el area de expansión de los objetos auto-ajustando proporcionalmente
	Procedure Stretch(oContainer As Object)
		With This
			If Type('oContainer') != 'O' Then
				oContainer = .oForm
			EndIf

			Local oThis			As Object	
			Local cBaseClass 	As String
			m.cBaseClass = Lower(m.oContainer.BaseClass)
			
			If m.cBaseClass == 'form' Then
				m.oContainer.LockScreen = .T.
			  Else
				.AdjustSize(m.oContainer)
			EndIf

			For Each m.oThis In m.oContainer.Controls
				m.cBaseClass = Lower(m.oThis.BaseClass)
				If !m.cBaseClass == 'custom' Then
					.AdjustSize(m.oThis)
				EndIf
				Do Case
					Case m.cBaseClass == 'container'
						.Stretch(m.oThis)
					Case m.cBaseClass == 'pageframe'
						Local oPage
						For Each oPage In m.oThis.Pages
							.Stretch(m.oPage)
						EndFor
					Case m.cBaseClass == 'grid'
						Local oColumn
						For Each oColumn In m.oThis.Columns
							.AdjustSize(m.oColumn)
						EndFor
					Case m.cBaseClass $ 'commandgroup,optiongroup'
						Local oButton
						For Each oButton In m.oThis.Buttons
							.AdjustSize(m.oButton)
						EndFor
				EndCase
			EndFor
			
			If Lower(m.oContainer.BaseClass) == 'form' Then
				m.oContainer.LockScreen = .F.
			EndIf
		EndWith
	EndProc

	*: Auto-Ajustar el tamaño del formulario
	Procedure AdjustSize(oObject As Object)
		Local nHeightRatio, nWidthRatio
		With This
			m.nHeightRatio 	= .oForm.Height / .nOriginalHeight
			m.nWidthRatio 	= .oForm.Width  / .nOriginalWidth
		EndWith

		With m.oObject
			If PemStatus(m.oObject, '_nOriginalWidth', 5) Then
				.Width  = ._nOriginalWidth * m.nWidthRatio
				If PemStatus(m.oObject, '_nOriginalHeight', 5) Then
					.Height = ._nOriginalHeight * m.nHeightRatio
					.Top    = ._nOriginalTop    * m.nHeightRatio
					.Left   = ._nOriginalLeft   * m.nWidthRatio
				EndIf
			EndIf

			If PemStatus(m.oObject, '_nOriginalFontsize', 5) Then
				.FontSize = Max(4, Round(._nOriginalFontsize * ;
					Iif(Abs(m.nHeightRatio) < Abs(m.nWidthRatio), m.nHeightRatio, m.nWidthRatio), 0))
			EndIf

			If PemStatus(m.oObject, '_nOriginalRowheight', 5) Then
				.RowHeight = ._nOriginalRowheight * m.nHeightRatio
			EndIf

			If .BaseClass == 'Control' And PemStatus(m.oObject, 'RepositionContents', 5) Then
				.RepositionContents()
			EndIf
		EndWith
	EndProc	
EndDefine
