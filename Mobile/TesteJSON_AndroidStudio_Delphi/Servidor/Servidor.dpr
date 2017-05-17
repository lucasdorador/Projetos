program Servidor;
{$APPTYPE GUI}

{$R *.dres}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  uDashBoard in 'uDashBoard.pas' {Form1},
  uService in 'uService.pas',
  uWebModule in 'uWebModule.pas' {WebMod: TWebModule},
  uDmPrincipal in 'uDmPrincipal.pas' {DMPrincipal: TDataModule},
  DataSetConverter4D.Helper in '..\..\DataSetConverter4Delphi-master\src\DataSetConverter4D.Helper.pas',
  DataSetConverter4D.Impl in '..\..\DataSetConverter4Delphi-master\src\DataSetConverter4D.Impl.pas',
  DataSetConverter4D in '..\..\DataSetConverter4Delphi-master\src\DataSetConverter4D.pas',
  DataSetConverter4D.Util in '..\..\DataSetConverter4Delphi-master\src\DataSetConverter4D.Util.pas',
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TDMPrincipal, DMPrincipal);
  Application.Run;
end.
