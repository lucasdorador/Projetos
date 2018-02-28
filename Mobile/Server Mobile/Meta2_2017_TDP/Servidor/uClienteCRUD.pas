unit uClienteCRUD;

interface

 uses uCliente, FireDAC.Comp.Client;

 type TClienteCRUD = class(TCliente)
  private
   FConexao : TFDConnection;
   FCliente : TFDQuery;
    FpsCidadeDescricao: String;
   procedure pcdInsertCliente;
   procedure pcdUpdateCliente;
   procedure pcdParametrosCliente;
   function fncRetornaCodCidade(psCidade: String): Integer;
    procedure SetpsCidadeDescricao(const Value: String);
  public
   constructor Create(poConexao: TFDConnection); overload;
   destructor Destroy; override;
   procedure pcdGravarCliente;
   procedure pcdExluirCliente;
   function fncConsultaClientes: TFDQuery;
  published
   property psCidadeDescricao : String read FpsCidadeDescricao write SetpsCidadeDescricao;

 end;

implementation

uses
  System.SysUtils;

{ TClienteCRUD }

constructor TClienteCRUD.Create(poConexao: TFDConnection);
begin
FConexao := poConexao;

FCliente := TFDQuery.Create(nil);
FCliente.Close;
FCliente.Connection := FConexao;

end;

destructor TClienteCRUD.Destroy;
begin

  inherited;
end;

function TClienteCRUD.fncRetornaCodCidade(psCidade: String): Integer;
var
   vloCidade : TFDQuery;
begin
Result    := 1;
vloCidade := TFDQuery.Create(nil);
try
vloCidade.Close;
vloCidade.Connection := FConexao;
vloCidade.SQL.Clear;
vloCidade.SQL.Add('SELECT CID_CODIGO FROM CIDADE WHERE CID_DESCRICAO = :CIDADE');
vloCidade.ParamByName('CIDADE').AsString := psCidade;
vloCidade.Open();

if not vloCidade.IsEmpty then
   Result := vloCidade.FieldByName('CID_CODIGO').AsInteger;

finally
   FreeAndNil(vloCidade);
   end;
end;

function TClienteCRUD.fncConsultaClientes: TFDQuery;
begin
FCliente.SQL.Clear;
FCliente.SQL.Add('SELECT CLI_CODIGO, CLI_RAZAO, CLI_TELEFONE, CLI_TIPOPESSOA,');
FCliente.SQL.Add('       CLI_CNPJCPF, CLI_RETAGUARDA, CLI_PDV, CLI_EMAIL,');
FCliente.SQL.Add('       CLI_ENDERECO, CLI_NUMERO, CLI_CIDADE, CID_DESCRICAO,');
FCliente.SQL.Add('       CLI_ESTADO, CLI_CEP, CLI_IE, CLI_REVENDA, CLI_BAIRRO,');
FCliente.SQL.Add('       CLI_DATACADASTRO, CLI_TIPOLICENCA');
FCliente.SQL.Add('FROM CLIENTE');
FCliente.SQL.Add('INNER JOIN CIDADE ON (CLI_CIDADE = CID_CODIGO)');

if CLI_CODIGO <> 0 then
   begin
   FCliente.SQL.Add('WHERE CLI_CODIGO = :CODIGO');
   FCliente.ParamByName('CODIGO').AsInteger := CLI_CODIGO;
   end;

FCliente.Open();

Result := FCliente;
end;

procedure TClienteCRUD.pcdExluirCliente;
begin
try
FCliente.SQL.Clear;
FCliente.SQL.Add('DELETE FROM CLIENTE WHERE CLI_CODIGO = :CODIGO');
FCliente.ParamByName('CODIGO').AsInteger := CLI_CODIGO;
FCliente.ExecSQL;
except
   on E:Exception do
      begin
      raise Exception.Create('Erro ao excluir cliente com a mensagem: '+ E.Message);
      end;
   end;
end;

procedure TClienteCRUD.pcdGravarCliente;
begin
FCliente.SQL.Clear;
FCliente.SQL.Add('SELECT CLI_CODIGO FROM CLIENTE WHERE CLI_CODIGO = :CODIGO');
FCliente.ParamByName('CODIGO').AsInteger := CLI_CODIGO;
FCliente.Open();

CLI_CIDADE := fncRetornaCodCidade(FpsCidadeDescricao);

try
if FCliente.IsEmpty then
   pcdInsertCliente
else
   pcdUpdateCliente;

pcdParametrosCliente;
except
   on E:Exception do
      begin
      raise Exception.Create('Erro ao inserir cliente com a mensagem: '+ E.Message);
      end;
   end;
end;

procedure TClienteCRUD.pcdInsertCliente;
begin
FCliente.SQL.Clear;
FCliente.SQL.Add('INSERT INTO CLIENTE (CLI_CODIGO, CLI_RAZAO, CLI_TELEFONE, CLI_TIPOPESSOA, CLI_CNPJCPF,');
FCliente.SQL.Add('                     CLI_RETAGUARDA, CLI_PDV, CLI_EMAIL, CLI_ENDERECO, CLI_NUMERO,');
FCliente.SQL.Add('                     CLI_CIDADE, CLI_ESTADO, CLI_CEP, CLI_IE, CLI_REVENDA, CLI_BAIRRO,');
FCliente.SQL.Add('                     CLI_DATACADASTRO, CLI_TIPOLICENCA)');
FCliente.SQL.Add('VALUES (:CLI_CODIGO, :CLI_RAZAO, :CLI_TELEFONE, :CLI_TIPOPESSOA, :CLI_CNPJCPF,');
FCliente.SQL.Add('        :CLI_RETAGUARDA, :CLI_PDV, :CLI_EMAIL, :CLI_ENDERECO, :CLI_NUMERO,');
FCliente.SQL.Add('        :CLI_CIDADE, :CLI_ESTADO, :CLI_CEP, :CLI_IE, :CLI_REVENDA, :CLI_BAIRRO,');
FCliente.SQL.Add('        :CLI_DATACADASTRO, :CLI_TIPOLICENCA)');
end;

procedure TClienteCRUD.pcdUpdateCliente;
begin
FCliente.SQL.Clear;
FCliente.SQL.Add('UPDATE CLIENTE SET CLI_RAZAO = :CLI_RAZAO,');
FCliente.SQL.Add('                   CLI_TELEFONE = :CLI_TELEFONE,');
FCliente.SQL.Add('                   CLI_TIPOPESSOA = :CLI_TIPOPESSOA,');
FCliente.SQL.Add('                   CLI_CNPJCPF = :CLI_CNPJCPF,');
FCliente.SQL.Add('                   CLI_RETAGUARDA = :CLI_RETAGUARDA,');
FCliente.SQL.Add('                   CLI_PDV = :CLI_PDV,');
FCliente.SQL.Add('                   CLI_EMAIL = :CLI_EMAIL,');
FCliente.SQL.Add('                   CLI_ENDERECO = :CLI_ENDERECO,');
FCliente.SQL.Add('                   CLI_NUMERO = :CLI_NUMERO,');
FCliente.SQL.Add('                   CLI_CIDADE = :CLI_CIDADE,');
FCliente.SQL.Add('                   CLI_ESTADO = :CLI_ESTADO,');
FCliente.SQL.Add('                   CLI_CEP = :CLI_CEP,');
FCliente.SQL.Add('                   CLI_IE = :CLI_IE,');
FCliente.SQL.Add('                   CLI_REVENDA = :CLI_REVENDA,');
FCliente.SQL.Add('                   CLI_BAIRRO = :CLI_BAIRRO,');
FCliente.SQL.Add('                   CLI_DATACADASTRO = :CLI_DATACADASTRO,');
FCliente.SQL.Add('                   CLI_TIPOLICENCA = :CLI_TIPOLICENCA');
FCliente.SQL.Add('WHERE CLI_CODIGO = :CLI_CODIGO');
end;

procedure TClienteCRUD.SetpsCidadeDescricao(const Value: String);
begin
  FpsCidadeDescricao := Value;
end;

procedure TClienteCRUD.pcdParametrosCliente;
begin
FCliente.ParamByName('CLI_CODIGO').AsInteger      := CLI_CODIGO;
FCliente.ParamByName('CLI_RAZAO').AsString        := CLI_RAZAO;
FCliente.ParamByName('CLI_TELEFONE').AsString     := CLI_TELEFONE;
FCliente.ParamByName('CLI_TIPOPESSOA').AsString   := CLI_TIPOPESSOA;
FCliente.ParamByName('CLI_CNPJCPF').AsString      := CLI_CNPJCPF;
FCliente.ParamByName('CLI_RETAGUARDA').AsInteger  := CLI_RETAGUARDA;
FCliente.ParamByName('CLI_PDV').AsInteger         := CLI_PDV;
FCliente.ParamByName('CLI_EMAIL').AsString        := CLI_EMAIL;
FCliente.ParamByName('CLI_ENDERECO').AsString     := CLI_ENDERECO;
FCliente.ParamByName('CLI_NUMERO').AsString       := CLI_NUMERO;
FCliente.ParamByName('CLI_CIDADE').AsInteger      := CLI_CIDADE;
FCliente.ParamByName('CLI_ESTADO').AsString       := CLI_ESTADO;
FCliente.ParamByName('CLI_CEP').AsString          := CLI_CEP;
FCliente.ParamByName('CLI_IE').AsString           := CLI_IE;
FCliente.ParamByName('CLI_REVENDA').AsInteger     := CLI_REVENDA;
FCliente.ParamByName('CLI_BAIRRO').AsString       := CLI_BAIRRO;
FCliente.ParamByName('CLI_DATACADASTRO').AsString := FormatDateTime('mm/dd/yyyy', CLI_DATACADASTRO);
FCliente.ParamByName('CLI_TIPOLICENCA').AsString  := CLI_TIPOLICENCA;
FCliente.ExecSQL;
end;

end.
