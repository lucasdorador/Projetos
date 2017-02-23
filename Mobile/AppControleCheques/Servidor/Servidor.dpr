program Servidor;
{$APPTYPE GUI}

{$R *.dres}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  uServidor in 'uServidor.pas' {FServidor},
  ServerMethodsUnit1 in 'ServerMethodsUnit1.pas' {ServerMethods1: TDataModule},
  ServerContainerUnit1 in 'ServerContainerUnit1.pas' {ServerContainer1: TDataModule},
  WebModuleUnit1 in 'WebModuleUnit1.pas' {WebModule1: TWebModule},
  Vcl.Themes,
  Vcl.Styles,
  UFuncoesServer in '..\App\Class\UFuncoesServer.pas',
  CCR.PrefsIniFile.Android in '..\..\Classes Android\CCR.PrefsIniFile.Android.pas',
  CCR.PrefsIniFile.Apple in '..\..\Classes Android\CCR.PrefsIniFile.Apple.pas',
  CCR.PrefsIniFile in '..\..\Classes Android\CCR.PrefsIniFile.pas',
  DSSupportClasses in '..\..\Classes Android\DSSupportClasses.pas',
  UManipulacaoINI in '..\..\Classes Android\UManipulacaoINI.pas',
  uClassBancoDados in 'Class\uClassBancoDados.pas',
  uCriacaoComponentes in 'Class\uCriacaoComponentes.pas';

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TFServidor, FServidor);
  Application.Run;
end.
