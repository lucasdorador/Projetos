object FLancamentoOS: TFLancamentoOS
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = '[0000] Horas Trabalhadas - Lan'#231'amento de O.S'
  ClientHeight = 659
  ClientWidth = 814
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
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object gbOS: TGroupBox
    Left = 8
    Top = 8
    Width = 796
    Height = 121
    Caption = 'Dados da Ordem de Servi'#231'o'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 10
      Top = 21
      Width = 74
      Height = 16
      Caption = 'N'#250'mero O.S'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 98
      Top = 21
      Width = 39
      Height = 16
      Caption = 'Sprint'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 169
      Top = 21
      Width = 44
      Height = 16
      Caption = 'Cliente'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 10
      Top = 66
      Width = 72
      Height = 16
      Caption = 'Data Inicial'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 214
      Top = 66
      Width = 63
      Height = 16
      Caption = 'Data Final'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label6: TLabel
      Left = 112
      Top = 66
      Width = 72
      Height = 16
      Caption = 'Hora Inicial'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label7: TLabel
      Left = 316
      Top = 66
      Width = 63
      Height = 16
      Caption = 'Hora Final'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label8: TLabel
      Left = 418
      Top = 66
      Width = 94
      Height = 16
      Caption = 'Hora Proposta'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtOS: TMaskEdit
      Left = 10
      Top = 38
      Width = 68
      Height = 24
      EditMask = '!999999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 6
      ParentFont = False
      TabOrder = 0
      Text = '      '
      OnEnter = edtOSEnter
      OnExit = edtOSExit
    end
    object edtSprint: TMaskEdit
      Left = 98
      Top = 38
      Width = 51
      Height = 24
      EditMask = '!999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 3
      ParentFont = False
      TabOrder = 1
      Text = '   '
      OnExit = edtSprintExit
    end
    object edtCliente: TMaskEdit
      Left = 169
      Top = 38
      Width = 606
      Height = 24
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Text = ''
      OnKeyDown = edtClienteKeyDown
    end
    object edtDataInicial: TMaskEdit
      Left = 10
      Top = 84
      Width = 91
      Height = 24
      EditMask = '!99/99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      TabOrder = 3
      Text = '  /  /    '
      OnExit = edtDataInicialExit
      OnKeyDown = edtDataInicialKeyDown
    end
    object edtDataFinal: TMaskEdit
      Left = 214
      Top = 84
      Width = 92
      Height = 24
      EditMask = '!99/99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      TabOrder = 5
      Text = '  /  /    '
      OnExit = edtDataFinalExit
      OnKeyDown = edtDataFinalKeyDown
    end
    object edtHoraInicial: TMaskEdit
      Left = 112
      Top = 84
      Width = 93
      Height = 24
      EditMask = '!99:99;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 5
      ParentFont = False
      TabOrder = 4
      Text = '  :  '
      OnExit = edtHoraInicialExit
      OnKeyDown = edtHoraInicialKeyDown
    end
    object edtHoraProposta: TMaskEdit
      Left = 418
      Top = 84
      Width = 92
      Height = 24
      EditMask = '!99:99;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 5
      ParentFont = False
      TabOrder = 7
      Text = '  :  '
    end
    object edtHoraFinal: TMaskEdit
      Left = 316
      Top = 84
      Width = 95
      Height = 24
      EditMask = '!99:99;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 5
      ParentFont = False
      TabOrder = 6
      Text = '  :  '
      OnExit = edtHoraFinalExit
      OnKeyDown = edtHoraFinalKeyDown
    end
    object btnGravarOS: TBitBtn
      Left = 528
      Top = 68
      Width = 75
      Height = 40
      Caption = 'Ok'
      TabOrder = 8
      OnClick = btnGravarOSClick
    end
    object btnExcluirOS: TBitBtn
      Left = 609
      Top = 68
      Width = 75
      Height = 40
      Caption = 'Excluir'
      TabOrder = 9
      OnClick = btnExcluirOSClick
    end
  end
  object gbDiario: TGroupBox
    Left = 8
    Top = 135
    Width = 796
    Height = 90
    Caption = 'Dados Di'#225'rios'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object Label9: TLabel
      Left = 10
      Top = 26
      Width = 107
      Height = 16
      Caption = 'Data Trabalhada'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label10: TLabel
      Left = 123
      Top = 26
      Width = 100
      Height = 16
      Caption = 'Hora Dispon'#237'vel'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label11: TLabel
      Left = 240
      Top = 28
      Width = 84
      Height = 16
      Caption = 'Hora Perdida'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label12: TLabel
      Left = 360
      Top = 28
      Width = 107
      Height = 16
      Caption = 'Hora Trabalhada'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtDataTrabalhada: TMaskEdit
      Left = 10
      Top = 44
      Width = 91
      Height = 24
      EditMask = '!99/99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      TabOrder = 0
      Text = '  /  /    '
      OnExit = edtDataTrabalhadaExit
      OnKeyDown = edtDataTrabalhadaKeyDown
    end
    object edtHoraDisponivel: TMaskEdit
      Left = 123
      Top = 44
      Width = 93
      Height = 24
      EditMask = '!99:99;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 5
      ParentFont = False
      TabOrder = 1
      Text = '  :  '
    end
    object edtHoraPerdida: TMaskEdit
      Left = 240
      Top = 44
      Width = 93
      Height = 24
      EditMask = '!99:99;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 5
      ParentFont = False
      TabOrder = 2
      Text = '  :  '
      OnExit = edtHoraPerdidaExit
    end
    object pHorasTrabalhadas: TPanel
      Left = 360
      Top = 44
      Width = 107
      Height = 24
      Alignment = taRightJustify
      Caption = '0:00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object btnGravarDadosDiarios: TBitBtn
      Left = 486
      Top = 28
      Width = 75
      Height = 40
      Caption = 'Ok'
      TabOrder = 4
      OnClick = btnGravarDadosDiariosClick
    end
    object btnExcluirDadosDiarios: TBitBtn
      Left = 567
      Top = 28
      Width = 75
      Height = 40
      Caption = 'Excluir'
      TabOrder = 5
      OnClick = btnExcluirDadosDiariosClick
    end
  end
  object dbDiario: TDBGrid
    Left = 8
    Top = 231
    Width = 796
    Height = 322
    DataSource = DMPrincipal.dsLancamento_Diario
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ParentFont = False
    ReadOnly = True
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = [fsBold]
    OnCellClick = dbDiarioCellClick
    OnDblClick = dbDiarioDblClick
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'DATATRABALHADA'
        Title.Alignment = taCenter
        Title.Caption = 'Data Trabalhada'
        Width = 120
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'HORADISPONIVEL'
        Title.Alignment = taRightJustify
        Title.Caption = 'Horas Dispon'#237'vel'
        Width = 150
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'HORAPERDIDA'
        Title.Alignment = taRightJustify
        Title.Caption = 'Horas Perdidas'
        Width = 150
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'HORATRABALHADA'
        Title.Alignment = taRightJustify
        Title.Caption = 'Horas Trabalhadas'
        Width = 150
        Visible = True
      end>
  end
  object gbTotalizador: TGroupBox
    Left = 8
    Top = 559
    Width = 796
    Height = 82
    Caption = 'Totalizador de Horas'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    object Label13: TLabel
      Left = 58
      Top = 23
      Width = 59
      Height = 16
      Caption = 'Proposta'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label14: TLabel
      Left = 158
      Top = 23
      Width = 72
      Height = 16
      Caption = 'Trabalhada'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label15: TLabel
      Left = 308
      Top = 23
      Width = 35
      Height = 16
      Caption = 'Saldo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object pTotal_Proposta: TPanel
      Left = 10
      Top = 39
      Width = 107
      Height = 24
      Alignment = taRightJustify
      Caption = '0:00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object pTotal_Trabalhada: TPanel
      Left = 123
      Top = 39
      Width = 107
      Height = 24
      Alignment = taRightJustify
      Caption = '0:00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object pTotal_Saldo: TPanel
      Left = 236
      Top = 39
      Width = 107
      Height = 24
      Alignment = taRightJustify
      Caption = '0:00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
    end
    object btnRecalcular: TBitBtn
      Left = 349
      Top = 23
      Width = 100
      Height = 40
      Caption = 'Recalcular'
      TabOrder = 3
      OnClick = btnRecalcularClick
    end
  end
end
