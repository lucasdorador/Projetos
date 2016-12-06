unit UConexao;

interface

uses
    IniFiles, SysUtils, Forms, FireDAC.Comp.Client, Dialogs;

type
   TConexao = class
   private
    Fcx_ProtocolFB: String;
    Fcx_SQLDialectFB: String;
    Fcx_DatabaseFB: String;
    Fcx_PasswordFB: String;
    Fcx_UserNameFB: String;
    Fcx_CaminhoINI: String;
    Fcx_Secao: String;
    procedure Setcx_DatabaseFB(const Value: String);
    procedure Setcx_PasswordFB(const Value: String);
    procedure Setcx_ProtocolFB(const Value: String);
    procedure Setcx_SQLDialectFB(const Value: String);
    procedure Setcx_UserNameFB(const Value: String);
    procedure Setcx_CaminhoINI(const Value: String);
    procedure Setcx_Secao(const Value: String);

   public
      property cx_DatabaseFB   : String read Fcx_DatabaseFB write Setcx_DatabaseFB;
      property cx_UserNameFB   : String read Fcx_UserNameFB write Setcx_UserNameFB;
      property cx_PasswordFB   : String read Fcx_PasswordFB write Setcx_PasswordFB;
      property cx_ProtocolFB   : String read Fcx_ProtocolFB write Setcx_ProtocolFB;
      property cx_SQLDialectFB : String read Fcx_SQLDialectFB write Setcx_SQLDialectFB;
      property cx_CaminhoINI   : String read Fcx_CaminhoINI write Setcx_CaminhoINI;
      property cx_Secao        : String read Fcx_Secao write Setcx_Secao;

      constructor Create(Path: string; Secao: string);

      procedure LeINI(); virtual;
      procedure Conectar(var Conexao: TFDConnection); virtual;
   end;


implementation

{ TConexao }

procedure TConexao.Conectar(var Conexao: TFDConnection);
begin
LeINI();

try
   //Passa os parâmetros para o objeto Conexão
   Conexao.Connected   := False;
   Conexao.LoginPrompt := False;
   Conexao.Params.Clear;
   Conexao.Params.Add('Protocol=TCPIP');
   Conexao.Params.Add('User_Name='+ cx_UserNameFB);
   Conexao.Params.Add('password='+ cx_PasswordFB);
   Conexao.Params.Add('Database='+ cx_DatabaseFB);
   Conexao.Params.Add('SQLDialect='+ cx_SQLDialectFB);
   Conexao.Params.Add('DriverID=FB');
   Conexao.Connected := True;
Except
   on E:Exception do
   ShowMessage('Erro ao carregar parâmetros de conexão!'#13#10 + E.Message);
   end;
end;

constructor TConexao.Create(Path, Secao: string);
begin
if FileExists(Path) then
begin
   Self.Fcx_CaminhoINI := Path;
   Self.Fcx_Secao      := Secao;
end
else
   raise Exception.Create('Arquivo INI para configuração não encontrado.'#13#10'Aplicação será finalizada.');
end;

procedure TConexao.LeINI;
var
    ArqIni : TIniFile;
begin
     ArqIni := TIniFile.Create(cx_CaminhoINI);
     try
        cx_DatabaseFB   := ArqIni.ReadString(cx_Secao, 'Database', '');
        cx_PasswordFB   := ArqIni.ReadString(cx_Secao, 'Password', '');
        cx_UserNameFB   := ArqIni.ReadString(cx_Secao, 'User_Name', '');
        cx_SQLDialectFB := ArqIni.ReadString(cx_Secao, 'SQLDialect', '');
        cx_ProtocolFB   := 'TCPIP';
     finally
         ArqIni.Free;
     end;
end;

procedure TConexao.Setcx_CaminhoINI(const Value: String);
begin
  Fcx_CaminhoINI := Value;
end;

procedure TConexao.Setcx_DatabaseFB(const Value: String);
begin
  Fcx_DatabaseFB := Value;
end;

procedure TConexao.Setcx_PasswordFB(const Value: String);
begin
  Fcx_PasswordFB := Value;
end;

procedure TConexao.Setcx_ProtocolFB(const Value: String);
begin
  Fcx_ProtocolFB := Value;
end;

procedure TConexao.Setcx_Secao(const Value: String);
begin
  Fcx_Secao := Value;
end;

procedure TConexao.Setcx_SQLDialectFB(const Value: String);
begin
  Fcx_SQLDialectFB := Value;
end;

procedure TConexao.Setcx_UserNameFB(const Value: String);
begin
  Fcx_UserNameFB := Value;
end;

end.
