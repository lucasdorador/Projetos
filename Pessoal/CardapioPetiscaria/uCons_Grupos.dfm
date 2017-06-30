object FCons_Grupos: TFCons_Grupos
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = '[0002] - CONSULTA DE GRUPOS'
  ClientHeight = 341
  ClientWidth = 497
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
    Width = 491
    Height = 335
    Align = alClient
    Caption = 'Dados dos Grupos Cadastrados'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    ExplicitLeft = 160
    ExplicitTop = 136
    ExplicitWidth = 185
    ExplicitHeight = 105
    object edtcons_Grupos: TEdit
      AlignWithMargins = True
      Left = 5
      Top = 18
      Width = 481
      Height = 21
      Align = alTop
      CharCase = ecUpperCase
      TabOrder = 0
      OnEnter = edtcons_GruposEnter
      OnExit = edtcons_GruposExit
    end
    object DBCons_Grupos: TDBGrid
      AlignWithMargins = True
      Left = 5
      Top = 45
      Width = 481
      Height = 276
      Align = alTop
      DataSource = DMPrinc.DSCons_Grupos
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
      OnDblClick = DBCons_GruposDblClick
      OnKeyDown = DBCons_GruposKeyDown
      Columns = <
        item
          Alignment = taLeftJustify
          Expanded = False
          FieldName = 'GRUPO_CODIGO'
          Title.Caption = 'C'#243'digo'
          Width = 74
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'GRUPO_DESCRICAO'
          Title.Caption = 'Descri'#231#227'o'
          Width = 370
          Visible = True
        end>
    end
  end
end
