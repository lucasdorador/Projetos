object DMPrincipal: TDMPrincipal
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 384
  Width = 590
  object DSDespesas: TDataSource
    DataSet = FDDespesas
    Left = 112
    Top = 16
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 107
    Top = 128
  end
  object FDDespesas: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT DESP_SEQUENCIA, DESP_ANO, DESP_DESCRICAO,'
      '       DESP_VALOR'
      'FROM DESPESAS'
      'WHERE DESP_ANO = :ANO')
    Left = 32
    Top = 16
    ParamData = <
      item
        Name = 'ANO'
        DataType = ftString
        ParamType = ptInput
        Size = 4
      end>
    object FDDespesasDESP_SEQUENCIA: TIntegerField
      FieldName = 'DESP_SEQUENCIA'
      Origin = 'DESP_SEQUENCIA'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object FDDespesasDESP_ANO: TStringField
      FieldName = 'DESP_ANO'
      Origin = 'DESP_ANO'
      Required = True
      Size = 4
    end
    object FDDespesasDESP_DESCRICAO: TStringField
      FieldName = 'DESP_DESCRICAO'
      Origin = 'DESP_DESCRICAO'
      Size = 100
    end
    object FDDespesasDESP_VALOR: TFloatField
      FieldName = 'DESP_VALOR'
      Origin = 'DESP_VALOR'
      DisplayFormat = ',0.00'
    end
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=C:\Projetos\DESPESAS.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'DriverID=FB')
    LoginPrompt = False
    Left = 32
    Top = 184
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 104
    Top = 184
  end
  object FDFaturamento: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT FAT_ANO, FAT_VALOR'
      'FROM FATURAMENTO'
      'WHERE FAT_ANO = :ANO')
    Left = 32
    Top = 72
    ParamData = <
      item
        Name = 'ANO'
        DataType = ftString
        ParamType = ptInput
        Size = 4
        Value = Null
      end>
    object FDFaturamentoFAT_ANO: TStringField
      FieldName = 'FAT_ANO'
      Origin = 'FAT_ANO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 4
    end
    object FDFaturamentoFAT_VALOR: TFloatField
      FieldName = 'FAT_VALOR'
      Origin = 'FAT_VALOR'
      DisplayFormat = ',0.00'
    end
  end
  object DSFaturamento: TDataSource
    DataSet = FDFaturamento
    Left = 112
    Top = 72
  end
  object frxReport1: TfrxReport
    Version = '5.1.5'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 43197.029926956020000000
    ReportOptions.LastChange = 43197.029926956020000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      'begin'
      ''
      'end.')
    Left = 32
    Top = 128
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
        object Memo1: TfrxMemoView
          Left = 642.520100000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Page#]')
        end
      end
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
    Left = 456
    Top = 64
  end
  object frxHTMLExport1: TfrxHTMLExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    FixedWidth = True
    Background = False
    Centered = False
    EmptyLines = True
    Print = False
    PictureType = gpPNG
    Left = 456
    Top = 112
  end
  object frxRTFExport1: TfrxRTFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    PictureType = gpPNG
    Wysiwyg = True
    Creator = 'FastReport'
    SuppressPageHeadersFooters = False
    HeaderFooterMode = hfText
    AutoSize = False
    Left = 456
    Top = 160
  end
  object frxBMPExport1: TfrxBMPExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    Left = 456
    Top = 208
  end
  object frxJPEGExport1: TfrxJPEGExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    Left = 488
    Top = 16
  end
  object frxTIFFExport1: TfrxTIFFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    Left = 520
    Top = 208
  end
  object frxGIFExport1: TfrxGIFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    Left = 520
    Top = 160
  end
  object frxSimpleTextExport1: TfrxSimpleTextExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    Frames = False
    EmptyLines = False
    OEMCodepage = False
    DeleteEmptyColumns = True
    Left = 520
    Top = 112
  end
  object frxCSVExport1: TfrxCSVExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    Separator = ';'
    OEMCodepage = False
    UTF8 = False
    NoSysSymbols = True
    ForcedQuotes = False
    Left = 520
    Top = 64
  end
end
