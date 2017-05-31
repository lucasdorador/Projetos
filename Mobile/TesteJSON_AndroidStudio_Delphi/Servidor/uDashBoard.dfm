object Form1: TForm1
  Left = 271
  Top = 114
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'DashBoard '
  ClientHeight = 361
  ClientWidth = 657
  Color = clWindowText
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 48
    Width = 20
    Height = 13
    Caption = 'Port'
  end
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 207
    Width = 651
    Height = 74
    Align = alTop
    Caption = 'IP e Porta de Conex'#227'o'
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentColor = False
    ParentFont = False
    TabOrder = 3
    ExplicitWidth = 657
    object EditPort: TEdit
      Left = 183
      Top = 16
      Width = 127
      Height = 25
      AutoSize = False
      TabOrder = 0
      Text = '9999'
    end
    object MemoIP: TMemo
      Left = 7
      Top = 16
      Width = 170
      Height = 49
      Lines.Strings = (
        'MemoIP')
      TabOrder = 1
    end
  end
  object Memo1: TMemo
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 651
    Height = 198
    Align = alTop
    Color = clBackground
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clLime
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    Lines.Strings = (
      'Memo1')
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 2
    ExplicitWidth = 657
  end
  object ButtonStart: TButton
    Left = 102
    Top = 287
    Width = 150
    Height = 70
    Caption = 'Iniciar Servidor'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = ButtonStartClick
  end
  object ButtonStop: TButton
    Left = 258
    Top = 287
    Width = 150
    Height = 70
    Caption = 'Parar Servidor'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = ButtonStopClick
  end
  object Button1: TButton
    Left = 414
    Top = 287
    Width = 150
    Height = 70
    Caption = 'Fechar Aplica'#231#227'o'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = Button1Click
  end
  object ApplicationEvents1: TApplicationEvents
    OnIdle = ApplicationEvents1Idle
    OnMinimize = ApplicationEvents1Minimize
    Left = 528
    Top = 216
  end
  object TrayIcon1: TTrayIcon
    OnDblClick = TrayIcon1DblClick
    Left = 419
    Top = 215
  end
end
