object FDesligarPC: TFDesligarPC
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = '[0001] - Desligar Computador'
  ClientHeight = 150
  ClientWidth = 268
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 82
    Width = 262
    Height = 65
    Align = alBottom
    BevelInner = bvLowered
    TabOrder = 0
    object btnIniciar: TBitBtn
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 80
      Height = 55
      Align = alLeft
      Caption = 'Iniciar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = btnIniciarClick
    end
    object btnParar: TBitBtn
      AlignWithMargins = True
      Left = 91
      Top = 5
      Width = 80
      Height = 55
      Align = alLeft
      Caption = 'Parar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = btnPararClick
    end
    object btnSair: TBitBtn
      AlignWithMargins = True
      Left = 177
      Top = 5
      Width = 80
      Height = 55
      Align = alLeft
      Caption = 'Fechar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = btnSairClick
    end
  end
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 262
    Height = 73
    Align = alClient
    Caption = 'Configura'#231#245'es'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 20
      Width = 204
      Height = 14
      Caption = 'Hora Programada para DESLIGAR'
    end
    object edtHora: TMaskEdit
      Left = 16
      Top = 40
      Width = 57
      Height = 22
      EditMask = '!90:00;1;_'
      MaxLength = 5
      TabOrder = 0
      Text = '  :  '
      OnExit = edtHoraExit
    end
  end
  object TimerDesligar: TTimer
    Interval = 60000
    OnTimer = TimerDesligarTimer
    Left = 227
    Top = 43
  end
  object TrayIcon1: TTrayIcon
    Animate = True
    Hint = 
      'Desligamento Autom'#225'tico (Executando) - Clique com o bot'#227'o esquer' +
      'do do mouse para abrir.'
    BalloonHint = 'Inicializado'
    BalloonTitle = 'Desligamento autom'#225'tico do computador'
    BalloonTimeout = 5000
    BalloonFlags = bfInfo
    PopupMenu = PopupMenu1
    Visible = True
    OnDblClick = TrayIcon1DblClick
    Left = 168
    Top = 40
  end
  object ApplicationEvents1: TApplicationEvents
    OnMinimize = ApplicationEvents1Minimize
    Left = 96
    Top = 40
  end
  object PopupMenu1: TPopupMenu
    Left = 219
    Top = 98
    object Abrir1: TMenuItem
      Caption = 'Abrir'
      OnClick = Abrir1Click
    end
    object Minimizar1: TMenuItem
      Caption = 'Minimizar'
      OnClick = Minimizar1Click
    end
    object Fechar1: TMenuItem
      Caption = 'Fechar'
      OnClick = Fechar1Click
    end
  end
end
