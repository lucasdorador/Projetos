object DMBackupRestore: TDMBackupRestore
  OldCreateOrder = False
  Height = 333
  Width = 519
  object BackupFB: TIBBackupService
    LoginPrompt = False
    TraceFlags = []
    ServerType = 'IBServer'
    BlockingFactor = 0
    Options = []
    PreAllocate = 0
    Left = 96
    Top = 24
  end
  object RestoreFB: TIBRestoreService
    LoginPrompt = False
    TraceFlags = []
    ServerType = 'IBServer'
    PageBuffers = 0
    PreAllocate = 0
    ReadOnly = False
    Left = 32
    Top = 24
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=C:\Lancamento_Horas\LANCAMENTO_DIARIO.FDB'
      'Password=masterkey'
      'User_Name=SYSDBA'
      'DriverID=FB')
    LoginPrompt = False
    Left = 32
    Top = 88
  end
end
