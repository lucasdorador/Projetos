object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 373
  ClientWidth = 818
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 49
    Width = 818
    Height = 324
    Align = alClient
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 818
    Height = 49
    Align = alTop
    TabOrder = 1
    object Edit1: TEdit
      Left = 8
      Top = 12
      Width = 465
      Height = 21
      TabOrder = 0
      Text = 'Edit1'
    end
    object BitBtn1: TBitBtn
      Left = 479
      Top = 10
      Width = 34
      Height = 25
      Caption = '...'
      TabOrder = 1
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 519
      Top = 10
      Width = 114
      Height = 25
      Caption = 'Executar'
      TabOrder = 2
      OnClick = BitBtn2Click
    end
    object BitBtn3: TBitBtn
      Left = 639
      Top = 10
      Width = 75
      Height = 25
      Caption = 'Procurar'
      TabOrder = 3
      OnClick = BitBtn3Click
    end
  end
  object OpenTextFileDialog1: TOpenTextFileDialog
    Filter = 'Delphi Source File|*.pas'
    InitialDir = 'C:\'
    Options = [ofHideReadOnly, ofAllowMultiSelect, ofEnableSizing, ofForceShowHidden]
    Left = 408
    Top = 128
  end
end
