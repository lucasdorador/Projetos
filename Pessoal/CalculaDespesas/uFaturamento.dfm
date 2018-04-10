object FFaturamento: TFFaturamento
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Lan'#231'amento de Faturamento Anual'
  ClientHeight = 454
  ClientWidth = 662
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
    Width = 656
    Height = 70
    Align = alTop
    Caption = 'Faturamento Anual'
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
    object Label2: TLabel
      Left = 127
      Top = 32
      Width = 43
      Height = 19
      Caption = 'Valor'
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
      OnExit = edtAnoExit
    end
    object edtValor: TDPTNumberEditXE8
      Left = 176
      Top = 29
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
    object btnGravar: TBitBtn
      Left = 331
      Top = 13
      Width = 102
      Height = 53
      Caption = 'Gravar'
      TabOrder = 2
      OnClick = btnGravarClick
    end
    object btnExcluir: TBitBtn
      Left = 439
      Top = 13
      Width = 102
      Height = 53
      Caption = 'Excluir'
      TabOrder = 3
      OnClick = btnExcluirClick
    end
    object btnFechar: TBitBtn
      Left = 547
      Top = 13
      Width = 102
      Height = 53
      Caption = 'Fechar'
      TabOrder = 4
      OnClick = btnFecharClick
    end
  end
  object dbgFaturamento: TDBGrid
    AlignWithMargins = True
    Left = 3
    Top = 79
    Width = 656
    Height = 372
    TabStop = False
    Align = alClient
    DataSource = DMPrincipal.DSFaturamento
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -16
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = [fsBold]
    OnDblClick = dbgFaturamentoDblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'FAT_ANO'
        Title.Caption = 'Ano'
        Width = 84
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FAT_VALOR'
        Title.Alignment = taRightJustify
        Title.Caption = 'Faturamento'
        Width = 530
        Visible = True
      end>
  end
end
