object Fprincipal: TFprincipal
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Declara'#231#227'o de DIRPF - Lan'#231'amento de Despesas e Faturamento'
  ClientHeight = 309
  ClientWidth = 645
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 13
  object MainMenu1: TMainMenu
    Left = 272
    Top = 168
    object Lanamentos1: TMenuItem
      Caption = 'Lan'#231'amentos'
      object Despesas1: TMenuItem
        Caption = 'Despesas'
        OnClick = Despesas1Click
      end
      object Faturamento1: TMenuItem
        Caption = 'Faturamento'
        OnClick = Faturamento1Click
      end
    end
    object Apuraa1: TMenuItem
      Caption = 'Apura'#231#245'es'
      object LanarApuraes1: TMenuItem
        Caption = 'Lan'#231'ar Apura'#231#245'es'
      end
    end
    object Sair1: TMenuItem
      Caption = 'Sair'
      OnClick = Sair1Click
    end
  end
  object ActionList1: TActionList
    Left = 416
    Top = 64
  end
end
