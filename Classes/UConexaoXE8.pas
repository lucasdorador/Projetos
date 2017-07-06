unit UConexaoXE8;

{$ALIGN ON}
{$MINENUMSIZE 4}
{$WEAKPACKAGEUNIT}

interface

uses FireDAC.Comp.Client, System.SysUtils, System.IniFiles, Vcl.Forms,
     FireDAC.Phys.IBWrapper, Vcl.Dialogs, FireDAC.Stan.Def, FireDAC.Phys.FB,
     FireDAC.Comp.UI, FireDAC.Stan.Async, Data.SqlExpr, Winapi.Windows;

type
   TTipoConexao = (ttcParadox,ttcFirebird);
type
   TConexaoXE8 = class(TObject)
   private { private declarations }
      FNomeConexao:String;
      FConexaoPadrao:Boolean;
      FConexao : TFDConnection;
      FDBXConexao: TSQLConnection;
      FConexaoBANCOS : TFDConnection;
      vgsDataBase, vgsDBXBase, vgsUsuario, vgsSenha, vgsSQLDialect,
      vgsServer, vgsDataBaseBANCOS, vgsUsuarioBANCOS, vgsSenhaBANCOS, vgsSQLDialectBANCOS,
      vgsServerBANCOS : String;
      procedure pcdCriaParametrosConexaoFireDAc(var poConnection: TFDConnection);
      procedure pcdCriaParametrosConexaoDBExpress(var poSQLConnection: TSQLConnection);
      procedure pcdCriaParametrosConexaoBancos(var poConnection: TFDConnection);
   protected { protected declarations }

   public { public declarations }
      constructor Create(psNomeConexao:string = 'FACILITE'); overload;
      constructor Create(pBFiredac: Boolean; psNomeConexao:string = 'FACILITE'); overload ;
      destructor Destroy; override;
      Function getConnection :TFDConnection;
      Function getSQLConnection :TSQLConnection;
      Function getConnectionBancos : TFDConnection;
      procedure LerIniConexao;
      function fncRetornarTipoConexao:TTipoConexao;
      function fncCriarQuery(Conexao:TFDConnection):TFDQuery;
   published { published declarations }

   end;

implementation

{ TConexaoXE8 }

constructor TConexaoXE8.Create(psNomeConexao:string = 'FACILITE');
begin
FNomeConexao := psNomeConexao;
if FNomeConexao <> 'FACILITE' then
   FConexaoPadrao := False
Else
   FConexaoPadrao := True;
LerIniConexao;

// Conexão com o FIREBIRD COMÉRCIO - FireDac
FConexao := TFDConnection.Create(Application);
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

if FConexaoPadrao then
   Begin
   try
      // Conexão com o FIREBIRD COMÉRCIO - DBX
      FDBXConexao := TSQLConnection.Create(Nil);
      vgsDataBase := Copy(vgsDataBase, Length(vgsServer) + 2, Length(vgsDataBase));
      pcdCriaParametrosConexaoDBExpress(FDBXConexao);
      try
         FDBXConexao.Open;
      except
         on e : EIBNativeException  do
            begin
              ShowMessage('Não foi possível efetuar a conexão. Erro: ' + e.Message);
              FDBXConexao := nil;
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
   Except
      End;
   end;
end;

constructor TConexaoXE8.Create(pBFiredac: Boolean; psNomeConexao: string);
begin
FNomeConexao := psNomeConexao;
if FNomeConexao <> 'FACILITE' then
   FConexaoPadrao := False
Else
   FConexaoPadrao := True;
LerIniConexao;

// Conexão com o FIREBIRD COMÉRCIO - FireDac
FConexao := TFDConnection.Create(Application);
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

destructor TConexaoXE8.Destroy;
begin
//if Assigned(FDBXConexao) then
//   FreeAndNil(FDBXConexao);
//
//if Assigned(FConexao) then
//   FreeAndNil(FConexao);
//
//if Assigned(FConexaoBANCOS) then
//   FreeAndNil(FConexaoBANCOS);
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

function TConexaoXE8.fncRetornarTipoConexao: TTipoConexao;
Var
   VlArqINI: String ;
   VlINI : TIniFile ;
   VlSNome:String;
begin
VlArqINI := ChangeFileExt(ExtractFilePath(Application.ExeName) + 'ConfigBanco','.ini');
VlINI := TIniFile.Create(VlArqINI);
try
   VlSNome := VlINI.ReadString('BANCO','Nome',VlSNome);
   If Trim(VlSNome) <> '' Then
      Begin
      If Trim(VlSNome) = 'FACILITEfb' Then
         Result := ttcFirebird
      Else
         Result := ttcParadox;
      End
   Else
      Result := ttcParadox;
finally
   VlINI.Free ;
   end;
end;

function TConexaoXE8.getConnection: TFDConnection;
begin
Result := FConexao;
end;

function TConexaoXE8.getSQLConnection: TSQLConnection;
begin
Result := FDBXConexao;
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

vgsDataBase   := vlIni.ReadString(FNomeConexao, 'Database', '');
vgsDBXBase    := vlIni.ReadString(FNomeConexao, 'Database', '');
vgsUsuario    := vlIni.ReadString(FNomeConexao, 'User_Name', '');
vgsSenha      := vlIni.ReadString(FNomeConexao, 'Password', '');
vgsSQLDialect := vlIni.ReadString(FNomeConexao, 'SQLDialect', '');

//vgsDataBase   := vlIni.ReadString('FACILITE', 'Database', '');
//vgsDBXBase    := vlIni.ReadString('FACILITE', 'Database', '');
//vgsUsuario    := vlIni.ReadString('FACILITE', 'User_Name', '');
//vgsSenha      := vlIni.ReadString('FACILITE', 'Password', '');
//vgsSQLDialect := vlIni.ReadString('FACILITE', 'SQLDialect', '');

//Lendo INI Conexão BANCOS
if FConexaoPadrao then
   Begin
   if FileExists(ExtractFilePath(Application.ExeName) + 'Bancos\dbxconnections.ini') then
      vlIni := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'Bancos\dbxconnections.ini')
   else
      raise Exception.Create('Não foi possível localizar o arquivo "dbxconnections.ini" na pasta: '+ExtractFilePath(Application.ExeName) + 'Bancos');

   vgsDataBaseBANCOS   := vlIni.ReadString('FACILITEBANCOS', 'Database', '');
   vgsUsuarioBANCOS    := vlIni.ReadString('FACILITEBANCOS', 'User_Name', '');
   vgsSenhaBANCOS      := vlIni.ReadString('FACILITEBANCOS', 'Password', '');
   vgsSQLDialectBANCOS := vlIni.ReadString('FACILITEBANCOS', 'SQLDialect', '');
   End;

for I := 1 to Length(vgsDataBase) do
   begin
   if Copy(vgsDataBase, I, 1) <> ':' then
      vgsServer := vgsServer + Copy(vgsDataBase, I, 1)
   else
      Break;
   end;
if FConexaoPadrao then
   Begin
   for I := 1 to Length(vgsDataBaseBANCOS) do
      begin
      if Copy(vgsDataBaseBANCOS, I, 1) <> ':' then
         vgsServerBANCOS := vgsServerBANCOS + Copy(vgsDataBaseBANCOS, I, 1)
      else
         Break;
      end;
   End;

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

procedure TConexaoXE8.pcdCriaParametrosConexaoDBExpress(
  var poSQLConnection: TSQLConnection);
begin
poSQLConnection.Close;
poSQLConnection.DriverName := 'Interbase Server';
poSQLConnection.ConnectionName := FNomeConexao;
poSQLConnection.LoginPrompt := False;
poSQLConnection.Params.Clear;
poSQLConnection.Params.Add('DriverUnit=Data.DBXFirebird');
poSQLConnection.Params.Add('DriverPackageLoader=TDBXDynalinkDriverLoader,DbxCommonDriver220.bpl');
poSQLConnection.Params.Add('DriverAssemblyLoader=Borland.Data.TDBXDynalinkDriverLoader,Borland.Data.DbxCommonDriver,Version=22.0.0.0,Culture=neutral,PublicKeyToken=91d62ebb5b0d1b1b');
poSQLConnection.Params.Add('MetaDataPackageLoader=TDBXFirebirdMetaDataCommandFactory,DbxFirebirdDriver220.bpl');
poSQLConnection.Params.Add('MetaDataAssemblyLoader=Borland.Data.TDBXFirebirdMetaDataCommandFactory,Borland.Data.DbxFirebirdDriver,Version=22.0.0.0,Culture=neutral,PublicKeyToken=91d62ebb5b0d1b1b');
poSQLConnection.Params.Add('GetDriverFunc=getSQLDriverINTERBASE');
poSQLConnection.Params.Add('LibraryName=dbxfb.dll');
poSQLConnection.Params.Add('LibraryNameOsx=libsqlfb.dylib');
poSQLConnection.Params.Add('VendorLib=fbclient.dll');
poSQLConnection.Params.Add('VendorLibWin64=fbclient.dll');
poSQLConnection.Params.Add('VendorLibOsx=/Library/Frameworks/Firebird.framework/Firebird');
poSQLConnection.Params.Add('Database='+vgsDBXBase);
poSQLConnection.Params.Add('User_Name='+vgsUsuario);
poSQLConnection.Params.Add('Password='+vgsSenha);
poSQLConnection.Params.Add('Role=RoleName');
poSQLConnection.Params.Add('MaxBlobSize=-1');
poSQLConnection.Params.Add('LocaleCode=0000');
poSQLConnection.Params.Add('IsolationLevel=ReadCommitted');
poSQLConnection.Params.Add('SQLDialect='+vgsSQLDialect);
poSQLConnection.Params.Add('CommitRetain=False');
poSQLConnection.Params.Add('WaitOnLocks=True');
poSQLConnection.Params.Add('TrimChar=False');
poSQLConnection.Params.Add('BlobSize=-1');
poSQLConnection.Params.Add('ErrorResourceFile=');
poSQLConnection.Params.Add('RoleName=RoleName');
poSQLConnection.Params.Add('ServerCharSet=');
poSQLConnection.Params.Add('Trim Char=False');
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
