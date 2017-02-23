unit uFuncoesApp;

interface

uses
   uClassPODO, System.IniFiles, System.SysUtils, CCR.PrefsIniFile,
   Datasnap.DSClientRest;

type
   TConfiguraREST = class(TObject)
   public
      class procedure configuracaoREST(poDadosConfig: TConfiguracaoApp; var poRestConnection: TDSRestConnection);
   end;

type
   TGravaConfiguracoesINI = Class(Tobject)
    class procedure pcdGravaConfigApp(poDadosConfig: TConfiguracaoApp);
    class function pcdLerConfigApp : TConfiguracaoApp;

   End;

implementation

{ TGravaConfiguracoesINI }

class procedure TGravaConfiguracoesINI.pcdGravaConfigApp(
  poDadosConfig: TConfiguracaoApp);
var
  Settings: TCustomIniFile;
begin
Settings := CreateUserPreferencesIniFile;
try
Settings.WriteString('ConfigApp', 'Endereco', poDadosConfig.psEnderecoIP);
Settings.WriteString('ConfigApp', 'Porta', poDadosConfig.psPortaConexao);
finally
   FreeAndNil(Settings);
   end;
end;

class function TGravaConfiguracoesINI.pcdLerConfigApp: TConfiguracaoApp;
var
  Settings     : TCustomIniFile;
  vloConfigApp : TConfiguracaoApp;
begin
Settings := CreateUserPreferencesIniFile;
try
vloConfigApp := TConfiguracaoApp.Create;
vloConfigApp.psEnderecoIP   := Settings.ReadString('ConfigApp', 'Endereco', vloConfigApp.psEnderecoIP);
vloConfigApp.psPortaConexao := Settings.ReadString('ConfigApp', 'Porta', vloConfigApp.psPortaConexao);
result := vloConfigApp;
finally
   FreeAndNil(Settings);
   end;
end;

{ TConfiguraREST }

class procedure TConfiguraREST.configuracaoREST(poDadosConfig: TConfiguracaoApp;
  var poRestConnection: TDSRestConnection);
begin
poRestConnection.Host := poDadosConfig.psEnderecoIP;
poRestConnection.Port := StrToInt(poDadosConfig.psPortaConexao);
end;

end.
