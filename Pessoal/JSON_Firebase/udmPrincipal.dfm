object dmPrincipal: TdmPrincipal
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 301
  Width = 215
  object FDConnection: TFDConnection
    Params.Strings = (
      'Database=C:\Cardapio\CARDAPIO_ONLINE.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'CharacterSet=WIN1252'
      'DriverID=FB')
    Connected = True
    LoginPrompt = False
    Left = 32
    Top = 16
  end
  object FDInsert: TFDQuery
    Connection = FDConnection
    Left = 32
    Top = 72
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'FMX'
    Left = 32
    Top = 128
  end
  object FDConsultaProduto: TFDQuery
    Active = True
    Connection = FDConnection
    SQL.Strings = (
      'SELECT * FROM PRODUTOS')
    Left = 128
    Top = 16
    object FDConsultaProdutoKEY_EMPRESA: TStringField
      FieldName = 'KEY_EMPRESA'
      Origin = 'KEY_EMPRESA'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 50
    end
    object FDConsultaProdutoKEY_PRODUTO: TStringField
      FieldName = 'KEY_PRODUTO'
      Origin = 'KEY_PRODUTO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 50
    end
    object FDConsultaProdutoDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Size = 255
    end
    object FDConsultaProdutoCOMPLEMENTOS: TStringField
      FieldName = 'COMPLEMENTOS'
      Origin = 'COMPLEMENTOS'
      Size = 255
    end
    object FDConsultaProdutoGRUPO: TStringField
      FieldName = 'GRUPO'
      Origin = 'GRUPO'
      Size = 255
    end
    object FDConsultaProdutoVALOR_INTEIRA: TFloatField
      FieldName = 'VALOR_INTEIRA'
      Origin = 'VALOR_INTEIRA'
    end
    object FDConsultaProdutoVALOR_MEIA: TFloatField
      FieldName = 'VALOR_MEIA'
      Origin = 'VALOR_MEIA'
    end
  end
end
