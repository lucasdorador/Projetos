program AppControleCheques;

uses
  System.StartUpCopy,
  FMX.Forms,
  uControleCheques in 'uControleCheques.pas' {FControleCheques},
  udmPrincipal in 'udmPrincipal.pas' {dmPrincipal: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFControleCheques, FControleCheques);
  Application.CreateForm(TdmPrincipal, dmPrincipal);
  Application.Run;
end.
