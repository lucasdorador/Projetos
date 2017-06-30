object DMPrinc: TDMPrinc
  OldCreateOrder = False
  Height = 299
  Width = 500
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 168
    Top = 16
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=C:\Cardapio\CARDAPIO.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'CharacterSet=WIN1252'
      'DriverID=FB')
    Connected = True
    LoginPrompt = False
    Left = 56
    Top = 16
  end
  object FDCons_Grupos: TFDQuery
    Active = True
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT * FROM GRUPO')
    Left = 32
    Top = 136
    object FDCons_GruposGRUPO_CODIGO: TIntegerField
      FieldName = 'GRUPO_CODIGO'
      Origin = 'GRUPO_CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object FDCons_GruposGRUPO_DESCRICAO: TStringField
      FieldName = 'GRUPO_DESCRICAO'
      Origin = 'GRUPO_DESCRICAO'
      Size = 50
    end
  end
  object DSCons_Grupos: TDataSource
    DataSet = FDCons_Grupos
    Left = 32
    Top = 192
  end
  object FDCons_Produto: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT * FROM CARDAPIO ORDER BY PRO_DESCRICAO')
    Left = 136
    Top = 136
    object FDCons_ProdutoPRO_CODIGO: TIntegerField
      FieldName = 'PRO_CODIGO'
      Origin = 'PRO_CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object FDCons_ProdutoPRO_GRUPO: TIntegerField
      FieldName = 'PRO_GRUPO'
      Origin = 'PRO_GRUPO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object FDCons_ProdutoPRO_DESCRICAO: TStringField
      FieldName = 'PRO_DESCRICAO'
      Origin = 'PRO_DESCRICAO'
      Required = True
      Size = 100
    end
    object FDCons_ProdutoPRO_VALORMEIA: TFloatField
      FieldName = 'PRO_VALORMEIA'
      Origin = 'PRO_VALORMEIA'
    end
    object FDCons_ProdutoPRO_VALORINTEIRA: TFloatField
      FieldName = 'PRO_VALORINTEIRA'
      Origin = 'PRO_VALORINTEIRA'
    end
  end
  object DSCons_Produto: TDataSource
    DataSet = FDCons_Produto
    Left = 136
    Top = 192
  end
  object frxReport1: TfrxReport
    Version = '5.4'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42895.770781250000000000
    ReportOptions.LastChange = 42895.770781250000000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      'begin'
      ''
      'end.')
    Left = 424
    Top = 40
    Datasets = <>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 102.047310000000000000
        Width = 718.110700000000000000
        RowCount = 0
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 185.196970000000000000
        Width = 718.110700000000000000
      end
      object Memo1: TfrxMemoView
        Left = 642.520100000000000000
        Top = 185.196970000000000000
        Width = 75.590600000000000000
        Height = 18.897650000000000000
        HAlign = haRight
        Memo.UTF8W = (
          '[Page#]')
      end
    end
  end
  object frxDBDataset1: TfrxDBDataset
    UserName = 'frxDB_Cardapio'
    CloseDataSource = False
    FieldAliases.Strings = (
      'GRUPO_DESCRICAO=GRUPO_DESCRICAO'
      'PRO_DESCRICAO=PRO_DESCRICAO'
      'PRO_VALORINTEIRA=PRO_VALORINTEIRA'
      'PRO_VALORMEIA=PRO_VALORMEIA')
    DataSet = FDRel_Cardapio
    BCDToCurrency = False
    Left = 424
    Top = 96
  end
  object FDRel_Cardapio: TFDQuery
    Active = True
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT GRUPO_DESCRICAO, PRO_DESCRICAO, '
      '       PRO_VALORINTEIRA, PRO_VALORMEIA'
      'FROM CARDAPIO'
      'INNER JOIN GRUPO ON (GRUPO_CODIGO = PRO_GRUPO)'
      'ORDER BY GRUPO_CODIGO, PRO_DESCRICAO')
    Left = 424
    Top = 152
    object FDRel_CardapioGRUPO_DESCRICAO: TStringField
      FieldName = 'GRUPO_DESCRICAO'
      Origin = 'GRUPO_DESCRICAO'
      Size = 50
    end
    object FDRel_CardapioPRO_DESCRICAO: TStringField
      FieldName = 'PRO_DESCRICAO'
      Origin = 'PRO_DESCRICAO'
      Required = True
      Size = 100
    end
    object FDRel_CardapioPRO_VALORINTEIRA: TFloatField
      FieldName = 'PRO_VALORINTEIRA'
      Origin = 'PRO_VALORINTEIRA'
    end
    object FDRel_CardapioPRO_VALORMEIA: TFloatField
      FieldName = 'PRO_VALORMEIA'
      Origin = 'PRO_VALORMEIA'
    end
  end
  object frxPDFExport1: TfrxPDFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    PrintOptimized = False
    Outline = False
    Background = False
    HTMLTags = True
    Quality = 95
    Transparency = False
    Author = 'FastReport'
    Subject = 'FastReport PDF export'
    ProtectionFlags = [ePrint, eModify, eCopy, eAnnot]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = False
    PrintScaling = False
    PdfA = False
    Left = 312
    Top = 96
  end
  object frxJPEGExport1: TfrxJPEGExport
    FileName = 'C:\Cardapio\Rel_Cadapio.jpg'
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = True
    CreationTime = 42893.859260462960000000
    DataOnly = False
    Left = 312
    Top = 40
  end
  object frxBMPExport1: TfrxBMPExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = True
    DataOnly = False
    Left = 312
    Top = 152
  end
end
