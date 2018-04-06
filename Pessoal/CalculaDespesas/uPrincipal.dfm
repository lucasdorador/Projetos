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
  object ActionToolBar1: TActionToolBar
    Left = 0
    Top = 0
    Width = 645
    Height = 23
    ActionManager = ActionManager1
    Caption = 'Atalhos'
    Color = clMenuBar
    ColorMap.DisabledFontColor = 7171437
    ColorMap.HighlightColor = clWhite
    ColorMap.BtnSelectedFont = clBlack
    ColorMap.UnusedColor = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Spacing = 0
  end
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
      object FecharApuracao1: TMenuItem
        Caption = 'Fechar Apura'#231#227'o Anual'
        OnClick = FecharApuracao1Click
      end
      object ApuraesFinalizadas1: TMenuItem
        Caption = 'Apura'#231#245'es Finalizadas'
        OnClick = ApuraesFinalizadas1Click
      end
    end
    object Sair1: TMenuItem
      Caption = 'Sair'
      OnClick = Sair1Click
    end
  end
  object ActionManager1: TActionManager
    ActionBars = <
      item
        Items = <
          item
            Action = act_Despesas
            Caption = '&Despesas'
          end
          item
            Action = act_Faturamento
            Caption = '&Faturamento'
          end
          item
            Action = act_ApuraAnual
            Caption = '&Apura'#231#227'o Anual'
          end
          item
            Action = act_ApurFechadas
            Caption = 'A&pura'#231#245'es Fechadas'
          end
          item
            Action = act_Sair
            Caption = '&Sair'
          end>
        ActionBar = ActionToolBar1
      end>
    Images = ImageList1
    Left = 352
    Top = 168
    StyleName = 'Platform Default'
    object act_Despesas: TAction
      Caption = 'Despesas'
      OnExecute = act_DespesasExecute
    end
    object act_Faturamento: TAction
      Caption = 'Faturamento'
      OnExecute = act_FaturamentoExecute
    end
    object act_ApuraAnual: TAction
      Caption = 'Apura'#231#227'o Anual'
      OnExecute = act_ApuraAnualExecute
    end
    object act_Sair: TAction
      Caption = 'Sair'
      OnExecute = act_SairExecute
    end
    object act_ApurFechadas: TAction
      Caption = 'Apura'#231#245'es Fechadas'
      OnExecute = act_ApurFechadasExecute
    end
  end
  object ImageList1: TImageList
    Left = 432
    Top = 168
  end
end
