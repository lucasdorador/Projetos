unit uCRUDConfiguracao;

interface

uses
  FireDAC.Comp.Client, System.SysUtils;

type
 TRetornoConfiguracao = record
    CONFIG_ANO : String;
    CONFIG_PORCENTAGEMISENTO : Double;
    CONFIG_VALORDECLARARIR : Double;
 end;

type
 TCRUDConfiguracao = class(TObject)
   private
    FConexao : TFDConnection;
    FQuery   : TFDQuery;
    FCONFIG_VALORDECLARARIR: Double;
    FCONFIG_ANO: String;
    FCONFIG_PORCENTAGEMISENTO: Double;
    FpoRetornoConfig: TRetornoConfiguracao;
    procedure SetCONFIG_ANO(const Value: String);
    procedure SetCONFIG_PORCENTAGEMISENTO(const Value: Double);
    procedure SetCONFIG_VALORDECLARARIR(const Value: Double);
    procedure SetpoRetornoConfig(const Value: TRetornoConfiguracao);

   public
    constructor Create(poConexao : TFDConnection);
    destructor Destroy; override;
    procedure pcdGravaConfiguracao;
    procedure pcdExcluiConfiguracao;
    procedure pcdRetornaValorFaturadoANO(pdAno:String);

   published
    property CONFIG_ANO   : String read FCONFIG_ANO write SetCONFIG_ANO;
    property CONFIG_PORCENTAGEMISENTO : Double read FCONFIG_PORCENTAGEMISENTO write SetCONFIG_PORCENTAGEMISENTO;
    property CONFIG_VALORDECLARARIR : Double read FCONFIG_VALORDECLARARIR write SetCONFIG_VALORDECLARARIR;
    property poRetornoConfig : TRetornoConfiguracao read FpoRetornoConfig write SetpoRetornoConfig;
 end;

implementation

{ TCRUDConfiguracao }

constructor TCRUDConfiguracao.Create(poConexao: TFDConnection);
begin
FConexao := poConexao;

FQuery   := TFDQuery.Create(nil);
FQuery.Connection := FConexao;
FQuery.Close;
end;

destructor TCRUDConfiguracao.Destroy;
begin
if Assigned(FQuery) then
   FreeAndNil(FQuery);
inherited;
end;

procedure TCRUDConfiguracao.pcdRetornaValorFaturadoANO(pdAno: String);
begin
FpoRetornoConfig.CONFIG_ANO               := '';
FpoRetornoConfig.CONFIG_PORCENTAGEMISENTO := 0;
FpoRetornoConfig.CONFIG_VALORDECLARARIR   := 0;

FQuery.Close;
FQuery.SQL.Clear;
FQuery.SQL.Add('SELECT CONFIG_ANO, CONFIG_PORCENTAGEMISENTO, CONFIG_VALORDECLARARIR FROM CONFIGURACAO WHERE CONFIG_ANO = :CONFIG_ANO');
FQuery.ParamByName('CONFIG_ANO').AsString := pdAno;
FQuery.Open;

FpoRetornoConfig.CONFIG_ANO               := FQuery.FieldByName('CONFIG_ANO').AsString;
FpoRetornoConfig.CONFIG_PORCENTAGEMISENTO := FQuery.FieldByName('CONFIG_PORCENTAGEMISENTO').AsFloat;
FpoRetornoConfig.CONFIG_VALORDECLARARIR   := FQuery.FieldByName('CONFIG_VALORDECLARARIR').AsFloat;
end;

procedure TCRUDConfiguracao.pcdExcluiConfiguracao;
begin
FQuery.Close;
FQuery.SQL.Clear;
FQuery.SQL.Add('DELETE FROM CONFIGURACAO WHERE CONFIG_ANO = :CONFIG_ANO');
FQuery.ParamByName('CONFIG_ANO').AsString := FCONFIG_ANO;
FQuery.ExecSQL;
end;

procedure TCRUDConfiguracao.pcdGravaConfiguracao;
begin
FQuery.Close;
FQuery.SQL.Clear;
FQuery.SQL.Add('INSERT INTO CONFIGURACAO (CONFIG_ANO, CONFIG_PORCENTAGEMISENTO, CONFIG_VALORDECLARARIR) VALUES (:CONFIG_ANO, :CONFIG_PORCENTAGEMISENTO, :CONFIG_VALORDECLARARIR)');
FQuery.ParamByName('CONFIG_ANO').AsString              := FCONFIG_ANO;
FQuery.ParamByName('CONFIG_PORCENTAGEMISENTO').AsFloat := FCONFIG_PORCENTAGEMISENTO;
FQuery.ParamByName('CONFIG_VALORDECLARARIR').AsFloat   := FCONFIG_VALORDECLARARIR;
FQuery.ExecSQL;
end;

procedure TCRUDConfiguracao.SetCONFIG_ANO(const Value: String);
begin
FCONFIG_ANO := Value;
end;

procedure TCRUDConfiguracao.SetCONFIG_PORCENTAGEMISENTO(const Value: Double);
begin
FCONFIG_PORCENTAGEMISENTO := Value;
end;

procedure TCRUDConfiguracao.SetCONFIG_VALORDECLARARIR(const Value: Double);
begin
FCONFIG_VALORDECLARARIR := Value;
end;

procedure TCRUDConfiguracao.SetpoRetornoConfig(
  const Value: TRetornoConfiguracao);
begin
  FpoRetornoConfig := Value;
end;

end.
