object DMPrincipal: TDMPrincipal
  OldCreateOrder = False
  Height = 273
  Width = 388
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'FMX'
    Left = 176
    Top = 120
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=C:\Projetos\ServerEstoque\DFSISTEMAS.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'DriverID=FB')
    LoginPrompt = False
    Left = 81
    Top = 40
  end
end
