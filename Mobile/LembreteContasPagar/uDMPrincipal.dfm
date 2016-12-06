object DMPrincipal: TDMPrincipal
  OldCreateOrder = False
  Height = 287
  Width = 436
  object FDConnection1: TFDConnection
    Params.Strings = (
      
        'Database=F:\Programa'#231#227'o\Delphi\XE8\Android\LembreteContasPagar\B' +
        'anco de Dados\LembreteContas.db'
      'OpenMode=ReadWrite'
      'DriverID=SQLite')
    Connected = True
    LoginPrompt = False
    BeforeConnect = FDConnection1BeforeConnect
    Left = 32
    Top = 16
  end
  object FDUsuario: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT * FROM USUARIO')
    Left = 32
    Top = 72
    object FDUsuarioUsua_Codigo: TFDAutoIncField
      FieldName = 'Usua_Codigo'
      Origin = 'Usua_Codigo'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object FDUsuarioUsua_Nome: TWideStringField
      FieldName = 'Usua_Nome'
      Origin = 'Usua_Nome'
      Required = True
      Size = 50
    end
    object FDUsuarioUsua_Email: TWideStringField
      FieldName = 'Usua_Email'
      Origin = 'Usua_Email'
      Size = 50
    end
    object FDUsuarioUsua_Imagem: TBlobField
      FieldName = 'Usua_Imagem'
      Origin = 'Usua_Imagem'
    end
    object FDUsuarioUsua_Senha: TWideStringField
      FieldName = 'Usua_Senha'
      Origin = 'Usua_Senha'
      Required = True
      Size = 10
    end
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'FMX'
    Left = 128
    Top = 16
  end
end
