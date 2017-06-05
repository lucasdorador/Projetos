object DMPrincipal: TDMPrincipal
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 172
  Width = 382
  object FDQuery1: TFDQuery
    SQL.Strings = (
      
        'SELECT EMP_RAZAO AS EMPRESA, PEDV_NUMERO AS PEDIDO, CLI_RAZAO AS' +
        ' CLIENTE,'
      '       PEDV_DATA AS DATAPEDIDO, PEDV_NEGOCIACAO AS NEGOCIACAO,'
      '       CASE PEDV_STATUS'
      '          WHEN '#39'F'#39' THEN '#39'FINALIZADO'#39
      '          WHEN '#39'C'#39' THEN '#39'CANCELADO'#39
      '          ELSE PEDV_STATUS END AS STATUS'
      'FROM PEDIVE '
      'INNER JOIN EMPRESA ON (EMP_CODIGO = PEDV_EMPRESA)'
      
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
    Left = 152
    Top = 48
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 152
    Top = 104
  end
  object FDQuery2: TFDQuery
    SQL.Strings = (
      'SELECT EMP_DESCRICAO FROM EMPRESA WHERE EMP_CODIGO = :EMPRESA')
    Left = 271
    Top = 64
    ParamData = <
      item
        Name = 'EMPRESA'
        DataType = ftString
        ParamType = ptInput
        Value = '01'
      end>
  end
end
