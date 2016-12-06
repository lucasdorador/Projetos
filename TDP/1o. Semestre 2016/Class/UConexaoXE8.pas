unit UConexaoXE8;

interface

uses FireDAC.Comp.Client, System.SysUtils, System.IniFiles, Vcl.Forms,
     FireDAC.Phys.IBWrapper, Vcl.Dialogs, FireDAC.Stan.Def, FireDAC.Phys.FB,
     FireDAC.Comp.UI, FireDAC.Stan.Async;

type
   TConexaoXE8 = class(TObject)
   private { private declarations }
      FConexao : TFDConnection;
      FConexaoBANCOS : TFDConnection;
      vgsDataBase, vgsUsuario, vgsSenha, vgsSQLDialect,
      vgsServer, vgsDataBaseBANCOS, vgsUsuarioBANCOS, vgsSenhaBANCOS, vgsSQLDialectBANCOS,
      vgsServerBANCOS : String;
   protected { protected declarations }

   public { public declarations }
     constructor Create;
     Function getConnection :TFDConnection;
     Function getConnectionBancos : TFDConnection;
     procedure LerIniConexao;
   published { published declarations }

   end;

implementation

{ TConexaoXE8 }

constructor TConexaoXE8.Create;
begin
LerIniConexao;

// Conexão com o FIREBIRD COMÉRCIO
FConexao := TFDConnection.Create(Application);
vgsDataBase := Copy(vgsDataBase, Length(vgsServer) + 2, Length(vgsDataBase));

FConexao.DriverName := 'FB';
FConexao.Params.Add('Database='+vgsDataBase);
FConexao.Params.Add('User_name='+vgsUsuario);
FConexao.Params.Add('Password='+vgsSenha);
FConexao.Params.Add('Protocol=TCPIP');
FConexao.Params.Add('Server='+vgsServer);
FConexao.Params.Add('SQLDialect='+vgsSQLDialect);
FConexao.Params.Add('CharacterSet=WIN1252');

try
   FConexao.Open;
   except
     on e : EIBNativeException  do
        begin
          ShowMessage('Não foi possível efetuar a conexão. Erro: ' +
             e.Message);
          FConexao := nil;
        end;
   end;

// Conexão com o FIREBIRD BANCOS
FConexaoBANCOS := TFDConnection.Create(Application);
vgsDataBaseBANCOS := Copy(vgsDataBaseBANCOS, Length(vgsServerBANCOS) + 2, Length(vgsDataBaseBANCOS));

FConexaoBANCOS.DriverName := 'FB';
FConexaoBANCOS.Params.Add('Database='+vgsDataBaseBANCOS);
FConexaoBANCOS.Params.Add('User_name='+vgsUsuarioBANCOS);
FConexaoBANCOS.Params.Add('Password='+vgsSenhaBANCOS);
FConexaoBANCOS.Params.Add('Protocol=TCPIP');
FConexaoBANCOS.Params.Add('Server='+vgsServerBANCOS);
FConexaoBANCOS.Params.Add('SQLDialect='+vgsSQLDialectBANCOS);
FConexaoBANCOS.Params.Add('CharacterSet=WIN1252');

try
   FConexaoBANCOS.Open;
   except
     on e : EIBNativeException  do
        begin
          ShowMessage('Não foi possível efetuar a conexão. Erro: ' +
             e.Message);
          FConexaoBANCOS := nil;
        end;
   end;
end;

function TConexaoXE8.getConnection: TFDConnection;
begin
Result := FConexao;
end;

function TConexaoXE8.getConnectionBancos: TFDConnection;
begin
Result := FConexaoBANCOS;
end;

procedure TConexaoXE8.LerIniConexao;
var
   vlIni : TiniFile;
  I: Integer;
begin
try
//Lendo INI Conexão COMÉRCIO
if FileExists(ExtractFilePath(Application.ExeName) + 'dbxconnections.ini') then
   vlIni := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'dbxconnections.ini')
else
   raise Exception.Create('Não foi possível localizar o arquivo "dbxconnections.ini" na pasta: '+ExtractFilePath(Application.ExeName));

vgsDataBase   := vlIni.ReadString('FACILITE', 'Database', '');
vgsUsuario    := vlIni.ReadString('FACILITE', 'User_Name', '');
vgsSenha      := vlIni.ReadString('FACILITE', 'Password', '');
vgsSQLDialect := vlIni.ReadString('FACILITE', 'SQLDialect', '');

//Lendo INI Conexão BANCOS

if FileExists(ExtractFilePath(Application.ExeName) + 'Bancos\dbxconnections.ini') then
   vlIni := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'Bancos\dbxconnections.ini')
else
   raise Exception.Create('Não foi possível localizar o arquivo "dbxconnections.ini" na pasta: '+ExtractFilePath(Application.ExeName) + 'Bancos');

vgsDataBaseBANCOS   := vlIni.ReadString('FACILITEBANCOS', 'Database', '');
vgsUsuarioBANCOS    := vlIni.ReadString('FACILITEBANCOS', 'User_Name', '');
vgsSenhaBANCOS      := vlIni.ReadString('FACILITEBANCOS', 'Password', '');
vgsSQLDialectBANCOS := vlIni.ReadString('FACILITEBANCOS', 'SQLDialect', '');

for I := 1 to Length(vgsDataBase) do
   begin
   if Copy(vgsDataBase, I, 1) <> ':' then
      vgsServer := vgsServer + Copy(vgsDataBase, I, 1)
   else
      Break;
   end;

for I := 1 to Length(vgsDataBaseBANCOS) do
   begin
   if Copy(vgsDataBaseBANCOS, I, 1) <> ':' then
      vgsServerBANCOS := vgsServerBANCOS + Copy(vgsDataBaseBANCOS, I, 1)
   else
      Break;
   end;

finally
   if Assigned(vlIni) then
      FreeAndNil(vlIni);
   end;

end;

end.
