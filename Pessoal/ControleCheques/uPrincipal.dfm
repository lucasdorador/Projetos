object FPrincipal: TFPrincipal
  AlignWithMargins = True
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = '[DF Sistemas] - Controle Banc'#225'rio'
  ClientHeight = 390
  ClientWidth = 638
  Color = clBtnFace
  DefaultMonitor = dmDesktop
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 371
    Width = 638
    Height = 19
    Panels = <
      item
        Text = 'Usu'#225'rio'
        Width = 50
      end
      item
        Width = 50
      end
      item
        Width = 50
      end>
  end
  object MainMenu1: TMainMenu
    Left = 168
    Top = 104
    object Cadastros1: TMenuItem
      Caption = 'Cadastros'
      object Bancos1: TMenuItem
        Caption = 'Bancos'
        OnClick = Bancos1Click
      end
      object ContaCorrente1: TMenuItem
        Caption = 'Conta Corrente'
        OnClick = ContaCorrente1Click
      end
    end
    object Lanamentos1: TMenuItem
      Caption = 'Financeiro'
      object ControledeCheques1: TMenuItem
        Caption = 'Controle de Cheques'
        OnClick = ControledeCheques1Click
      end
      object ControleBancrio1: TMenuItem
        Caption = 'Controle Banc'#225'rio'
      end
    end
    object Relatrios1: TMenuItem
      Caption = 'Relat'#243'rios'
      object Cheques1: TMenuItem
        Caption = 'Cheques'
        object ChequesaVencer1: TMenuItem
          Caption = 'Cheques a Vencer'
        end
        object ChequesResumido1: TMenuItem
          Caption = 'Cheques Resumido'
        end
        object ChequesDetalhados1: TMenuItem
          Caption = 'Cheques Detalhados'
        end
      end
    end
    object Sair1: TMenuItem
      Caption = 'Sair'
      OnClick = Sair1Click
    end
  end
end
