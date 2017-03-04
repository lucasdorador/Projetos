object ServerMethods1: TServerMethods1
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 257
  Width = 419
  object Conexao: TFDConnection
    Params.Strings = (
      'DriverID=FB'
      'User_Name=sysdba'
      'Password=masterkey')
    Left = 344
    Top = 16
  end
  object FDStanStorageJSONLink1: TFDStanStorageJSONLink
    Left = 56
    Top = 70
  end
  object FDGUIxWaitCursor2: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 56
    Top = 121
  end
  object FDPhysFBDriverLink2: TFDPhysFBDriverLink
    Left = 56
    Top = 174
  end
end
