program Horas_Trabalhadas;

uses
  Vcl.Forms,
  uLancamentoOS in 'uLancamentoOS.pas' {FLancamentoOS},
  uClass_LancamentoOS in 'Lib\uClass_LancamentoOS.pas',
  UConexao in 'Lib\UConexao.pas',
  uDMPrincipal in 'uDMPrincipal.pas' {DMPrincipal: TDataModule},
  uConsultaCliente in 'uConsultaCliente.pas' {FConsultaCliente};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFLancamentoOS, FLancamentoOS);
  Application.CreateForm(TDMPrincipal, DMPrincipal);
  Application.CreateForm(TFConsultaCliente, FConsultaCliente);
  Application.Run;
end.
