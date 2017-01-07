program TDPApuraImpostos;

uses
  Vcl.Forms,
  uImpostos in 'uImpostos.pas' {FImpostos},
  UConfiguracao in '..\Class\UConfiguracao.pas',
  uConstantes in '..\Class\uConstantes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFImpostos, FImpostos);
  Application.Run;
end.
