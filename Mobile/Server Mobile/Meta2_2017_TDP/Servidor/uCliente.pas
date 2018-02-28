unit uCliente;

interface

type
   TCliente = class(TObject)
     private
      FCLI_ENDERECO: String;
      FCLI_ESTADO: String;
      FCLI_TELEFONE: String;
      FCLI_RAZAO: String;
      FCLI_PDV: Integer;
      FCLI_TIPOPESSOA: String;
      FCLI_BAIRRO: String;
      FCLI_EMAIL: String;
      FCLI_REVENDA: Integer;
      FCLI_CODIGO: Integer;
      FCLI_TIPOLICENCA: String;
      FCLI_RETAGUARDA: Integer;
      FCLI_CEP: String;
      FCLI_CNPJCPF: String;
      FCLI_IE: String;
      FCLI_NUMERO: String;
      FCLI_DATACADASTRO: TDateTime;
      FCLI_CIDADE: Integer;
      procedure SetCLI_BAIRRO(const Value: String);
      procedure SetCLI_CEP(const Value: String);
      procedure SetCLI_CIDADE(const Value: Integer);
      procedure SetCLI_CNPJCPF(const Value: String);
      procedure SetCLI_CODIGO(const Value: Integer);
      procedure SetCLI_DATACADASTRO(const Value: TDateTime);
      procedure SetCLI_EMAIL(const Value: String);
      procedure SetCLI_ENDERECO(const Value: String);
      procedure SetCLI_ESTADO(const Value: String);
      procedure SetCLI_IE(const Value: String);
      procedure SetCLI_NUMERO(const Value: String);
      procedure SetCLI_PDV(const Value: Integer);
      procedure SetCLI_RAZAO(const Value: String);
      procedure SetCLI_RETAGUARDA(const Value: Integer);
      procedure SetCLI_REVENDA(const Value: Integer);
      procedure SetCLI_TELEFONE(const Value: String);
      procedure SetCLI_TIPOLICENCA(const Value: String);
      procedure SetCLI_TIPOPESSOA(const Value: String);

     public
      constructor Create(); virtual;
      destructor Destroy(); override;

     published
      property CLI_CODIGO       : Integer read FCLI_CODIGO write SetCLI_CODIGO;
      property CLI_RAZAO        : String read FCLI_RAZAO write SetCLI_RAZAO;
      property CLI_TELEFONE     : String read FCLI_TELEFONE write SetCLI_TELEFONE;
      property CLI_TIPOPESSOA   : String read FCLI_TIPOPESSOA write SetCLI_TIPOPESSOA;
      property CLI_CNPJCPF      : String read FCLI_CNPJCPF write SetCLI_CNPJCPF;
      property CLI_RETAGUARDA   : Integer read FCLI_RETAGUARDA write SetCLI_RETAGUARDA;
      property CLI_PDV          : Integer read FCLI_PDV write SetCLI_PDV;
      property CLI_EMAIL        : String read FCLI_EMAIL write SetCLI_EMAIL;
      property CLI_ENDERECO     : String read FCLI_ENDERECO write SetCLI_ENDERECO;
      property CLI_NUMERO       : String read FCLI_NUMERO write SetCLI_NUMERO;
      property CLI_BAIRRO       : String read FCLI_BAIRRO write SetCLI_BAIRRO;
      property CLI_CIDADE       : Integer read FCLI_CIDADE write SetCLI_CIDADE;
      property CLI_ESTADO       : String read FCLI_ESTADO write SetCLI_ESTADO;
      property CLI_CEP          : String read FCLI_CEP write SetCLI_CEP;
      property CLI_IE           : String read FCLI_IE write SetCLI_IE;
      property CLI_REVENDA      : Integer read FCLI_REVENDA write SetCLI_REVENDA;
      property CLI_DATACADASTRO : TDateTime read FCLI_DATACADASTRO write SetCLI_DATACADASTRO;
      property CLI_TIPOLICENCA  : String read FCLI_TIPOLICENCA write SetCLI_TIPOLICENCA;

   end;

implementation

{ TCliente }

constructor TCliente.Create;
begin
FCLI_ENDERECO     := '';
FCLI_ESTADO       := '';
FCLI_TELEFONE     := '';
FCLI_RAZAO        := '';
FCLI_PDV          := 0;
FCLI_TIPOPESSOA   := '';
FCLI_BAIRRO       := '';
FCLI_EMAIL        :=  '';
FCLI_REVENDA      := 0;
FCLI_CODIGO       := 0;
FCLI_TIPOLICENCA  := '';
FCLI_RETAGUARDA   := 0;
FCLI_CEP          := '';
FCLI_CNPJCPF      := '';
FCLI_IE           := '';
FCLI_NUMERO       := '';
FCLI_DATACADASTRO := 0;
FCLI_CIDADE       := 1;
end;

destructor TCliente.Destroy;
begin

  inherited;
end;

procedure TCliente.SetCLI_BAIRRO(const Value: String);
begin
  FCLI_BAIRRO := Value;
end;

procedure TCliente.SetCLI_CEP(const Value: String);
begin
  FCLI_CEP := Value;
end;

procedure TCliente.SetCLI_CIDADE(const Value: Integer);
begin
  FCLI_CIDADE := Value;
end;

procedure TCliente.SetCLI_CNPJCPF(const Value: String);
begin
  FCLI_CNPJCPF := Value;
end;

procedure TCliente.SetCLI_CODIGO(const Value: Integer);
begin
  FCLI_CODIGO := Value;
end;

procedure TCliente.SetCLI_DATACADASTRO(const Value: TDateTime);
begin
  FCLI_DATACADASTRO := Value;
end;

procedure TCliente.SetCLI_EMAIL(const Value: String);
begin
  FCLI_EMAIL := Value;
end;

procedure TCliente.SetCLI_ENDERECO(const Value: String);
begin
  FCLI_ENDERECO := Value;
end;

procedure TCliente.SetCLI_ESTADO(const Value: String);
begin
  FCLI_ESTADO := Value;
end;

procedure TCliente.SetCLI_IE(const Value: String);
begin
  FCLI_IE := Value;
end;

procedure TCliente.SetCLI_NUMERO(const Value: String);
begin
  FCLI_NUMERO := Value;
end;

procedure TCliente.SetCLI_PDV(const Value: Integer);
begin
  FCLI_PDV := Value;
end;

procedure TCliente.SetCLI_RAZAO(const Value: String);
begin
  FCLI_RAZAO := Value;
end;

procedure TCliente.SetCLI_RETAGUARDA(const Value: Integer);
begin
  FCLI_RETAGUARDA := Value;
end;

procedure TCliente.SetCLI_REVENDA(const Value: Integer);
begin
  FCLI_REVENDA := Value;
end;

procedure TCliente.SetCLI_TELEFONE(const Value: String);
begin
  FCLI_TELEFONE := Value;
end;

procedure TCliente.SetCLI_TIPOLICENCA(const Value: String);
begin
  FCLI_TIPOLICENCA := Value;
end;

procedure TCliente.SetCLI_TIPOPESSOA(const Value: String);
begin
  FCLI_TIPOPESSOA := Value;
end;

end.
