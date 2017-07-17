program Servidor_TesteJSON;
{$APPTYPE GUI}

{$R *.dres}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  uDashBoard in 'uDashBoard.pas' {FDashBoard},
  uService in 'uService.pas',
  uWebModule in 'uWebModule.pas' {WebMod: TWebModule},
  uDmPrincipal in 'uDmPrincipal.pas' {DMPrincipal: TDataModule},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TFDashBoard, FDashBoard);
  Application.CreateForm(TDMPrincipal, DMPrincipal);
  Application.Run;
end.
