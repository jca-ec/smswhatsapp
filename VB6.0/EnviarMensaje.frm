VERSION 5.00
Begin VB.Form EnviarMensaje 
   Caption         =   "Envíos de Mensajes - SMSWhatsApp"
   ClientHeight    =   3705
   ClientLeft      =   120
   ClientTop       =   465
   ClientWidth     =   6945
   Icon            =   "EnviarMensaje.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3705
   ScaleWidth      =   6945
   StartUpPosition =   2  'CenterScreen
   Begin VB.CheckBox chkToken 
      Caption         =   "Token"
      Enabled         =   0   'False
      Height          =   375
      Left            =   5520
      TabIndex        =   6
      Top             =   3120
      Width           =   1215
   End
   Begin VB.CheckBox chkLicencia 
      Caption         =   "Licencia"
      Enabled         =   0   'False
      Height          =   375
      Left            =   3960
      TabIndex        =   5
      Top             =   3120
      Width           =   1095
   End
   Begin VB.CommandButton cmdEnviar 
      Caption         =   "Enviar"
      Height          =   495
      Left            =   1440
      TabIndex        =   4
      Top             =   3120
      Width           =   1215
   End
   Begin VB.TextBox txtMensaje 
      Height          =   2295
      Left            =   1440
      TabIndex        =   3
      Text            =   "Prueba desde VB6, hecho a la medida con la DLL de SMSWhatsApp"
      Top             =   720
      Width           =   5295
   End
   Begin VB.TextBox txtDestinatario 
      Height          =   375
      Left            =   1440
      TabIndex        =   2
      Text            =   "593984958499"
      Top             =   240
      Width           =   5295
   End
   Begin VB.Label lblMensaje 
      AutoSize        =   -1  'True
      Caption         =   "Mensaje:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Left            =   360
      TabIndex        =   1
      Top             =   720
      Width           =   780
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      Caption         =   "# Destinatario:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Left            =   120
      TabIndex        =   0
      Top             =   360
      Width           =   1275
   End
End
Attribute VB_Name = "EnviarMensaje"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim oWS As New smswhatsapp.ApiWhatsApp

Private Sub cmdEnviar_Click()
    Call MsgBox(oWS.SendSMSWhatsApp(Me.txtDestinatario.Text, Me.txtMensaje.Text, "", "", False, False, ""), vbInformation)
End Sub

Private Sub Form_Load()
    Me.chkLicencia.Value = InStr(oWS.LoadLicense("D:\RutaDondeEstaGuardado\SMSWhatsApp.cfg"), "OK")
    Me.chkToken.Value = InStr(oWS.ValidateClient("CadenaTockenLicenciaPagada"), "OK")
End Sub
