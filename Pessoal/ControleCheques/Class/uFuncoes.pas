unit uFuncoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons,
  Vcl.ExtDlgs, IniFiles, Data.SqlExpr, FireDAc.Comp.Client;

  procedure GravaINIBanco(Caminho:String;Usuario:String;Senha:String);
  procedure GravaFireDAcConection(Caminho:String;Usuario:String;Senha:String);
  procedure LerINIBanco;
  function MensagemSistema(Tipo:String;Mensagem:String) : string;
  procedure ChamaTabela(Tabela: String);
  function DomainExists(Conexao: TSQLConnection; Domain: String): boolean;
  function TableExists(Conexao: TFDConnection; TableName: string): Boolean;
  function FieldExists(Conexao: TFDConnection; Table: String; Field: String): boolean;
  function IndexExists(Conexao: TFDConnection; Index: String): boolean;
  procedure pcdCriaParametrosConexaoFireDAc(vgsDataBase, vgUsuario, vgSenha: String; var poConnection: TFDConnection);
  function fncPesquisaBanco(poConexao : TFDConnection; psBanco : String): String;
  function fncPesquisaContaCorrente(poConexao : TFDConnection; psContaCorrente, psBanco : String): String;

implementation

uses uVariaveis;

function MensagemSistema(Tipo:String;Mensagem:String) : string;
begin
   if Tipo = 'Informação' then
      MessageDlg(Mensagem, mtInformation, [mbOK], 0);
end;

procedure GravaINIBanco(Caminho:String;Usuario:String;Senha:String);
var
   ArqINI : TIniFile;
begin
   ArqINI := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'ConfigBanco.ini');
try
   ArqINI.WriteString('DFSISTEMAS','CaminhoBanco', ExtractFilePath(Application.ExeName) + 'DFSISTEMAS.FDB');
   ArqINI.WriteString('DFSISTEMAS','User_Name',    'SYSDBA');
   ArqINI.WriteString('DFSISTEMAS','Password',     'masterkey');
finally
   ArqINI.Free;
end;
end;

procedure LerINIBanco;
var
   ArqINI : TIniFile;
begin
if not FileExists(ExtractFilePath(Application.ExeName) + 'ConfigBanco.ini') then
   begin
   MensagemSistema('Informação', 'Não encontrei o arquivo ConfigBanco, se for a primeira vez que acessa grave as configurações.');
   Abort;
   end;

ArqINI := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'ConfigBanco.ini');
try
   vgCaminhoBanco := ArqINI.ReadString('DFSISTEMAS', 'CaminhoBanco', '');
   vgUsuarioBanco := ArqINI.ReadString('DFSISTEMAS', 'User_Name', '');
   vgSenhaBanco   := ArqINI.ReadString('DFSISTEMAS', 'Password', '');
finally
   ArqINI.Free;
end;
end;

procedure GravaFireDAcConection(Caminho:String;Usuario:String;Senha:String);
var
   ArqINI : TIniFile;
begin
ArqINI:=TIniFile.Create(ExtractFilePath(Application.ExeName)+'dbxconnections.ini');
try
   ArqINI.WriteString('DFSISTEMAS', 'Database', 'localhost:'+Caminho);
   ArqINI.WriteString('DFSISTEMAS', 'User_Name',Usuario);
   ArqINI.WriteString('DFSISTEMAS', 'Password', Senha);
   ArqINI.WriteString('DFSISTEMAS', 'SQLDialect', '3');
   ArqINI.WriteString('DFSISTEMAS', 'DriverName', 'Firebird');
   ArqINI.WriteString('DFSISTEMAS', 'BlobSise', '-1');
   ArqINI.WriteString('DFSISTEMAS', 'CommitRetain', 'False');
   ArqINI.WriteString('DFSISTEMAS', 'WaitOnLocks', 'True');
   ArqINI.WriteString('DFSISTEMAS', 'LocaleCode', '0000');
   ArqINI.WriteString('DFSISTEMAS', 'Interbase Translsolation', 'ReadCommited');
   ArqINI.WriteString('DFSISTEMAS', 'Trim Char', 'True');
finally
   ArqINI.Free;
   end;
end;

procedure ChamaTabela(Tabela: String);
begin
//FProcessamento.GroupBox1.CAPTION:='Criando : '+Tabela;
APPLICATION.HANDLEMESSAGE;
APPLICATION.ProcessMessages;
end;

function DomainExists(Conexao: TSQLConnection; Domain: String): boolean;
var
  VLqry: TSQLQuery;
begin
try
Conexao.Open;
VLqry := TSQLQuery.Create(nil);
VLqry.SQLConnection := Conexao;
VLqry.Close;
VLqry.SQL.Clear;
VLqry.SQL.Text := 'select RDB$FIELD_NAME from RDB$FIELDS '+
                  'where RDB$FIELD_NAME ='+ QuotedStr(Domain);
VLqry.Open;
if not VLqry.IsEmpty then
   Result := true
else
   Result := False;
finally
   VLqry.Close;
   FreeAndNil(VLqry);
   end;
end;

function TableExists(Conexao: TFDConnection; TableName: string): Boolean;
var
   VlList: TStrings;
   Vli   : integer;
   VlErro: Exception;
begin
Result := False;
VlList := TStringList.Create;
try
try
Conexao.Open;
//Conexao.GetTableNames(VlList);

for Vli := 0 to VlList.Count - 1 do
   begin
   if UpperCase(VlList.Strings[Vli]) = UpperCase(TableName) then
      Result := True;
   end;

finally
   //Conexao.Close;
   VlList.Free;
   end;
except
   on Exception do
      ShowMessage(Vlerro.Message);
   end;
end;

function FieldExists(Conexao: TFDConnection; Table: String; Field: String): boolean;
var
  VLqry: TFDQuery;
begin
try
   Result := False;
   Conexao.Open;
   VLqry := TFDQuery.Create(nil);
   VLqry.Connection := Conexao;
   VLqry.Close;
   VLqry.SQL.Clear;
   VLqry.SQL.Text := 'select RDB$FIELD_NAME from RDB$RELATION_FIELDS '+
                     'where RDB$RELATION_NAME ='+ QuotedStr(Table) + ' and '+
                     'RDB$FIELD_NAME = ' + QuotedStr(Field);
   VLqry.Open;
   If not VLqry.isempty then
      Result := true;
finally
   VLqry.Close;
   FreeAndNil(VLqry);
   end;
end;

function IndexExists(Conexao: TFDConnection; Index: String): boolean;
var
  VLqry: TFDQuery;
begin
try
   Conexao.Open;
   VLqry := TFDQuery.Create(nil);
   VLqry.Connection := Conexao;
   VLqry.Close;
   VLqry.SQL.Clear;
   VLqry.SQL.Text := 'select RDB$INDEX_NAME from RDB$INDICES '+
                     'where RDB$INDEX_NAME ='+ QuotedStr(Index);
   VLqry.Open;
   if not VLqry.IsEmpty then
      Result := true
   else
      Result := False;

finally
   VLqry.Close;
   FreeAndNil(VLqry);
   end;
end;

procedure pcdCriaParametrosConexaoFireDAc(vgsDataBase, vgUsuario, vgSenha: String; var poConnection: TFDConnection);
begin
poConnection.DriverName := 'FB';
poConnection.Params.Add('Database='+vgsDataBase);
poConnection.Params.Add('User_name='+vgUsuario);
poConnection.Params.Add('Password='+vgSenha);
poConnection.Params.Add('Protocol=Local');
//poConnection.Params.Add('Server='+vgsDataBase);
poConnection.Params.Add('SQLDialect=3');
poConnection.Params.Add('CharacterSet=WIN1252');
end;

function fncPesquisaBanco(poConexao : TFDConnection; psBanco : String): String;
var
   QConsultas : TFDQuery;
begin
QConsultas := TFDQuery.Create(nil);

try
QConsultas.Close;
QConsultas.Connection := poConexao;
QConsultas.SQL.Clear;
QConsultas.SQL.Add('SELECT BC_DESCRICAO FROM BANCOS WHERE BC_CODIGO = :CODIGO');
QConsultas.ParamByName('CODIGO').AsString := psBanco;
QConsultas.Open;

Result := QConsultas.FieldByName('BC_DESCRICAO').AsString;

finally
   FreeAndNil(QConsultas);
   end;
end;

function fncPesquisaContaCorrente(poConexao : TFDConnection; psContaCorrente, psBanco : String): String;
var
   QConsultas : TFDQuery;
begin
QConsultas := TFDQuery.Create(nil);

try
QConsultas.Close;
QConsultas.Connection := poConexao;
QConsultas.SQL.Clear;
QConsultas.SQL.Add('SELECT CC_DESCRICAO FROM CONTAS WHERE CC_NUMERO = :NUMERO AND CC_BANCO = :BANCO');
QConsultas.ParamByName('NUMERO').AsString := psContaCorrente;
QConsultas.ParamByName('BANCO').AsString  := psBanco;
QConsultas.Open;

Result := QConsultas.FieldByName('CC_DESCRICAO').AsString;

finally
   FreeAndNil(QConsultas);
   end;
end;

end.
