unit UConexao;

{$ALIGN ON}
{$MINENUMSIZE 4}
{$WEAKPACKAGEUNIT}

interface

uses FireDAC.Comp.Client, System.SysUtils, System.IniFiles, Vcl.Forms,
     FireDAC.Phys.IBWrapper, Vcl.Dialogs, FireDAC.Stan.Def, FireDAC.Phys.FB,
     FireDAC.Comp.UI, FireDAC.Stan.Async, Data.SqlExpr, Winapi.Windows;

type
   TConexao = class(TObject)
   private
      FConexao : TFDConnection;
      vgsDataBase, vgsUsuario, vgsSenha, vgsSQLDialect,
      vgsServer: String;
      procedure pcdCriaParametrosConexaoFireDAc(var poConnection: TFDConnection);
   public
      constructor Create;
      destructor Destroy; override;
      Function getConnection :TFDConnection;
      procedure LerIniConexao;

   end;

implementation

{ TConexao }

constructor TConexao.Create;
begin
LerIniConexao;

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
end;

destructor TConexao.Destroy;
begin
inherited;
end;

function TConexao.getConnection: TFDConnection;
begin
Result := FConexao;
end;

procedure TConexao.LerIniConexao;
var
  vlIni : TiniFile;
  I: Integer;
begin
try
if FileExists(ExtractFilePath(Application.ExeName) + 'dbxconnections.ini') then
   vlIni := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'dbxconnections.ini')
else
   raise Exception.Create('Não foi possível localizar o arquivo "dbxconnections.ini" na pasta: '+ExtractFilePath(Application.ExeName));

vgsDataBase   := vlIni.ReadString('LANCAMENTO_HORAS', 'Database', '');
vgsUsuario    := vlIni.ReadString('LANCAMENTO_HORAS', 'User_Name', '');
vgsSenha      := vlIni.ReadString('LANCAMENTO_HORAS', 'Password', '');
vgsSQLDialect := vlIni.ReadString('LANCAMENTO_HORAS', 'SQLDialect', '');

for I := 1 to Length(vgsDataBase) do
   begin
   if Copy(vgsDataBase, I, 1) <> ':' then
      vgsServer := vgsServer + Copy(vgsDataBase, I, 1)
   else
      Break;
   end;

finally
   if Assigned(vlIni) then
      FreeAndNil(vlIni);
   end;
end;

procedure TConexao.pcdCriaParametrosConexaoFireDAc(
  var poConnection: TFDConnection);
begin
poConnection.DriverName := 'FB';
poConnection.Params.Add('Database='+vgsDataBase);
poConnection.Params.Add('DriverID=FB');
poConnection.Params.Add('User_name='+vgsUsuario);
poConnection.Params.Add('Password='+vgsSenha);
poConnection.Params.Add('Protocol=TCPIP');
poConnection.Params.Add('Server='+vgsServer);
poConnection.Params.Add('SQLDialect='+vgsSQLDialect);
poConnection.Params.Add('CharacterSet=WIN1252');
end;

end.
