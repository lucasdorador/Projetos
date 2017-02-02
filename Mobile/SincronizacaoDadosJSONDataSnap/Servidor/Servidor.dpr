program Servidor;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  FormUnit1 in 'FormUnit1.pas' {Form1},
  ServerMethodsUnit1 in 'ServerMethodsUnit1.pas' {ServerMethods1: TDSServerModule},
  WebModuleUnit1 in 'WebModuleUnit1.pas' {WebModule1: TWebModule},
  ClientClassesUnit1 in '..\ClienteREST\ClientClassesUnit1.pas',
  ClientModuleUnit1 in '..\ClienteREST\ClientModuleUnit1.pas' {ClientModule1: TDataModule};

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TClientModule1, ClientModule1);
  Application.Run;
end.
