object Fprincipal: TFprincipal
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Leitor de Script'
  ClientHeight = 226
  ClientWidth = 489
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object MainMenu1: TMainMenu
    Left = 208
    Top = 128
    object Script1: TMenuItem
      Caption = 'Script'
      object Executar1: TMenuItem
        Caption = 'Executar'
        ShortCut = 114
        OnClick = Executar1Click
      end
      object Gerar1: TMenuItem
        Caption = 'Gerar'
      end
    end
  end
end
