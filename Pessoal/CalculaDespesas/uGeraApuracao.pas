unit uGeraApuracao;

interface

uses
  FireDAC.Comp.Client, System.SysUtils;

type
 TRetornoApuracao = record
  vlsAPUR_ANO                : String;
  vldAPUR_RECEITABRUTA       : Double;
  vldAPUR_DESPESAS           : Double;
  vldAPUR_LUCROEVIDENCIADO   : Double;
  vldAPUR_PORCENTAGEMISENTA  : Double;
  vldAPUR_VALORISENTO        : Double;
  vldAPUR_VALORTRIBUTADO     : Double;
  vldAPUR_VALORDECLARARIR    : Double;
  vlsAPUR_DECLARA            : String;
 end;

type
 TGeraApuracao = class(TObject)
  private
    FConexao : TFDConnection;
    FQuery   : TFDQuery;
    FAPUR_LUCROEVIDENCIADO: Double;
    FAPUR_DESPESAS: Double;
    FAPUR_VALORTRIBUTADO: Double;
    FAPUR_PORCENTAGEMISENTA: Double;
    FAPUR_RECEITABRUTA: Double;
    FAPUR_VALORDECLARARIR: Double;
    FAPUR_VALORISENTO: Double;
    FAPUR_ANO: String;
    FAPUR_DECLARA: String;
    FpoRetornoApuracao: TRetornoApuracao;
    procedure SetAPUR_ANO(const Value: String);
    procedure SetAPUR_DECLARA(const Value: String);
    procedure SetAPUR_DESPESAS(const Value: Double);
    procedure SetAPUR_LUCROEVIDENCIADO(const Value: Double);
    procedure SetAPUR_PORCENTAGEMISENTA(const Value: Double);
    procedure SetAPUR_RECEITABRUTA(const Value: Double);
    procedure SetAPUR_VALORDECLARARIR(const Value: Double);
    procedure SetAPUR_VALORISENTO(const Value: Double);
    procedure SetAPUR_VALORTRIBUTADO(const Value: Double);
    procedure SetpoRetornoApuracao(const Value: TRetornoApuracao);
  public
    constructor Create(poConexao : TFDConnection);
    destructor Destroy; override;
    procedure pcdGravaApuracao;
    procedure pcdExcluiApuracao;
    function  fncRetornaQtdeAnosApurados: TFDQuery;
    procedure pcdRetornaValoresApuracaoANO(pdAno:String);

  published
    property APUR_ANO                : String read FAPUR_ANO write SetAPUR_ANO;
    property APUR_RECEITABRUTA       : Double read FAPUR_RECEITABRUTA write SetAPUR_RECEITABRUTA;
    property APUR_DESPESAS           : Double read FAPUR_DESPESAS write SetAPUR_DESPESAS;
    property APUR_LUCROEVIDENCIADO   : Double read FAPUR_LUCROEVIDENCIADO write SetAPUR_LUCROEVIDENCIADO;
    property APUR_PORCENTAGEMISENTA  : Double read FAPUR_PORCENTAGEMISENTA write SetAPUR_PORCENTAGEMISENTA;
    property APUR_VALORISENTO        : Double read FAPUR_VALORISENTO write SetAPUR_VALORISENTO;
    property APUR_VALORTRIBUTADO     : Double read FAPUR_VALORTRIBUTADO write SetAPUR_VALORTRIBUTADO;
    property APUR_VALORDECLARARIR    : Double read FAPUR_VALORDECLARARIR write SetAPUR_VALORDECLARARIR;
    property APUR_DECLARA            : String read FAPUR_DECLARA write SetAPUR_DECLARA;
    property poRetornoApuracao       : TRetornoApuracao read FpoRetornoApuracao write SetpoRetornoApuracao;

 end;

implementation

{ TGeraApuracao }

constructor TGeraApuracao.Create(poConexao: TFDConnection);
begin
FConexao := poConexao;

FQuery   := TFDQuery.Create(nil);
FQuery.Connection := FConexao;
FQuery.Close;
end;

destructor TGeraApuracao.Destroy;
begin
if Assigned(FQuery) then
   FreeAndNil(FQuery);

inherited;
end;

function TGeraApuracao.fncRetornaQtdeAnosApurados: TFDQuery;
begin
FQuery.Close;
FQuery.SQL.Clear;
FQuery.SQL.Add('SELECT APUR_ANO FROM APURACAO ORDER BY APUR_ANO');
FQuery.Open;

Result := FQuery;
end;

procedure TGeraApuracao.pcdExcluiApuracao;
begin
FQuery.Close;
FQuery.SQL.Clear;
FQuery.SQL.Add('DELETE FROM APURACAO WHERE APUR_ANO = :APUR_ANO');
FQuery.ParamByName('APUR_ANO').AsString              := FAPUR_ANO;
FQuery.ExecSQL;
end;

procedure TGeraApuracao.pcdGravaApuracao;
begin
FQuery.Close;
FQuery.SQL.Clear;
FQuery.SQL.Add('INSERT INTO APURACAO (APUR_ANO, APUR_RECEITABRUTA, APUR_DESPESAS, APUR_LUCROEVIDENCIADO,');
FQuery.SQL.Add('                      APUR_PORCENTAGEMISENTA, APUR_VALORISENTO, APUR_VALORTRIBUTADO,');
FQuery.SQL.Add('                      APUR_VALORDECLARARIR, APUR_DECLARA)');
FQuery.SQL.Add('VALUES (:APUR_ANO, :APUR_RECEITABRUTA, :APUR_DESPESAS, :APUR_LUCROEVIDENCIADO,');
FQuery.SQL.Add('        :APUR_PORCENTAGEMISENTA, :APUR_VALORISENTO, :APUR_VALORTRIBUTADO,');
FQuery.SQL.Add('        :APUR_VALORDECLARARIR, :APUR_DECLARA)');
FQuery.ParamByName('APUR_ANO').AsString              := FAPUR_ANO;
FQuery.ParamByName('APUR_RECEITABRUTA').AsFloat      := FAPUR_RECEITABRUTA;
FQuery.ParamByName('APUR_DESPESAS').AsFloat          := FAPUR_DESPESAS;
FQuery.ParamByName('APUR_LUCROEVIDENCIADO').AsFloat  := FAPUR_LUCROEVIDENCIADO;
FQuery.ParamByName('APUR_PORCENTAGEMISENTA').AsFloat := FAPUR_PORCENTAGEMISENTA;
FQuery.ParamByName('APUR_VALORISENTO').AsFloat       := FAPUR_VALORISENTO;
FQuery.ParamByName('APUR_VALORTRIBUTADO').AsFloat    := FAPUR_VALORTRIBUTADO;
FQuery.ParamByName('APUR_VALORDECLARARIR').AsFloat   := FAPUR_VALORDECLARARIR;
FQuery.ParamByName('APUR_DECLARA').AsString          := FAPUR_DECLARA;
FQuery.ExecSQL;
end;

procedure TGeraApuracao.pcdRetornaValoresApuracaoANO(pdAno: String);
begin
FpoRetornoApuracao.vlsAPUR_ANO               := '';
FpoRetornoApuracao.vldAPUR_RECEITABRUTA      := 0;
FpoRetornoApuracao.vldAPUR_DESPESAS          := 0;
FpoRetornoApuracao.vldAPUR_LUCROEVIDENCIADO  := 0;
FpoRetornoApuracao.vldAPUR_PORCENTAGEMISENTA := 0;
FpoRetornoApuracao.vldAPUR_VALORISENTO       := 0;
FpoRetornoApuracao.vldAPUR_VALORTRIBUTADO    := 0;
FpoRetornoApuracao.vldAPUR_VALORDECLARARIR   := 0;
FpoRetornoApuracao.vlsAPUR_DECLARA           := '';

FQuery.Close;
FQuery.SQL.Clear;
FQuery.SQL.Add('SELECT APUR_ANO, APUR_RECEITABRUTA, APUR_DESPESAS, APUR_LUCROEVIDENCIADO,');
FQuery.SQL.Add('       APUR_PORCENTAGEMISENTA, APUR_VALORISENTO, APUR_VALORTRIBUTADO,');
FQuery.SQL.Add('       APUR_VALORDECLARARIR, APUR_DECLARA');
FQuery.SQL.Add('FROM APURACAO WHERE APUR_ANO = :APUR_ANO');
FQuery.ParamByName('APUR_ANO').AsString := pdAno;
FQuery.Open;

FpoRetornoApuracao.vlsAPUR_ANO               := FQuery.FieldByName('APUR_ANO').AsString;
FpoRetornoApuracao.vldAPUR_RECEITABRUTA      := FQuery.FieldByName('APUR_RECEITABRUTA').AsFloat;
FpoRetornoApuracao.vldAPUR_DESPESAS          := FQuery.FieldByName('APUR_DESPESAS').AsFloat;
FpoRetornoApuracao.vldAPUR_LUCROEVIDENCIADO  := FQuery.FieldByName('APUR_LUCROEVIDENCIADO').AsFloat;
FpoRetornoApuracao.vldAPUR_PORCENTAGEMISENTA := FQuery.FieldByName('APUR_PORCENTAGEMISENTA').AsFloat;
FpoRetornoApuracao.vldAPUR_VALORISENTO       := FQuery.FieldByName('APUR_VALORISENTO').AsFloat;
FpoRetornoApuracao.vldAPUR_VALORTRIBUTADO    := FQuery.FieldByName('APUR_VALORTRIBUTADO').AsFloat;
FpoRetornoApuracao.vldAPUR_VALORDECLARARIR   := FQuery.FieldByName('APUR_VALORDECLARARIR').AsFloat;
FpoRetornoApuracao.vlsAPUR_DECLARA           := FQuery.FieldByName('APUR_DECLARA').AsString;
end;

procedure TGeraApuracao.SetAPUR_ANO(const Value: String);
begin
  FAPUR_ANO := Value;
end;

procedure TGeraApuracao.SetAPUR_DECLARA(const Value: String);
begin
  FAPUR_DECLARA := Value;
end;

procedure TGeraApuracao.SetAPUR_DESPESAS(const Value: Double);
begin
  FAPUR_DESPESAS := Value;
end;

procedure TGeraApuracao.SetAPUR_LUCROEVIDENCIADO(const Value: Double);
begin
  FAPUR_LUCROEVIDENCIADO := Value;
end;

procedure TGeraApuracao.SetAPUR_PORCENTAGEMISENTA(const Value: Double);
begin
  FAPUR_PORCENTAGEMISENTA := Value;
end;

procedure TGeraApuracao.SetAPUR_RECEITABRUTA(const Value: Double);
begin
  FAPUR_RECEITABRUTA := Value;
end;

procedure TGeraApuracao.SetAPUR_VALORDECLARARIR(const Value: Double);
begin
  FAPUR_VALORDECLARARIR := Value;
end;

procedure TGeraApuracao.SetAPUR_VALORISENTO(const Value: Double);
begin
  FAPUR_VALORISENTO := Value;
end;

procedure TGeraApuracao.SetAPUR_VALORTRIBUTADO(const Value: Double);
begin
  FAPUR_VALORTRIBUTADO := Value;
end;

procedure TGeraApuracao.SetpoRetornoApuracao(const Value: TRetornoApuracao);
begin
  FpoRetornoApuracao := Value;
end;

end.
