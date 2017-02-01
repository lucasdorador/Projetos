object dmAcessoDados: TdmAcessoDados
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 118
  Width = 423
  object cnnConexao: TFDConnection
    Params.Strings = (
      'ConnectionDef=ProdutoCliente')
    Connected = True
    LoginPrompt = False
    Left = 24
    Top = 8
  end
  object driver: TFDPhysSQLiteDriverLink
    Left = 80
    Top = 8
  end
  object json: TFDStanStorageJSONLink
    Left = 128
    Top = 8
  end
  object qryProdutos: TFDQuery
    Connection = cnnConexao
    SQL.Strings = (
      'select idproduto, codigo, nome from produtos')
    Left = 176
    Top = 8
    object qryProdutosidproduto: TFDAutoIncField
      FieldName = 'idproduto'
      Origin = 'idproduto'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object qryProdutoscodigo: TStringField
      FieldName = 'codigo'
      Origin = 'codigo'
      Required = True
      FixedChar = True
      Size = 8
    end
    object qryProdutosnome: TStringField
      FieldName = 'nome'
      Origin = 'nome'
      Required = True
    end
  end
  object qryInsercao: TFDQuery
    Connection = cnnConexao
    Left = 240
    Top = 8
  end
  object memInsercao: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 312
    Top = 8
  end
  object WaitCursor: TFDGUIxWaitCursor
    Provider = 'FMX'
    Left = 24
    Top = 64
  end
end
