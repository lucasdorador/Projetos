object FServidor: TFServidor
  Left = 271
  Top = 114
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'FServidor'
  ClientHeight = 512
  ClientWidth = 646
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pgcPrincipal: TPageControl
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 640
    Height = 506
    ActivePage = tbInformacoes
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    Style = tsFlatButtons
    TabOrder = 0
    object tbInformacoes: TTabSheet
      Caption = 'Informa'#231#245'es do Servidor'
      object btnIniciar: TBitBtn
        Left = 407
        Top = 3
        Width = 217
        Height = 73
        Caption = 'Iniciar Servi'#231'o [F3]'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = btnIniciarClick
      end
      object btnParar: TBitBtn
        Left = 407
        Top = 82
        Width = 217
        Height = 73
        Caption = 'Parar Servi'#231'o [F4]'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        OnClick = btnPararClick
      end
      object btnVisualizar: TBitBtn
        Left = 407
        Top = 161
        Width = 217
        Height = 73
        Caption = 'Visualizar Log [F5]'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        OnClick = btnVisualizarClick
      end
      object btnConfig: TBitBtn
        Left = 407
        Top = 240
        Width = 217
        Height = 73
        Caption = 'Configura'#231#245'es [F6]'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
        OnClick = btnConfigClick
      end
      object btnFechar: TBitBtn
        Left = 407
        Top = 398
        Width = 217
        Height = 73
        Caption = 'Fechar Aplica'#231#227'o [ESC]'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 4
        OnClick = btnFecharClick
      end
      object GroupBox1: TGroupBox
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 398
        Height = 468
        Align = alLeft
        Caption = 'Informa'#231#245'es'
        TabOrder = 5
        object Panel1: TPanel
          AlignWithMargins = True
          Left = 5
          Top = 19
          Width = 388
          Height = 444
          Align = alClient
          BevelKind = bkSoft
          BevelWidth = 2
          TabOrder = 0
          object DBGrid1: TDBGrid
            AlignWithMargins = True
            Left = 5
            Top = 5
            Width = 374
            Height = 335
            Align = alClient
            DataSource = DMServer.DSInformacoes
            Options = [dgColLines, dgRowLines, dgTabs, dgRowSelect]
            ReadOnly = True
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -12
            TitleFont.Name = 'Tahoma'
            TitleFont.Style = [fsBold]
            OnCellClick = DBGrid1CellClick
            Columns = <
              item
                Expanded = False
                FieldName = 'Informacao'
                Title.Caption = 'Informa'#231#227'o'
                Width = 165
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'Valor'
                Width = 184
                Visible = True
              end>
          end
          object Memo1: TMemo
            AlignWithMargins = True
            Left = 5
            Top = 346
            Width = 374
            Height = 89
            Align = alBottom
            Lines.Strings = (
              'Memo1')
            TabOrder = 1
            ExplicitLeft = 136
            ExplicitTop = 368
            ExplicitWidth = 185
          end
        end
      end
      object btnTestarConexao: TBitBtn
        Left = 407
        Top = 319
        Width = 217
        Height = 73
        Caption = 'Testar Conex'#227'o [F7]'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 6
        OnClick = btnTestarConexaoClick
      end
    end
    object tbVisualizaLog: TTabSheet
      Caption = 'Visualiza'#231#227'o dos Log'#39's'
      ImageIndex = 1
      object mLog: TMemo
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 626
        Height = 399
        Align = alClient
        Color = clBackground
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clLime
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        Lines.Strings = (
          'Memo1')
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 0
      end
      object Panel2: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 408
        Width = 626
        Height = 63
        Align = alBottom
        BevelKind = bkSoft
        BorderWidth = 2
        TabOrder = 1
        object btnVoltarLog: TBitBtn
          Left = 402
          Top = 3
          Width = 217
          Height = 53
          Align = alRight
          Caption = 'Voltar [ESC]'
          TabOrder = 0
          OnClick = btnVoltarLogClick
        end
      end
    end
    object tbConfig: TTabSheet
      Caption = 'Configura'#231#245'es do Server'
      ImageIndex = 2
      object Panel3: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 408
        Width = 626
        Height = 63
        Align = alBottom
        BevelKind = bkSoft
        BorderWidth = 2
        TabOrder = 0
        object btnVoltarConfig: TBitBtn
          Left = 185
          Top = 3
          Width = 217
          Height = 53
          Align = alRight
          Caption = 'Voltar [ESC]'
          TabOrder = 0
          OnClick = btnVoltarConfigClick
        end
        object btnGravarConfig: TBitBtn
          Left = 402
          Top = 3
          Width = 217
          Height = 53
          Align = alRight
          Caption = 'Gravar Configura'#231#227'o'
          TabOrder = 1
          OnClick = btnGravarConfigClick
        end
      end
      object GroupBox2: TGroupBox
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 626
        Height = 78
        Align = alTop
        Caption = 'Configura'#231#245'es de Banco de Dados'
        TabOrder = 1
        object Label2: TLabel
          AlignWithMargins = True
          Left = 7
          Top = 22
          Width = 175
          Height = 14
          Caption = 'Caminho do Banco de Dados'
        end
        object edtCaminho: TEdit
          AlignWithMargins = True
          Left = 7
          Top = 42
          Width = 579
          Height = 22
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
        end
        object btnLocalizar: TBitBtn
          Left = 592
          Top = 42
          Width = 31
          Height = 22
          Caption = '...'
          TabOrder = 1
          OnClick = btnLocalizarClick
        end
      end
      object GroupBox3: TGroupBox
        AlignWithMargins = True
        Left = 3
        Top = 87
        Width = 626
        Height = 74
        Align = alTop
        Caption = 'Configura'#231#227'o de Conex'#227'o'
        TabOrder = 2
        object Label1: TLabel
          Left = 7
          Top = 19
          Width = 110
          Height = 14
          Caption = 'Porta de Conex'#227'o'
        end
        object edtPorta: TEdit
          Left = 7
          Top = 39
          Width = 110
          Height = 22
          TabOrder = 0
        end
      end
      object btnTestarBanco: TBitBtn
        Left = 412
        Top = 167
        Width = 217
        Height = 73
        Caption = 'Testar Conex'#227'o Banco de Dados'
        TabOrder = 3
        OnClick = btnTestarBancoClick
      end
    end
  end
  object ApplicationEvents1: TApplicationEvents
    OnIdle = ApplicationEvents1Idle
    Left = 928
    Top = 104
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Arquivo de Banco de Dados|*.FDB'
    Title = 'Localizar Arquivo do Banco de Dados'
    Left = 586
    Top = 130
  end
end
