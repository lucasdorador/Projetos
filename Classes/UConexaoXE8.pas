unit UConexaoXE8;

{$ALIGN ON}
{$MINENUMSIZE 4}
{$WEAKPACKAGEUNIT}

interface

uses FireDAC.Comp.Client, System.SysUtils, System.IniFiles, Vcl.Forms,
     FireDAC.Phys.IBWrapper, Vcl.Dialogs, FireDAC.Stan.Def, FireDAC.Phys.FB,
     FireDAC.Comp.UI, FireDAC.Stan.Async, Winapi.Windows;

type
   TConexaoXE8 = class(TObject)
   private { private declarations }
      FConexao : TFDConnection;
      FConexaoBANCOS : TFDConnection;
      vgsDataBase, vgsDBXBase, vgsUsuario, vgsSenha, vgsSQLDialect,
      vgsServer, vgsDataBaseBANCOS, vgsUsuarioBANCOS, vgsSenhaBANCOS, vgsSQLDialectBANCOS,
      vgsServerBANCOS : String;
      procedure pcdCriaParametrosConexaoFireDAc(var poConnection: TFDConnection);
      procedure pcdCriaParametrosConexaoBancos(var poConnection: TFDConnection);
   protected { protected declarations }

   public { public declarations }
      constructor Create;
      destructor Destroy; override;
      Function getConnection :TFDConnection;
      Function getConnectionBancos : TFDConnection;
      procedure LerIniConexao;
      function fncCriarQuery(Conexao:TFDConnection):TFDQuery;
   published { published declarations }

   end;

implementation

{ TConexaoXE8 }

constructor TConexaoXE8.Create;
begin
LerIniConexao;

// Conexão com o FIREBIRD COMÉRCIO - FireDac
FConexao    := TFDConnection.Create(Application);
vgsDataBase := Copy(vgsDataBase, Length(vgsServer) + 2, Length(vgsDataBase));
pcdCriaParametrosConexaoFireDAc(FConexao);
try
   FConexao.Open;
except
   on e : EIBNativeException  do
      begin
      ShowMessage('Não foi possível efetuar a conexão. Erro: ' + e.Message);
        FConexao := nil;
      end;
   end;

// Conexão com o FIREBIRD BANCOS
FConexaoBANCOS := TFDConnection.Create(Application);
vgsDataBaseBANCOS := Copy(vgsDataBaseBANCOS, Length(vgsServerBANCOS) + 2, Length(vgsDataBaseBANCOS));
pcdCriaParametrosConexaoBancos(FConexaoBANCOS);

try
   FConexaoBANCOS.Open;
except
   on e : EIBNativeException  do
      begin
        ShowMessage('Não foi possível efetuar a conexão. Erro: ' + e.Message);
        FConexaoBANCOS := nil;
      end;
   end;
end;

destructor TConexaoXE8.Destroy;
begin

inherited;
end;

function TConexaoXE8.fncCriarQuery(Conexao: TFDConnection): TFDQuery;
Var
 VlFDQuery:TFDQuery;
begin
VlFDQuery := TFDQuery.Create(Nil);
VlFDQuery.Connection := FConexao;
Try
   VlFDQuery.Close;
   VlFDQuery.SQL.Clear;
Finally
   Result := VlFDQuery;
   End;
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
vgsDBXBase    := vlIni.ReadString('FACILITE', 'Database', '');
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

procedure TConexaoXE8.pcdCriaParametrosConexaoBancos(
  var poConnection: TFDConnection);
begin
poConnection.DriverName := 'FB';
poConnection.Params.Add('Database='+vgsDataBaseBANCOS);
poConnection.Params.Add('User_name='+vgsUsuarioBANCOS);
poConnection.Params.Add('Password='+vgsSenhaBANCOS);
poConnection.Params.Add('Protocol=TCPIP');
poConnection.Params.Add('Server='+vgsServerBANCOS);
poConnection.Params.Add('SQLDialect='+vgsSQLDialectBANCOS);
poConnection.Params.Add('CharacterSet=WIN1252');
end;

procedure TConexaoXE8.pcdCriaParametrosConexaoFireDAc(
  var poConnection: TFDConnection);
begin
poConnection.DriverName := 'FB';
poConnection.Params.Add('Database='+vgsDataBase);
poConnection.Params.Add('User_name='+vgsUsuario);
poConnection.Params.Add('Password='+vgsSenha);
poConnection.Params.Add('Protocol=TCPIP');
poConnection.Params.Add('Server='+vgsServer);
poConnection.Params.Add('SQLDialect='+vgsSQLDialect);
poConnection.Params.Add('CharacterSet=WIN1252');
end;

end.
