object FCons_Produtos: TFCons_Produtos
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = '[0003] - CONSULTA DE PRODUTOS'
  ClientHeight = 335
  ClientWidth = 672
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
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 666
    Height = 329
    Align = alClient
    Caption = 'Dados dos Produtos Cadastrados'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    ExplicitLeft = -44
    ExplicitTop = -134
    ExplicitWidth = 491
    ExplicitHeight = 335
    object edtcons_Produto: TEdit
      AlignWithMargins = True
      Left = 5
      Top = 18
      Width = 656
      Height = 21
      Align = alTop
      CharCase = ecUpperCase
      TabOrder = 0
      OnEnter = edtcons_ProdutoEnter
      OnExit = edtcons_ProdutoExit
      ExplicitWidth = 481
    end
    object DBCons_Produtos: TDBGrid
      AlignWithMargins = True
      Left = 5
      Top = 45
      Width = 656
      Height = 276
      Align = alTop
      DataSource = DMPrinc.DSCons_Produto
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = [fsBold]
      OnDblClick = DBCons_ProdutosDblClick
      OnKeyDown = DBCons_ProdutosKeyDown
      Columns = <
        item
          Expanded = False
          FieldName = 'PRO_DESCRICAO'
          Title.Caption = 'Descri'#231#227'o'
          Width = 360
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PRO_VALORINTEIRA'
          Title.Alignment = taRightJustify
          Title.Caption = 'Valor Inteira'
          Width = 120
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PRO_VALORMEIA'
          Title.Alignment = taRightJustify
          Title.Caption = 'Valor Meia'
          Width = 120
          Visible = True
        end>
    end
  end
end
