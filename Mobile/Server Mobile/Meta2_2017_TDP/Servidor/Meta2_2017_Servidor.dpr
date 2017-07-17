program Meta2_2017_Servidor;
{$APPTYPE GUI}

{$R *.dres}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  uServidor in 'uServidor.pas' {FServidor},
  uServerMethods in 'uServerMethods.pas',
  uServerContainer in 'uServerContainer.pas' {ServerContainer1: TDataModule},
  uWebModule in 'uWebModule.pas' {WebModule1: TWebModule},
  uFuncoes in 'uFuncoes.pas',
  uDMServer in 'uDMServer.pas' {DMServer: TDataModule};

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TFServidor, FServidor);
  Application.CreateForm(TDMServer, DMServer);
  Application.Run;
end.
