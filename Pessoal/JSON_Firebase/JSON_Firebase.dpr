program JSON_Firebase;

uses
  System.StartUpCopy,
  FMX.Forms,
  uPrincipal in 'uPrincipal.pas' {FPrincipal},
  udmPrincipal in 'udmPrincipal.pas' {dmPrincipal: TDataModule},
  uMenuInicial in 'uMenuInicial.pas' {FMenuInicial},
  uConstantes in 'uConstantes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFMenuInicial, FMenuInicial);
  Application.CreateForm(TFPrincipal, FPrincipal);
  Application.CreateForm(TdmPrincipal, dmPrincipal);
  Application.Run;
end.
