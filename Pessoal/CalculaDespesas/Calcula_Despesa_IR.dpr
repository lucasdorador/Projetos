program Calcula_Despesa_IR;

uses
  Vcl.Forms,
  uCalculaDespesa in 'uCalculaDespesa.pas' {FCalculaDespesa},
  uDMPrincipal in 'uDMPrincipal.pas' {DMPrincipal: TDataModule},
  uCRUDDespesas in 'uCRUDDespesas.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Cálculo de Despesas e DIRPF MEI';
  Application.CreateForm(TFCalculaDespesa, FCalculaDespesa);
  Application.CreateForm(TDMPrincipal, DMPrincipal);
  Application.Run;
end.
