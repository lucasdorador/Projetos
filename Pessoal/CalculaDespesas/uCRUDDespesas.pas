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
    FpoMemTable: TFDMemTable;
    procedure Setcd_Ano(const Value: String);
    procedure Setcd_Descricao(const Value: String);
    procedure Setcd_Valor(const Value: Double);
    procedure Setcd_Sequencia(const Value: Integer);
    procedure SetpoMemTable(const Value: TFDMemTable);
  public
    constructor Create(poConexao : TFDConnection);
    destructor Destroy; override;
    function fncRetornaValorTotalANO(pdAno:String): Double;
    procedure pcdGravarDadosBanco;
    procedure pcdExcluirDadosBanco;

  published
    property cd_Sequencia : Integer read Fcd_Sequencia write Setcd_Sequencia;
    property cd_Ano       : String read Fcd_Ano write Setcd_Ano;
    property cd_Descricao : String read Fcd_Descricao write Setcd_Descricao;
    property cd_Valor     : Double read Fcd_Valor write Setcd_Valor;
    property poMemTable   : TFDMemTable read FpoMemTable write SetpoMemTable;

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

function TCrudDespesas.fncRetornaValorTotalANO(pdAno:String): Double;
begin
Result := 0;

FQuery.Close;
FQuery.SQL.Clear;
FQuery.SQL.Add('SELECT SUM(DESP_VALOR) AS VALOR FROM DESPESAS WHERE DESP_ANO = :DESP_ANO');
FQuery.ParamByName('DESP_ANO').AsString := pdAno;
FQuery.Open;

Result := FQuery.FieldByName('VALOR').AsFloat;
end;

procedure TCrudDespesas.pcdExcluirDadosBanco;
begin
FQuery.Close;
FQuery.SQL.Clear;
FQuery.SQL.Add('DELETE FROM DESPESAS WHERE DESP_SEQUENCIA = :DESP_SEQUENCIA');
FQuery.ParamByName('DESP_SEQUENCIA').AsInteger := Fcd_Sequencia;
FQuery.ExecSQL;
end;

procedure TCrudDespesas.pcdGravarDadosBanco;
begin
FQuery.Close;
FQuery.SQL.Clear;
FQuery.SQL.Add('INSERT INTO DESPESAS (DESP_ANO, DESP_DESCRICAO, DESP_VALOR) VALUES (:DESP_ANO, :DESP_DESCRICAO, :DESP_VALOR);');
FQuery.ParamByName('DESP_DESCRICAO').AsString := Fcd_Descricao;
FQuery.ParamByName('DESP_ANO').AsString       := Fcd_Ano;
FQuery.ParamByName('DESP_VALOR').AsFloat      := Fcd_Valor;
FQuery.ExecSQL;
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

procedure TCrudDespesas.SetpoMemTable(const Value: TFDMemTable);
begin
  FpoMemTable := Value;
end;

end.
