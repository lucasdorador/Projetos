object FApuracao: TFApuracao
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Gera'#231#227'o de Apura'#231#245'es'
  ClientHeight = 153
  ClientWidth = 294
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pgcApuracao: TPageControl
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 288
    Height = 147
    ActivePage = ts_ApuracaoFechadas
    Align = alClient
    MultiLine = True
    TabOrder = 0
    TabPosition = tpBottom
    TabStop = False
    object ts_ApuracaoAnual: TTabSheet
      Caption = 'Apura'#231#227'o Anual'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox1: TGroupBox
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 274
        Height = 115
        Align = alClient
        Caption = 'Dados para Apura'#231#227'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object Label1: TLabel
          Left = 7
          Top = 27
          Width = 32
          Height = 19
          Caption = 'Ano'
        end
        object edtAno: TMaskEdit
          Left = 45
          Top = 24
          Width = 65
          Height = 27
          EditMask = '9999;1;_'
          MaxLength = 4
          TabOrder = 0
          Text = '    '
        end
        object btnApuracao: TBitBtn
          Left = 7
          Top = 57
          Width = 183
          Height = 53
          Caption = 'Gerar Apura'#231#227'o'
          TabOrder = 1
          OnClick = btnApuracaoClick
        end
        object btnFechar: TBitBtn
          Left = 196
          Top = 57
          Width = 75
          Height = 53
          Caption = 'Fechar'
          TabOrder = 2
          OnClick = btnFecharClick
        end
      end
    end
    object ts_ApuracaoFechadas: TTabSheet
      Caption = 'Apura'#231#245'es Fechadas'
      ImageIndex = 1
      object GroupBox2: TGroupBox
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 274
        Height = 115
        Align = alClient
        Caption = 'Apura'#231#245'es Fechadas'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object Label2: TLabel
          Left = 7
          Top = 27
          Width = 32
          Height = 19
          Caption = 'Ano'
        end
        object btnImprimir: TBitBtn
          Left = 7
          Top = 57
          Width = 183
          Height = 53
          Caption = 'Imprimir Apura'#231#227'o'
          TabOrder = 0
          OnClick = btnImprimirClick
        end
        object cbAno: TComboBox
          Left = 45
          Top = 24
          Width = 145
          Height = 27
          Style = csDropDownList
          TabOrder = 1
          Items.Strings = (
            ''
            '2017')
        end
        object btnFechar2: TBitBtn
          Left = 196
          Top = 57
          Width = 75
          Height = 53
          Caption = 'Fechar'
          TabOrder = 2
          OnClick = btnFecharClick
        end
      end
    end
  end
end
