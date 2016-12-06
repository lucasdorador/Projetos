program TDPApuraImpostos;

uses
  Vcl.Forms,
  uImpostos in 'uImpostos.pas' {FImpostos};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFImpostos, FImpostos);
  Application.Run;
end.
