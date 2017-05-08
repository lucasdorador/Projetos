object FProcessa: TFProcessa
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'FProcessa'
  ClientHeight = 43
  ClientWidth = 800
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 800
    Height = 43
    Align = alClient
    Caption = 'Processando ...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object Gauge1: TGauge
      Left = 2
      Top = 18
      Width = 796
      Height = 23
      Align = alClient
      Progress = 0
      ExplicitLeft = 120
      ExplicitTop = 120
      ExplicitWidth = 100
      ExplicitHeight = 100
    end
  end
end
