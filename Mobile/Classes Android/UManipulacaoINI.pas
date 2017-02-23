unit UManipulacaoINI;

interface

uses
   FireDAc.Comp.Client, System.SysUtils, System.IniFiles;

type
   vtTipoRetono = (vtpDB , vtpHOST);

type
  TManipulacaoINI = class(TObject)
    private
      FServidor : String;
      FUsuario  : String;
      FSenha    : String;
      FPorta    : Integer;
      FDatabase : String;
      FDriver   : String;
      FPath     : String;
      FSecao    : String;
      function fncDATABASE(vlTipoRetornoDBouHost : vtTipoRetono; vlDatabase:String) : String;

    public
      constructor Create(Path: string; Secao: string);
      procedure Conectar(var Conexao: TFDConnection); virtual;
      procedure LeINIDbx; virtual;

  end;

implementation

{ TManipulacaoINI }

procedure TManipulacaoINI.Conectar(var Conexao: TFDConnection);
begin
LeINIDbx;

try
//Passa os parâmetros para o objeto Conexão
Conexao.Connected   := False;
Conexao.LoginPrompt := False;
Conexao.Params.Clear;
Conexao.Params.Add('hostname='+ FServidor);
Conexao.Params.Add('user_name='+ FUsuario);
Conexao.Params.Add('password='+ FSenha);
Conexao.Params.Add('port='+ IntToStr(FPorta));
Conexao.Params.Add('Database='+ FDatabase);
Conexao.Params.Add('DriverID='+ FDriver);
Except
   on E:Exception do
      raise Exception.Create('Erro ao carregar parâmetros de conexão!'#13#10 + E.Message);
   end;
end;

constructor TManipulacaoINI.Create(Path, Secao: string);
begin
if FileExists(Path) then
   begin
   FPath  := Path;
   FSecao := Secao;
   end
else
   raise Exception.Create('Arquivo INI para configuração não encontrado.'#13#10'Aplicação será finalizada.');
end;

function TManipulacaoINI.fncDATABASE(vlTipoRetornoDBouHost: vtTipoRetono;
  vlDatabase: String): String;
var
   i : Integer;
   vlAchou : Boolean;
   vlRetorno : String;
begin
vlAchou := False;
vlRetorno := '';
if vlTipoRetornoDBouHost = vtpHOST then
   begin
   for i := 1 to Length(vlDatabase) do
      begin
      if Copy(vlDatabase, i,1) = ':' then
         begin
         break;
         end;

      if not vlAchou then
         vlRetorno := vlRetorno + Copy(vlDatabase, i,1);
      end;
   end
else if vlTipoRetornoDBouHost = vtpDB then
   begin
   for i := 1 to Length(vlDatabase) do
      begin
      if vlAchou then
         vlRetorno := vlRetorno + Copy(vlDatabase, i,1);

      if Copy(vlDatabase, i,1) = ':' then
         begin
         vlAchou := True;
         end;
      end;
   end;
Result := vlRetorno;
end;

procedure TManipulacaoINI.LeINIDbx;
var
    ArqIni : TIniFile;
begin
ArqIni := TIniFile.Create(FPath);
try
FServidor    := fncDATABASE(vtpHOST, ArqIni.ReadString(FSecao, 'Database', ''));
FPorta       := 3050;
FDatabase    := fncDATABASE(vtpDB, ArqIni.ReadString(FSecao, 'Database', ''));
FSenha       := ArqIni.ReadString(FSecao, 'Password', '');
FUsuario     := ArqIni.ReadString(FSecao, 'User_Name', '');
FDriver      := 'FB';
finally
   FreeAndNil(ArqIni);
   end;
end;

end.
