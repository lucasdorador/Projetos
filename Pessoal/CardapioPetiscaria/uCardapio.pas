unit uCardapio;

interface

uses
  System.Classes;

type TCardapio = class(TPersistent)
  private
    FPRO_VALORINTEIRA: Double;
    FPRO_GRUPO: Integer;
    FPRO_VALORMEIA: Double;
    FPRO_DESCRICAO: String;
    FPRO_CODIGO: Integer;
    procedure SetPRO_CODIGO(const Value: Integer);
    procedure SetPRO_DESCRICAO(const Value: String);
    procedure SetPRO_GRUPO(const Value: Integer);
    procedure SetPRO_VALORINTEIRA(const Value: Double);
    procedure SetPRO_VALORMEIA(const Value: Double);

  public
    constructor Create;
    destructor Destroy; override;

  protected

  published
    property PRO_CODIGO : Integer read FPRO_CODIGO write SetPRO_CODIGO;
    property PRO_GRUPO : Integer read FPRO_GRUPO write SetPRO_GRUPO;
    property PRO_DESCRICAO : String read FPRO_DESCRICAO write SetPRO_DESCRICAO;
    property PRO_VALORMEIA : Double read FPRO_VALORMEIA write SetPRO_VALORMEIA;
    property PRO_VALORINTEIRA : Double read FPRO_VALORINTEIRA write SetPRO_VALORINTEIRA;


end;

implementation

{ TCardapio }

constructor TCardapio.Create;
begin
FPRO_VALORINTEIRA := 0;
FPRO_GRUPO        := 0;
FPRO_VALORMEIA    := 0;
FPRO_DESCRICAO    := '';
FPRO_CODIGO       := 0;
end;

destructor TCardapio.Destroy;
begin

  inherited;
end;

procedure TCardapio.SetPRO_CODIGO(const Value: Integer);
begin
  FPRO_CODIGO := Value;
end;

procedure TCardapio.SetPRO_DESCRICAO(const Value: String);
begin
  FPRO_DESCRICAO := Value;
end;

procedure TCardapio.SetPRO_GRUPO(const Value: Integer);
begin
  FPRO_GRUPO := Value;
end;

procedure TCardapio.SetPRO_VALORINTEIRA(const Value: Double);
begin
  FPRO_VALORINTEIRA := Value;
end;

procedure TCardapio.SetPRO_VALORMEIA(const Value: Double);
begin
  FPRO_VALORMEIA := Value;
end;

end.
