program Calcula_Despesa_IR;

uses
  Vcl.Forms,
  uCalculaDespesa in 'uCalculaDespesa.pas' {FCalculaDespesa},
  uDMPrincipal in 'uDMPrincipal.pas' {DMPrincipal: TDataModule},
  uCRUDDespesas in 'uCRUDDespesas.pas',
  uPrincipal in 'uPrincipal.pas' {Fprincipal},
  uFaturamento in 'uFaturamento.pas' {FFaturamento},
  uCRUDFaturamento in 'uCRUDFaturamento.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Cálculo de Despesas e DIRPF MEI';
  Application.CreateForm(TDMPrincipal, DMPrincipal);
  Application.CreateForm(TFprincipal, Fprincipal);
  Application.CreateForm(TFFaturamento, FFaturamento);
  Application.Run;
end.
