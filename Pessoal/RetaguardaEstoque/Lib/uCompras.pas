unit uCompras;

interface

uses
  FireDAc.Comp.Client, FireDAc.Stan.Param, Data.DB,
  FireDAc.DApt;

type
   TCompras = class
   private
    FConexao : TFDConnection;
    FCP_NUMERO: Integer;
    FCP_QTDE: Double;
    FCP_EMPRESA: Integer;
    FCP_DATA: TDateTime;
    FCP_PRODUTO: Integer;
    procedure SetCP_DATA(const Value: TDateTime);
    procedure SetCP_EMPRESA(const Value: Integer);
    procedure SetCP_NUMERO(const Value: Integer);
    procedure SetCP_PRODUTO(const Value: Integer);
    procedure SetCP_QTDE(const Value: Double);

   public
    Constructor Create(poConexao: TFDConnection); virtual;
    Destructor Destroy(); override;
    function Insert : String;
    function Delete : String;

   published
    property CP_EMPRESA : Integer read FCP_EMPRESA write SetCP_EMPRESA;
    property CP_NUMERO  : Integer read FCP_NUMERO write SetCP_NUMERO;
    property CP_PRODUTO : Integer read FCP_PRODUTO write SetCP_PRODUTO;
    property CP_DATA    : TDateTime read FCP_DATA write SetCP_DATA;
    property CP_QTDE    : Double read FCP_QTDE write SetCP_QTDE;

   end;

implementation

{ TCompras }

constructor TCompras.Create(poConexao: TFDConnection);
begin

FConexao := poConexao;
end;

function TCompras.Delete: String;
begin

end;

destructor TCompras.Destroy;
begin

  inherited;
end;

function TCompras.Insert: String;
begin

end;

procedure TCompras.SetCP_DATA(const Value: TDateTime);
begin
  FCP_DATA := Value;
end;

procedure TCompras.SetCP_EMPRESA(const Value: Integer);
begin
  FCP_EMPRESA := Value;
end;

procedure TCompras.SetCP_NUMERO(const Value: Integer);
begin
  FCP_NUMERO := Value;
end;

procedure TCompras.SetCP_PRODUTO(const Value: Integer);
begin
  FCP_PRODUTO := Value;
end;

procedure TCompras.SetCP_QTDE(const Value: Double);
begin
  FCP_QTDE := Value;
end;

end.
