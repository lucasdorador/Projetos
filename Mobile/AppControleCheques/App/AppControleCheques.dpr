program AppControleCheques;

uses
  System.StartUpCopy,
  FMX.Forms,
  uControleCheques in 'uControleCheques.pas' {FControleCheques},
  udmPrincipal in 'udmPrincipal.pas' {dmPrincipal: TDataModule},
  uPrincipal in 'uPrincipal.pas' {FPrincipal};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFPrincipal, FPrincipal);
  Application.CreateForm(TFControleCheques, FControleCheques);
  Application.CreateForm(TdmPrincipal, dmPrincipal);
  Application.Run;
end.
