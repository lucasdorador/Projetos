object FBackupRestore: TFBackupRestore
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = '[0000] Horas Trabalhadas - Backup / Restore'
  ClientHeight = 669
  ClientWidth = 645
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pcBackup_Restore: TPageControl
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 639
    Height = 663
    ActivePage = tsBackup
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object tsBackup: TTabSheet
      Caption = 'Backup'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object MemoBackup: TMemo
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 625
        Height = 560
        Align = alTop
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ScrollBars = ssVertical
        TabOrder = 0
      end
      object btnBackup: TBitBtn
        Left = 433
        Top = 569
        Width = 195
        Height = 57
        Caption = 'Iniciar Backup'
        TabOrder = 1
        OnClick = btnBackupClick
      end
    end
    object tsRestore: TTabSheet
      Caption = 'Restore'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object MemoRestore: TMemo
        AlignWithMargins = True
        Left = 3
        Top = 63
        Width = 625
        Height = 500
        Align = alTop
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ScrollBars = ssVertical
        TabOrder = 0
      end
      object btnRestore: TBitBtn
        Left = 433
        Top = 569
        Width = 195
        Height = 57
        Caption = 'Restaurar Backup'
        TabOrder = 1
        OnClick = btnRestoreClick
      end
      object gbCaminhoFBK: TGroupBox
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 625
        Height = 54
        Align = alTop
        Caption = 'Caminho do FBK'
        TabOrder = 2
        object edtCaminhoFBK: TEdit
          AlignWithMargins = True
          Left = 5
          Top = 24
          Width = 565
          Height = 25
          Align = alLeft
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          ExplicitHeight = 27
        end
        object btnConsFBK: TBitBtn
          AlignWithMargins = True
          Left = 576
          Top = 24
          Width = 44
          Height = 25
          Align = alRight
          Caption = '...'
          TabOrder = 1
          OnClick = btnConsFBKClick
        end
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Backup Firebird|*.*FBK'
    Left = 312
    Top = 336
  end
end
