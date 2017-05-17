object DMPrincipal: TDMPrincipal
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 172
  Width = 382
  object FDConnection1: TFDConnection
    Params.Strings = (
      
        'Database=C:\Sinco\Atualizacoes\Fonte Padrao - Comercio\FACILITE.' +
        'FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'DriverID=FB')
    Connected = True
    LoginPrompt = False
    Left = 63
    Top = 16
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT PEDV_CLIENTE, CLI_RAZAO, PEDV_DATA '
      'FROM PEDIVE '
      
        'INNER JOIN CLIENTE ON (PEDV_EMPRESA = :EMPRESA AND PEDV_CLIENTE ' +
        '= CLI_CODIGO)'
      'WHERE PEDV_EMPRESA = :EMPRESA AND PEDV_NUMERO = :NUMERO')
    Left = 63
    Top = 72
    ParamData = <
      item
        Name = 'EMPRESA'
        DataType = ftString
        ParamType = ptInput
        Value = '01'
      end
      item
        Name = 'NUMERO'
        DataType = ftString
        ParamType = ptInput
        Value = '062125'
      end>
  end
  object FDTable1: TFDTable
    Connection = FDConnection1
    Left = 152
    Top = 48
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 152
    Top = 104
  end
end
