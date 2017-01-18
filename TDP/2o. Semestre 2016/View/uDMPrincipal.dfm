object DMPrincipal: TDMPrincipal
  OldCreateOrder = False
  Height = 325
  Width = 468
  object frxReport1: TfrxReport
    Version = '5.4'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42752.931638773150000000
    ReportOptions.LastChange = 42752.931638773150000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      'begin'
      ''
      'end.')
    OnGetValue = frxReport1GetValue
    Left = 80
    Top = 32
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
  object FDDARF: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'PeriodoApuracao'
        DataType = ftString
        Size = 11
      end
      item
        Name = 'CPFCNPJ'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Referencia'
        DataType = ftString
        Size = 21
      end
      item
        Name = 'Vencimento'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'NomeImposto'
        DataType = ftString
        Size = 52
      end
      item
        Name = 'CodReceita'
        DataType = ftString
        Size = 6
      end
      item
        Name = 'NomeRazao'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'ValorPrincipal'
        DataType = ftFloat
      end
      item
        Name = 'Multa'
        DataType = ftFloat
      end
      item
        Name = 'Juros'
        DataType = ftFloat
      end
      item
        Name = 'Total'
        DataType = ftFloat
      end
      item
        Name = 'CodigoBarras'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'DomicioTrib'
        DataType = ftString
        Size = 100
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    StoreDefs = True
    Left = 152
    Top = 32
    object FDDARFPeriodoApuracao: TStringField
      FieldName = 'PeriodoApuracao'
      Size = 11
    end
    object FDDARFCPFCNPJ: TStringField
      FieldName = 'CPFCNPJ'
    end
    object FDDARFReferencia: TStringField
      DisplayWidth = 21
      FieldName = 'Referencia'
      Size = 21
    end
    object FDDARFVencimento: TStringField
      FieldName = 'Vencimento'
      Size = 10
    end
    object FDDARFNomeImposto: TStringField
      DisplayWidth = 52
      FieldName = 'NomeImposto'
      Size = 52
    end
    object FDDARFCodReceita: TStringField
      FieldName = 'CodReceita'
      Size = 6
    end
    object FDDARFNomeRazao: TStringField
      FieldName = 'NomeRazao'
      Size = 100
    end
    object FDDARFValorPrincipal: TFloatField
      FieldName = 'ValorPrincipal'
    end
    object FDDARFMulta: TFloatField
      FieldName = 'Multa'
    end
    object FDDARFJuros: TFloatField
      FieldName = 'Juros'
    end
    object FDDARFTotal: TFloatField
      FieldName = 'Total'
    end
    object FDDARFCodigoBarras: TStringField
      FieldName = 'CodigoBarras'
      Size = 50
    end
    object FDDARFDomicioTrib: TStringField
      FieldName = 'DomicioTrib'
      Size = 100
    end
  end
  object frxDBDARF: TfrxDBDataset
    UserName = 'frxDBDARF'
    CloseDataSource = False
    FieldAliases.Strings = (
      'PeriodoApuracao=PeriodoApuracao'
      'CPFCNPJ=CPFCNPJ'
      'Referencia=Referencia'
      'Vencimento=Vencimento'
      'NomeImposto=NomeImposto'
      'CodReceita=CodReceita'
      'NomeRazao=NomeRazao'
      'ValorPrincipal=ValorPrincipal'
      'Multa=Multa'
      'Juros=Juros'
      'Total=Total'
      'CodigoBarras=CodigoBarras'
      'DomicioTrib=DomicioTrib')
    DataSet = FDDARF
    BCDToCurrency = False
    Left = 216
    Top = 32
  end
  object frxBarCodeObject1: TfrxBarCodeObject
    Left = 296
    Top = 32
  end
end
