program TDPApuraImpostos;

uses
  Vcl.Forms,
  uImpostos in 'uImpostos.pas' {FImpostos},
  UConfiguracao in '..\Class\UConfiguracao.pas',
  uConstantes in '..\Class\uConstantes.pas',
  uConsultas in '..\Class\uConsultas.pas',
  uProcessamento in '..\Class\uProcessamento.pas',
  uDMPrincipal in 'uDMPrincipal.pas' {DMPrincipal: TDataModule},
  uCRUDApuracao in '..\Class\uCRUDApuracao.pas',
  uRelatorios in '..\Class\uRelatorios.pas',
  uVariaveisRelatorio in '..\Class\uVariaveisRelatorio.pas',
  uComplementos in 'uComplementos.pas' {FComplementos};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFImpostos, FImpostos);
  Application.CreateForm(TDMPrincipal, DMPrincipal);
  Application.CreateForm(TFComplementos, FComplementos);
  Application.Run;
end.
