program Horas_Trabalhadas;

uses
  Vcl.Forms,
  uLancamentoOS in 'uLancamentoOS.pas' {FLancamentoOS},
  uClass_LancamentoOS in 'Lib\uClass_LancamentoOS.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFLancamentoOS, FLancamentoOS);
  Application.Run;
end.
