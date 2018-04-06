unit uCRUDFaturamento;

interface

uses
  FireDAC.Comp.Client, System.SysUtils;

type
 TCRUDFaturamento = class(TObject)
   private
    FConexao : TFDConnection;
    FQuery   : TFDQuery;
    FFat_Valor: Double;
    FFat_Ano: String;
    procedure SetFat_Ano(const Value: String);
    procedure SetFat_Valor(const Value: Double);

   public
    constructor Create(poConexao : TFDConnection);
    destructor Destroy; override;
    procedure pcdGravaFaturamento;
    procedure pcdExcluiFaturamento;

   published
    property Fat_Ano   : String read FFat_Ano write SetFat_Ano;
    property Fat_Valor : Double read FFat_Valor write SetFat_Valor;


  end;

implementation

{ TCRUDFaturamento }

constructor TCRUDFaturamento.Create(poConexao: TFDConnection);
begin
FConexao := poConexao;

FQuery   := TFDQuery.Create(nil);
FQuery.Connection := FConexao;
FQuery.Close;
end;

destructor TCRUDFaturamento.Destroy;
begin
if Assigned(FQuery) then
   FreeAndNil(FQuery);

  inherited;
end;

procedure TCRUDFaturamento.pcdExcluiFaturamento;
begin
FQuery.Close;
FQuery.SQL.Clear;
FQuery.SQL.Add('DELETE FROM FATURAMENTO WHERE FAT_ANO = :FAT_ANO');
FQuery.ParamByName('FAT_ANO').AsString := FFat_Ano;
FQuery.ExecSQL;
end;

procedure TCRUDFaturamento.pcdGravaFaturamento;
begin
FQuery.Close;
FQuery.SQL.Clear;
FQuery.SQL.Add('INSERT INTO FATURAMENTO (FAT_ANO, FAT_VALOR) VALUES (:FAT_ANO, :FAT_VALOR)');
FQuery.ParamByName('FAT_ANO').AsString  := FFat_Ano;
FQuery.ParamByName('FAT_VALOR').AsFloat := FFat_Valor;
FQuery.ExecSQL;
end;

procedure TCRUDFaturamento.SetFat_Ano(const Value: String);
begin
  FFat_Ano := Value;
end;

procedure TCRUDFaturamento.SetFat_Valor(const Value: Double);
begin
  FFat_Valor := Value;
end;

end.
