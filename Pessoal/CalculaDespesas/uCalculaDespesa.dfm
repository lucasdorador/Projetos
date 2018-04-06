object FCalculaDespesa: TFCalculaDespesa
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'C'#225'lculo de Despesas para DIRPF para MEI'
  ClientHeight = 569
  ClientWidth = 697
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
  object gbAnoBase: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 691
    Height = 70
    Align = alTop
    Caption = 'Ano Base para c'#225'lculos'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 7
      Top = 32
      Width = 32
      Height = 19
      Caption = 'Ano'
    end
    object edtAno: TMaskEdit
      Left = 45
      Top = 29
      Width = 65
      Height = 27
      EditMask = '9999;1;_'
      MaxLength = 4
      TabOrder = 0
      Text = '    '
      OnChange = edtAnoChange
      OnEnter = edtAnoEnter
      OnExit = edtAnoExit
    end
  end
  object gbDespesas: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 79
    Width = 691
    Height = 487
    Align = alClient
    Caption = 'Despesas'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object Label2: TLabel
      Left = 7
      Top = 29
      Width = 176
      Height = 19
      Caption = 'Descri'#231#227'o da Despesa'
    end
    object Label3: TLabel
      Left = 505
      Top = 29
      Width = 43
      Height = 19
      Caption = 'Valor'
    end
    object Label4: TLabel
      Left = 505
      Top = 432
      Width = 149
      Height = 19
      Caption = 'Total de Despesas'
    end
    object edtDescricao: TEdit
      Left = 7
      Top = 54
      Width = 494
      Height = 27
      TabOrder = 0
    end
    object edtValor: TDPTNumberEditXE8
      Left = 505
      Top = 54
      Width = 149
      Height = 27
      Alignment = taLeftJustify
      Datatype = dtDouble
      Decimals = 2
      Digits = 12
      Max = 99999999999.000000000000000000
      NegativeColor = clRed
      NumericType = ntNumber
      TabOnEnterKey = False
      TabOrder = 1
      Validate = True
    end
    object dbgDespesas: TDBGrid
      Left = 7
      Top = 87
      Width = 674
      Height = 339
      TabStop = False
      DataSource = DMPrincipal.DSDespesas
      Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      ReadOnly = True
      TabOrder = 2
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -16
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = [fsBold]
      OnDblClick = dbgDespesasDblClick
      Columns = <
        item
          Expanded = False
          FieldName = 'DESP_DESCRICAO'
          Title.Caption = 'Descri'#231#227'o'
          Width = 480
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DESP_VALOR'
          Title.Alignment = taRightJustify
          Title.Caption = 'Valor R$'
          Width = 154
          Visible = True
        end>
    end
    object pTotal: TPanel
      Left = 505
      Top = 453
      Width = 149
      Height = 28
      Alignment = taRightJustify
      Caption = '0,00'
      TabOrder = 3
    end
    object btnGravar: TBitBtn
      Left = 7
      Top = 432
      Width = 114
      Height = 52
      Caption = 'Gravar'
      TabOrder = 4
      OnClick = btnGravarClick
    end
    object btnExcluir: TBitBtn
      Left = 127
      Top = 432
      Width = 114
      Height = 52
      Caption = 'Excluir'
      TabOrder = 5
      OnClick = btnExcluirClick
    end
  end
  object btnFechar: TBitBtn
    Left = 250
    Top = 511
    Width = 114
    Height = 52
    Caption = 'Fechar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = btnFecharClick
  end
end
