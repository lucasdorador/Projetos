object FPrincipal: TFPrincipal
  OldCreateOrder = False
  DisplayName = 'Desligando PC Autom'#225'tico'
  Interactive = True
  AfterInstall = ServiceAfterInstall
  BeforeUninstall = ServiceBeforeUninstall
  OnStart = ServiceStart
  OnStop = ServiceStop
  Height = 150
  Width = 215
  object TimerDesligar: TTimer
    Enabled = False
    OnTimer = TimerDesligarTimer
    Left = 56
    Top = 24
  end
end
