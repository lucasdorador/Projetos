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
    Left = 355
    Top = 120
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
    Connected = True
    LoginPrompt = False
    Left = 280
    Top = 176
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 352
    Top = 176
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
end
