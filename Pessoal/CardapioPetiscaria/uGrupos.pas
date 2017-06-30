unit uGrupos;

interface

type TGrupos = class
  private
    FGRUPO_DESCRICAO: String;
    FGRUPO_CODIGO: Integer;
    procedure SetGRUPO_CODIGO(const Value: Integer);
    procedure SetGRUPO_DESCRICAO(const Value: String);


  public
    constructor Create;
    destructor Destroy; override;

  protected

  published
    property GRUPO_CODIGO : Integer read FGRUPO_CODIGO write SetGRUPO_CODIGO;
    property GRUPO_DESCRICAO : String read FGRUPO_DESCRICAO write SetGRUPO_DESCRICAO;
end;

implementation

{ TGrupos }

constructor TGrupos.Create;
begin
FGRUPO_DESCRICAO := '';
FGRUPO_CODIGO    := 0;
end;

destructor TGrupos.Destroy;
begin

  inherited;
end;

procedure TGrupos.SetGRUPO_CODIGO(const Value: Integer);
begin
  FGRUPO_CODIGO := Value;
end;

procedure TGrupos.SetGRUPO_DESCRICAO(const Value: String);
begin
  FGRUPO_DESCRICAO := Value;
end;

end.
