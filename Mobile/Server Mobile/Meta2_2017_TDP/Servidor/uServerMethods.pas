unit uServerMethods;

interface

uses System.SysUtils, System.Classes, Datasnap.DSServer, Datasnap.DSAuth,
  System.JSON, uClienteCRUD, uCidades;

type
{$METHODINFO ON}
  TServerMethods1 = class(TComponent)
  private
    { Private declarations }
    vloCliente : TClienteCRUD;
    vloCidade  : TCidades;
  public
    { Public declarations }
    function EchoString(Value: string): string;
    function ReverseString(Value: string): string;
    function Ping: String;
    function fncValidaLogin(psUsuarioSenha: String) : TJSONObject;
    function fncGravarCliente(psDadosCliente: String): TJSONObject;
    function fncExcluiCliente(psCodigo: String): TJSONObject;
    function fncConsultaCliente(psCodigo: String): TJSONObject;
    function fncConsultaCidades(psCidades: String): TJSONObject;
    function fncRetornaUltimoCliente: Integer;
    function fncPing: TJSONObject;
  end;
{$METHODINFO OFF}

implementation


uses System.StrUtils, uServidor, FireDAC.Comp.Client, uDMServer;

function TServerMethods1.EchoString(Value: string): string;
begin
  Result := Value;
end;

function TServerMethods1.ReverseString(Value: string): string;
begin
  Result := System.StrUtils.ReverseString(Value);
end;

function TServerMethods1.fncConsultaCidades(psCidades: String): TJSONObject;
var
   vlJsonObject, vlPropertyJson : TJSONObject;
   vlJsonList:TJsonArray;
   FoCidades : TFDQuery;
begin
vlJsonObject := TJSONObject.Create;
vlJsonList   := TJsonArray.Create;
vloCidade    := TCidades.Create(DMServer.FDConexao);
try
   try
   FoCidades := vloCidade.fncRetornaCidades;

   FoCidades.First;
   FoCidades.FetchAll;

   while not FoCidades.Eof do
      begin
      if TRim(FoCidades.FieldByName('CID_DESCRICAO').AsString) <> '' then
         begin
         vlPropertyJson := TJSONObject.Create;
         vlPropertyJson.AddPair('CID_DESCRICAO', FoCidades.FieldByName('CID_DESCRICAO').AsString);
         vlJsonList.AddElement(vlPropertyJson);
         end;
      FoCidades.Next;
      end;

   vlJsonObject.AddPair('Cidades', vlJsonList);
   Result := vlJsonObject;

   except
      on E:Exception do
         begin
         FServidor.pcdMensagemLOG(E.Message);
         end;
      end;

finally
   FreeAndNil(vloCidade);
   FreeAndNil(FoCidades);
   end;
end;

function TServerMethods1.fncConsultaCliente(psCodigo: String): TJSONObject;
var
   vlJsonObject, vlPropertyJson : TJSONObject;
   vlJsonList:TJsonArray;
   vliCLI_CODIGO : TJSONValue;
   vloClientes : TFDQuery;
   vlbUnicoCliente : Boolean;
begin
vlbUnicoCliente := False;
vlJsonList      := TJsonArray.Create;
vlJsonObject    := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(psCodigo), 0) as TJSONObject;

vliCLI_CODIGO := vlJsonObject.GetValue('CLI_CODIGO') as TJSONValue;
vloCliente    := TClienteCRUD.Create(DMServer.FDConexao);
try
vloCliente.CLI_CODIGO := StrToInt(vliCLI_CODIGO.Value);
try
vloClientes := vloCliente.fncConsultaClientes;

if vloCliente.CLI_CODIGO <> 0 then
   vlbUnicoCliente := True;

vloClientes.First;
vloClientes.FetchAll;

while not vloClientes.Eof do
   begin
   if TRim(vloClientes.FieldByName('CLI_RAZAO').AsString) <> '' then
      begin
      vlPropertyJson := TJSONObject.Create;
      if not vlbUnicoCliente then
         begin
         vlPropertyJson.AddPair('CLI_CODIGO', vloClientes.FieldByName('CLI_CODIGO').AsString);
         vlPropertyJson.AddPair('CLI_RAZAO', vloClientes.FieldByName('CLI_RAZAO').AsString);
         end
      else
         begin
         vlPropertyJson.AddPair('CLI_CODIGO', vloClientes.FieldByName('CLI_CODIGO').AsString);
         vlPropertyJson.AddPair('CLI_RAZAO', vloClientes.FieldByName('CLI_RAZAO').AsString);
         vlPropertyJson.AddPair('CLI_TELEFONE', vloClientes.FieldByName('CLI_TELEFONE').AsString);
         vlPropertyJson.AddPair('CLI_TIPOPESSOA', vloClientes.FieldByName('CLI_TIPOPESSOA').AsString);
         vlPropertyJson.AddPair('CLI_CNPJCPF', vloClientes.FieldByName('CLI_CNPJCPF').AsString);
         vlPropertyJson.AddPair('CLI_RETAGUARDA', vloClientes.FieldByName('CLI_RETAGUARDA').AsString);
         vlPropertyJson.AddPair('CLI_PDV', vloClientes.FieldByName('CLI_PDV').AsString);
         vlPropertyJson.AddPair('CLI_EMAIL', vloClientes.FieldByName('CLI_EMAIL').AsString);
         vlPropertyJson.AddPair('CLI_ENDERECO', vloClientes.FieldByName('CLI_ENDERECO').AsString);
         vlPropertyJson.AddPair('CLI_NUMERO', vloClientes.FieldByName('CLI_NUMERO').AsString);
         vlPropertyJson.AddPair('CLI_CIDADE', vloClientes.FieldByName('CLI_CIDADE').AsString);
         vlPropertyJson.AddPair('CID_DESCRICAO', vloClientes.FieldByName('CID_DESCRICAO').AsString);
         vlPropertyJson.AddPair('CLI_ESTADO', vloClientes.FieldByName('CLI_ESTADO').AsString);
         vlPropertyJson.AddPair('CLI_CEP', vloClientes.FieldByName('CLI_CEP').AsString);
         vlPropertyJson.AddPair('CLI_IE', vloClientes.FieldByName('CLI_IE').AsString);
         vlPropertyJson.AddPair('CLI_REVENDA', vloClientes.FieldByName('CLI_REVENDA').AsString);
         vlPropertyJson.AddPair('CLI_BAIRRO', vloClientes.FieldByName('CLI_BAIRRO').AsString);
         vlPropertyJson.AddPair('CLI_DATACADASTRO', vloClientes.FieldByName('CLI_DATACADASTRO').AsString);
         vlPropertyJson.AddPair('CLI_TIPOLICENCA', vloClientes.FieldByName('CLI_TIPOLICENCA').AsString);
         end;

      vlJsonList.AddElement(vlPropertyJson);
      end;

   vloClientes.Next;
   end;

FreeAndNil(vlJsonObject);
vlJsonObject  := TJSONObject.Create;
vlJsonObject.AddPair('Clientes', vlJsonList);
Result := vlJsonObject;

except
   on E:Exception do
      begin
      FServidor.pcdMensagemLOG(E.Message);
      end;
   end;
finally
   FreeAndNil(vloCliente);
   FreeAndNil(vloClientes);
   end;
end;

function TServerMethods1.fncExcluiCliente(psCodigo: String): TJSONObject;
var
   vlJsonObject, vlJsonResult : TJSONObject;
   vliCLI_CODIGO : TJSONValue;
begin
vlJsonObject  := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(psCodigo), 0) as TJSONObject;
vlJsonResult  := TJSONObject.Create;

vliCLI_CODIGO := vlJsonObject.GetValue('CLI_CODIGO') as TJSONValue;
vloCliente    := TClienteCRUD.Create(DMServer.FDConexao);
try
vloCliente.CLI_CODIGO := StrToInt(vliCLI_CODIGO.Value);
try
vloCliente.pcdExluirCliente;
vlJsonResult.AddPair('Retorno', 'Ok');
except
   on E:Exception do
      begin
      FServidor.pcdMensagemLOG(E.Message);
      vlJsonResult.AddPair('Retorno', E.Message);
      end;
   end;
finally
   FreeAndNil(vloCliente);
   Result := vlJsonResult;
   end;
end;

function TServerMethods1.fncGravarCliente(psDadosCliente: String): TJSONObject;
var
   vlsCLI_ENDERECO, vlsCLI_ESTADO, vlsCLI_TELEFONE, vlsCLI_RAZAO,
   vlsCLI_TIPOPESSOA, vlsCLI_BAIRRO, vlsCLI_EMAIL, vlsCLI_TIPOLICENCA,
   vlsCLI_CEP, vlsCLI_CNPJCPF, vlsCLI_IE, vlsCLI_NUMERO, vlsCLI_CIDADE,
   vlsCLI_DATACADASTRO: TJSONString;
   vliCLI_RETAGUARDA, vliCLI_REVENDA, vliCLI_CODIGO, vliCLI_PDV: TJSONValue;
   vlJsonObject, vlJsonResult : TJSONObject;
begin
vlJsonObject        := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(psDadosCliente), 0) as TJSONObject;
vlJsonResult        := TJSONObject.Create;

vliCLI_CODIGO       := vlJsonObject.GetValue('CLI_CODIGO') as TJSONValue;
vlsCLI_RAZAO        := vlJsonObject.GetValue('CLI_RAZAO') as TJSONString;
vlsCLI_TELEFONE     := vlJsonObject.GetValue('CLI_TELEFONE') as TJSONString;
vlsCLI_TIPOPESSOA   := vlJsonObject.GetValue('CLI_TIPOPESSOA') as TJSONString;
vlsCLI_CNPJCPF      := vlJsonObject.GetValue('CLI_CNPJCPF') as TJSONString;
vliCLI_RETAGUARDA   := vlJsonObject.GetValue('CLI_RETAGUARDA') as TJSONValue;
vliCLI_PDV          := vlJsonObject.GetValue('CLI_PDV') as TJSONValue;
vlsCLI_EMAIL        := vlJsonObject.GetValue('CLI_EMAIL') as TJSONString;
vlsCLI_ENDERECO     := vlJsonObject.GetValue('CLI_ENDERECO') as TJSONString;
vlsCLI_NUMERO       := vlJsonObject.GetValue('CLI_NUMERO') as TJSONString;
vlsCLI_BAIRRO       := vlJsonObject.GetValue('CLI_BAIRRO') as TJSONString;
vlsCLI_CIDADE       := vlJsonObject.GetValue('CLI_CIDADE') as TJSONString;
vlsCLI_ESTADO       := vlJsonObject.GetValue('CLI_ESTADO') as TJSONString;
vlsCLI_CEP          := vlJsonObject.GetValue('CLI_CEP') as TJSONString;
vlsCLI_IE           := vlJsonObject.GetValue('CLI_IE') as TJSONString;
vliCLI_REVENDA      := vlJsonObject.GetValue('CLI_REVENDA') as TJSONValue;
vlsCLI_DATACADASTRO := vlJsonObject.GetValue('CLI_DATACADASTRO') as TJSONString;
vlsCLI_TIPOLICENCA  := vlJsonObject.GetValue('CLI_TIPOLICENCA') as TJSONString;

if not Assigned(vloCliente) then
   vloCliente := TClienteCRUD.Create(DMServer.FDConexao);
try

if ((vliCLI_CODIGO.Value = '0') or (vliCLI_CODIGO.Value = '')) then
   vloCliente.CLI_CODIGO     := fncRetornaUltimoCliente
else
   vloCliente.CLI_CODIGO     := StrToInt(vliCLI_CODIGO.ToString);

vloCliente.CLI_RAZAO         := StringReplace(vlsCLI_RAZAO.Value, '+', ' ', [rfReplaceAll]);
vloCliente.CLI_TELEFONE      := vlsCLI_TELEFONE.Value;
vloCliente.CLI_TIPOPESSOA    := vlsCLI_TIPOPESSOA.Value;
vloCliente.CLI_CNPJCPF       := vlsCLI_CNPJCPF.Value;
vloCliente.CLI_RETAGUARDA    := StrToInt(vliCLI_RETAGUARDA.Value);
vloCliente.CLI_PDV           := StrToInt(vliCLI_PDV.Value);
vloCliente.CLI_EMAIL         := vlsCLI_EMAIL.Value;
vloCliente.CLI_ENDERECO      := StringReplace(vlsCLI_ENDERECO.Value, '+', ' ', [rfReplaceAll]);
vloCliente.CLI_NUMERO        := vlsCLI_NUMERO.Value;
vloCliente.CLI_BAIRRO        := StringReplace(vlsCLI_BAIRRO.Value, '+', ' ', [rfReplaceAll]);
vloCliente.psCidadeDescricao := StringReplace(vlsCLI_CIDADE.Value, '+', ' ', [rfReplaceAll]);
vloCliente.CLI_ESTADO        := vlsCLI_ESTADO.Value;
vloCliente.CLI_CEP           := vlsCLI_CEP.Value;
vloCliente.CLI_IE            := vlsCLI_IE.Value;
vloCliente.CLI_REVENDA       := StrToInt(vliCLI_REVENDA.Value);
vloCliente.CLI_DATACADASTRO  := Date();
vloCliente.CLI_TIPOLICENCA   := vlsCLI_TIPOLICENCA.Value;

try
vloCliente.pcdGravarCliente;
vlJsonResult.AddPair('Retorno', 'Ok');
except
   on E:Exception do
      begin
      FServidor.pcdMensagemLOG(E.Message);
      vlJsonResult.AddPair('Retorno', E.Message);
      end;
   end;

finally
   FreeAndNil(vloCliente);
   Result := vlJsonResult;
   end;
end;

function TServerMethods1.fncPing: TJSONObject;
var
   vlJsonResult : TJSONObject;
begin
vlJsonResult := TJSONObject.Create;
vlJsonResult.AddPair('Retorno', 'Ok');
Result := vlJsonResult;
end;

function TServerMethods1.fncRetornaUltimoCliente: Integer;
var
   vloQuery : TFDQuery;
begin
Result       := 0;

vloQuery := TFDQuery.Create(nil);
try
vloQuery.Close;
vloQuery.Connection := DMServer.FDConexao;
vloQuery.SQL.Clear;
vloQuery.SQL.Add('SELECT MAX(CLI_CODIGO) AS ULTIMO FROM CLIENTE');
vloQuery.Open();

Result := vloQuery.FieldByName('ULTIMO').AsInteger + 1;
FServidor.pcdMensagemLOG('Retorno da função fncRetornaUltimoCliente: ' + Result.ToString);

finally
   FreeAndNil(vloQuery);
   end;
end;

function TServerMethods1.fncValidaLogin(psUsuarioSenha: String): TJSONObject;
var
   vlsUsuario, vlsSenha: TJSONString;
   vlJsonObject, vlJsonResult : TJSONObject;
   vloQuery : TFDQuery;
begin
vlJsonObject := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(psUsuarioSenha), 0) as TJSONObject;
vlJsonResult := TJSONObject.Create;

vlsUsuario := vlJsonObject.GetValue('REP_CODIGO') as TJSONString;
vlsSenha   := vlJsonObject.GetValue('REP_SENHA') as TJSONString;

vloQuery := TFDQuery.Create(nil);
try
vloQuery.Close;
vloQuery.Connection := DMServer.FDConexao;
vloQuery.SQL.Clear;
vloQuery.SQL.Add('SELECT REP_CODIGO FROM REPRESENTANTE WHERE REP_CODIGO = :CODIGO AND REP_SENHA = :SENHA');
vloQuery.ParamByName('CODIGO').AsString := vlsUsuario.Value;
vloQuery.ParamByName('SENHA').AsString  := vlsSenha.Value;
vloQuery.Open();

if not vloQuery.IsEmpty then
   begin
   vlJsonResult.AddPair('Retorno', 'Ok');

   vloQuery.Close;
   vloQuery.Connection := DMServer.FDConexao;
   vloQuery.SQL.Clear;
   vloQuery.SQL.Add('SELECT REP_DESCRICAO FROM REPRESENTANTE WHERE REP_CODIGO = :CODIGO');
   vloQuery.ParamByName('CODIGO').AsString := vlsUsuario.Value;
   vloQuery.Open();

   vlJsonResult.AddPair('NOME_REVENDA', vloQuery.FieldByName('REP_DESCRICAO').AsString);
   FServidor.pcdMensagemLOG('Usuário: ' + vlsUsuario.Value + ' localizado com sucesso!');
   end
else
   begin
   vlJsonResult.AddPair('Retorno', '');
   vlJsonResult.AddPair('NOME_REVENDA', '');
   FServidor.pcdMensagemLOG('Usuário: ' + vlsUsuario.Value + ' não localizado ou senha não confere!');
   end;

finally
   FreeAndNil(vloQuery);
   Result := vlJsonResult;
   end;
end;

function TServerMethods1.Ping: String;
begin
  FServidor.pcdMensagemLOG('Teste de Conexão na função Ping');
  Result := 'Ok';
end;
end.

