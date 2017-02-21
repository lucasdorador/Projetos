program AppControleCheques;

uses
  System.StartUpCopy,
  FMX.Forms,
  uControleCheques in 'uControleCheques.pas' {FControleCheques},
  udmPrincipal in 'udmPrincipal.pas' {dmPrincipal: TDataModule},
  uPrincipal in 'uPrincipal.pas' {FPrincipal},
  ClientClassesUnit1 in 'ClientClassesUnit1.pas',
  ClientModuleUnit1 in 'ClientModuleUnit1.pas' {ClientModule1: TDataModule},
  uComunicaServer in 'Class\uComunicaServer.pas',
  uConfiguracao in 'uConfiguracao.pas' {FConfiguracao};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFPrincipal, FPrincipal);
  Application.CreateForm(TFControleCheques, FControleCheques);
  Application.CreateForm(TdmPrincipal, dmPrincipal);
  Application.CreateForm(TClientModule1, ClientModule1);
  Application.CreateForm(TFConfiguracao, FConfiguracao);
  Application.Run;
end.
