object FConfiguracao: TFConfiguracao
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Configura'#231#245'es para Apura'#231#227'o'
  ClientHeight = 562
  ClientWidth = 550
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
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 544
    Height = 206
    Align = alTop
    Caption = 'Configura'#231#245'es'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 26
      Width = 32
      Height = 19
      Caption = 'Ano'
    end
    object Label2: TLabel
      Left = 8
      Top = 82
      Width = 175
      Height = 19
      Caption = 'Al'#237'quota Isen'#231#227'o (%)'
    end
    object Label3: TLabel
      Left = 8
      Top = 138
      Width = 295
      Height = 19
      Caption = 'Valor Limite para Imposto de Renda'
    end
    object edtAno: TMaskEdit
      Left = 8
      Top = 51
      Width = 65
      Height = 27
      EditMask = '9999;1;_'
      MaxLength = 4
      TabOrder = 0
      Text = '    '
      OnExit = edtAnoExit
    end
    object edtAliquotaIsenta: TDPTNumberEditXE8
      Left = 8
      Top = 107
      Width = 65
      Height = 27
      Alignment = taLeftJustify
      Datatype = dtDouble
      Decimals = 2
      Digits = 6
      Max = 100.000000000000000000
      NegativeColor = clRed
      NumericType = ntNumber
      TabOnEnterKey = False
      TabOrder = 1
      Validate = False
      OnExit = edtAliquotaIsentaExit
    end
    object edtValorIRPF: TDPTNumberEditXE8
      Left = 8
      Top = 163
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
      TabOrder = 2
      Validate = True
    end
  end
  object btnFechar: TBitBtn
    Left = 368
    Top = 501
    Width = 176
    Height = 53
    Caption = 'Fechar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = btnFecharClick
  end
  object btnExcluir: TBitBtn
    Left = 187
    Top = 501
    Width = 175
    Height = 53
    Caption = 'Excluir'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = btnExcluirClick
  end
  object btnGravar: TBitBtn
    Left = 6
    Top = 501
    Width = 175
    Height = 53
    Caption = 'Gravar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = btnGravarClick
  end
  object dbConfiguracao: TDBGrid
    Left = 3
    Top = 215
    Width = 539
    Height = 280
    TabStop = False
    DataSource = DMPrincipal.DSConfiguracao
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -16
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = [fsBold]
    OnDblClick = dbConfiguracaoDblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'CONFIG_ANO'
        Title.Caption = 'Ano'
        Width = 58
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CONFIG_PORCENTAGEMISENTO'
        Title.Alignment = taRightJustify
        Title.Caption = 'Porcentagem de Isen'#231#227'o'
        Width = 213
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CONFIG_VALORDECLARARIR'
        Title.Alignment = taRightJustify
        Title.Caption = 'Valor Imposto de Renda'
        Width = 230
        Visible = True
      end>
  end
end
