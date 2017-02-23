object dmPrincipal: TdmPrincipal
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 289
  Width = 433
  object Conexao: TFDConnection
    Params.Strings = (
      
        'Database=F:\Projetos\trunk\Mobile\AppControleCheques\Banco_de_Da' +
        'dos\ControleCheques.sdb'
      'LockingMode=Normal'
      'DriverID=SQLite')
    Connected = True
    LoginPrompt = False
    BeforeConnect = ConexaoBeforeConnect
    Left = 16
    Top = 8
  end
  object FDConsulta: TFDQuery
    AfterPost = FDConsultaAfterPost
    CachedUpdates = True
    Connection = Conexao
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtEditNumeric]
    SQL.Strings = (
      'SELECT * FROM CHEQUES')
    Left = 80
    Top = 8
    object FDConsultaCH_CODIGO: TFDAutoIncField
      FieldName = 'CH_CODIGO'
      Origin = 'CH_CODIGO'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDConsultaCH_BANCO: TStringField
      FieldName = 'CH_BANCO'
      Origin = 'CH_BANCO'
      Required = True
      Size = 10
    end
    object FDConsultaCH_CONTACORRENTE: TStringField
      FieldName = 'CH_CONTACORRENTE'
      Origin = 'CH_CONTACORRENTE'
      Required = True
      Size = 15
    end
    object FDConsultaCH_NUMEROCHEQUE: TStringField
      FieldName = 'CH_NUMEROCHEQUE'
      Origin = 'CH_NUMEROCHEQUE'
      Size = 8
    end
    object FDConsultaCH_VALOR: TFloatField
      FieldName = 'CH_VALOR'
      Origin = 'CH_VALOR'
      DisplayFormat = ',0.00'
      EditFormat = ',0.00'
    end
    object FDConsultaCH_DATALANCAMENTO: TDateField
      FieldName = 'CH_DATALANCAMENTO'
      Origin = 'CH_DATALANCAMENTO'
    end
    object FDConsultaCH_DATACOMPENSACAO: TDateField
      FieldName = 'CH_DATACOMPENSACAO'
      Origin = 'CH_DATACOMPENSACAO'
    end
    object FDConsultaCH_FORNECEDOR: TStringField
      FieldName = 'CH_FORNECEDOR'
      Origin = 'CH_FORNECEDOR'
      Size = 50
    end
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'FMX'
    Left = 168
    Top = 8
  end
  object FDMCheques: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 200
    Top = 128
    object FDMChequesCH_CODIGO: TFDAutoIncField
      FieldName = 'CH_CODIGO'
      Origin = 'CH_CODIGO'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDMChequesCH_BANCO: TStringField
      FieldName = 'CH_BANCO'
      Origin = 'CH_BANCO'
      Required = True
      Size = 10
    end
    object FDMChequesCH_CONTACORRENTE: TStringField
      FieldName = 'CH_CONTACORRENTE'
      Origin = 'CH_CONTACORRENTE'
      Required = True
      Size = 15
    end
    object FDMChequesCH_NUMEROCHEQUE: TStringField
      FieldName = 'CH_NUMEROCHEQUE'
      Origin = 'CH_NUMEROCHEQUE'
      Size = 8
    end
    object FDMChequesCH_VALOR: TFloatField
      FieldName = 'CH_VALOR'
      Origin = 'CH_VALOR'
      DisplayFormat = ',0.00'
      EditFormat = ',0.00'
    end
    object FDMChequesCH_DATALANCAMENTO: TDateField
      FieldName = 'CH_DATALANCAMENTO'
      Origin = 'CH_DATALANCAMENTO'
    end
    object FDMChequesCH_DATACOMPENSACAO: TDateField
      FieldName = 'CH_DATACOMPENSACAO'
      Origin = 'CH_DATACOMPENSACAO'
    end
    object FDMChequesCH_FORNECEDOR: TStringField
      FieldName = 'CH_FORNECEDOR'
      Origin = 'CH_FORNECEDOR'
      Size = 50
    end
  end
end
