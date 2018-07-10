program Horas_Trabalhadas;

uses
  Vcl.Forms,
  uLancamentoOS in 'uLancamentoOS.pas' {FLancamentoOS},
  uClass_LancamentoOS in 'Lib\uClass_LancamentoOS.pas',
  UConexao in 'Lib\UConexao.pas',
  uDMPrincipal in 'uDMPrincipal.pas' {DMPrincipal: TDataModule},
  uConsultaCliente in 'uConsultaCliente.pas' {FConsultaCliente},
  uLancamentodiario in 'uLancamentodiario.pas' {FLancamentodiario},
  uFuncoes in 'Lib\uFuncoes.pas',
  uPrincipal in 'uPrincipal.pas' {FPrincipal},
  uBackup_restore in 'Lib\uBackup_restore.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDMPrincipal, DMPrincipal);
  Application.CreateForm(TFPrincipal, FPrincipal);
  Application.Run;
end.
