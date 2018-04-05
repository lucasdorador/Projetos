object DMPrincipal: TDMPrincipal
  OldCreateOrder = False
  Height = 384
  Width = 590
  object FDMemPrincipal: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 64
    Top = 40
    object FDMemPrincipalAno: TStringField
      FieldName = 'Ano'
      Size = 4
    end
    object FDMemPrincipalDespesa: TStringField
      FieldName = 'Despesa'
      Size = 100
    end
    object FDMemPrincipalValor: TFloatField
      FieldName = 'Valor'
    end
  end
  object DSPrincipal: TDataSource
    DataSet = FDMemPrincipal
    Left = 144
    Top = 40
  end
end
