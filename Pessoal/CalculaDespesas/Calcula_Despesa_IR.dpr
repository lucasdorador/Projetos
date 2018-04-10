program Calcula_Despesa_IR;

uses
  Vcl.Forms,
  uCalculaDespesa in 'uCalculaDespesa.pas' {FCalculaDespesa},
  uDMPrincipal in 'uDMPrincipal.pas' {DMPrincipal: TDataModule},
  uCRUDDespesas in 'uCRUDDespesas.pas',
  uPrincipal in 'uPrincipal.pas' {Fprincipal},
  uFaturamento in 'uFaturamento.pas' {FFaturamento},
  uCRUDFaturamento in 'uCRUDFaturamento.pas',
  uApuracao in 'uApuracao.pas' {FApuracao},
  uGeraApuracao in 'uGeraApuracao.pas',
  uCRUDConfiguracao in 'uCRUDConfiguracao.pas',
  uImpressao in 'uImpressao.pas',
  uConfiguracao in 'uConfiguracao.pas' {FConfiguracao};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'C�lculo de Despesas e DIRPF MEI';
  Application.CreateForm(TDMPrincipal, DMPrincipal);
  Application.CreateForm(TFprincipal, Fprincipal);
  Application.CreateForm(TFFaturamento, FFaturamento);
  Application.CreateForm(TFApuracao, FApuracao);
  Application.CreateForm(TFConfiguracao, FConfiguracao);
  Application.Run;
end.
