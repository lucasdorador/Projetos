object DMServer: TDMServer
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 314
  Width = 541
  object FDInformacoes: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 56
    Top = 56
    object FDInformacoesInformacao: TStringField
      FieldName = 'Informacao'
      Size = 100
    end
    object FDInformacoesValor: TStringField
      FieldName = 'Valor'
      Size = 100
    end
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 240
    Top = 208
  end
  object DSInformacoes: TDataSource
    DataSet = FDInformacoes
    Left = 56
    Top = 112
  end
  object FDConexao: TFDConnection
    Left = 256
    Top = 144
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 360
    Top = 144
  end
end
