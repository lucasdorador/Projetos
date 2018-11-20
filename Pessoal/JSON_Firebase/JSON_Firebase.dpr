program JSON_Firebase;

uses
  System.StartUpCopy,
  FMX.Forms,
  uPrincipal in 'uPrincipal.pas' {FPrincipal};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFPrincipal, FPrincipal);
  Application.Run;
end.
