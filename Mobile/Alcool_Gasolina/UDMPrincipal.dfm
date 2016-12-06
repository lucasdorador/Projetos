object DMPrincipal: TDMPrincipal
  OldCreateOrder = False
  Height = 138
  Width = 289
  object FDConnection1: TFDConnection
    Params.Strings = (
      
        'Database=F:\Programa'#231#227'o\Delphi\XE8\Android\Alcool_Gasolina\Banco' +
        '\Alc_Gas.db'
      'DriverID=SQLite')
    BeforeConnect = FDConnection1BeforeConnect
    Left = 128
    Top = 72
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'FMX'
    Left = 200
    Top = 16
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 48
    Top = 16
  end
end
