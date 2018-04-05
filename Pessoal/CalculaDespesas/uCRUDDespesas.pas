unit uCRUDDespesas;

interface

uses
  FireDAC.Comp.Client, System.SysUtils;

type
 TCrudDespesas = class(TObject)
  private
    FConexao : TFDConnection;
    FQuery   : TFDQuery;
    Fcd_Valor: Double;
    Fcd_Descricao: String;
    Fcd_Ano: String;
    Fcd_Sequencia: Integer;
    procedure Setcd_Ano(const Value: String);
    procedure Setcd_Descricao(const Value: String);
    procedure Setcd_Valor(const Value: Double);
    procedure Setcd_Sequencia(const Value: Integer);
  public
    constructor Create(poConexao : TFDConnection);
    destructor Destroy; override;
    procedure pcdGravarDadosMemoria;
    procedure pcdLimpaDadosMemoria;
    procedure pcdGravarDadosBanco;
    procedure pcdExcluirDadosBanco;

  published
    property cd_Sequencia : Integer read Fcd_Sequencia write Setcd_Sequencia;
    property cd_Ano       : String read Fcd_Ano write Setcd_Ano;
    property cd_Descricao : String read Fcd_Descricao write Setcd_Descricao;
    property cd_Valor     : Double read Fcd_Valor write Setcd_Valor;

 end;

implementation

{ TCrudDespesas }

constructor TCrudDespesas.Create(poConexao: TFDConnection);
begin
FConexao := poConexao;

FQuery   := TFDQuery.Create(nil);
FQuery.Connection := FConexao;
FQuery.Close;

end;

destructor TCrudDespesas.Destroy;
begin
if Assigned(FQuery) then
   FreeAndNil(FQuery);

inherited;
end;

procedure TCrudDespesas.pcdExcluirDadosBanco;
begin

end;

procedure TCrudDespesas.pcdGravarDadosBanco;
begin

end;

procedure TCrudDespesas.pcdGravarDadosMemoria;
begin

end;

procedure TCrudDespesas.pcdLimpaDadosMemoria;
begin

end;

procedure TCrudDespesas.Setcd_Ano(const Value: String);
begin
  Fcd_Ano := Value;
end;

procedure TCrudDespesas.Setcd_Descricao(const Value: String);
begin
  Fcd_Descricao := Value;
end;

procedure TCrudDespesas.Setcd_Sequencia(const Value: Integer);
begin
  Fcd_Sequencia := Value;
end;

procedure TCrudDespesas.Setcd_Valor(const Value: Double);
begin
  Fcd_Valor := Value;
end;

end.
