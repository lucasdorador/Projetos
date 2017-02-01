object ServerMethods1: TServerMethods1
  OldCreateOrder = False
  Height = 297
  Width = 476
  object cnnConexaoServidor: TFDConnection
    Params.Strings = (
      
        'Database=F:\Projetos\trunk\Mobile\SincronizacaoDadosJSONDataSnap' +
        '\Banco de Dados\PRODUTOCLIENTE.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'DriverID=FB')
    LoginPrompt = False
    Left = 48
    Top = 8
  end
  object qryProdutos: TFDQuery
    Connection = cnnConexaoServidor
    Left = 136
    Top = 8
  end
  object qryInsercao: TFDQuery
    Connection = cnnConexaoServidor
    Left = 208
    Top = 8
  end
  object memAuxiliar: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 280
    Top = 8
  end
  object FDStanStorageJSONLink1: TFDStanStorageJSONLink
    Left = 64
    Top = 64
  end
  object FDStanStorageBinLink1: TFDStanStorageBinLink
    Left = 200
    Top = 64
  end
  object driver: TFDPhysFBDriverLink
    Left = 344
    Top = 8
  end
end
