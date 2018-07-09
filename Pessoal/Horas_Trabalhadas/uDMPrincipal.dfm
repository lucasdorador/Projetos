object DMPrincipal: TDMPrincipal
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 262
  Width = 769
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=C:\Lancamento_Horas\LANCAMENTO_DIARIO.FDB'
      'Password=masterkey'
      'User_Name=SYSDBA'
      'DriverID=FB')
    Connected = True
    LoginPrompt = False
    Left = 32
    Top = 8
  end
  object FDLancamento_Diario: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from lancamentoos_diario')
    Left = 48
    Top = 96
    object FDLancamento_DiarioNUMEROOS: TStringField
      FieldName = 'NUMEROOS'
      Origin = 'NUMEROOS'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 6
    end
    object FDLancamento_DiarioSPRINT: TIntegerField
      FieldName = 'SPRINT'
      Origin = 'SPRINT'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object FDLancamento_DiarioDATATRABALHADA: TDateField
      FieldName = 'DATATRABALHADA'
      Origin = 'DATATRABALHADA'
      Required = True
    end
    object FDLancamento_DiarioHORADISPONIVEL: TStringField
      FieldName = 'HORADISPONIVEL'
      Origin = 'HORADISPONIVEL'
      Size = 50
    end
    object FDLancamento_DiarioHORAPERDIDA: TStringField
      FieldName = 'HORAPERDIDA'
      Origin = 'HORAPERDIDA'
      Size = 50
    end
    object FDLancamento_DiarioHORATRABALHADA: TStringField
      FieldName = 'HORATRABALHADA'
      Origin = 'HORATRABALHADA'
      Size = 50
    end
  end
  object dsLancamento_Diario: TDataSource
    DataSet = FDLancamento_Diario
    Left = 48
    Top = 152
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 128
    Top = 8
  end
  object FDConsultaClientes: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      
        'SELECT DISTINCT(CLIENTE) AS CLIENTE FROM LANCAMENTOOS ORDER BY C' +
        'LIENTE')
    Left = 152
    Top = 96
    object FDConsultaClientesCLIENTE: TStringField
      FieldName = 'CLIENTE'
      Origin = 'CLIENTE'
      Size = 200
    end
  end
  object dsConsultaClientes: TDataSource
    DataSet = FDConsultaClientes
    Left = 152
    Top = 152
  end
  object FDInsert: TFDQuery
    Connection = FDConnection1
    Left = 272
    Top = 96
  end
end
