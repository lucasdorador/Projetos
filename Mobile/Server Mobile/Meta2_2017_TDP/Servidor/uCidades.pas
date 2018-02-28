unit uCidades;

interface

 uses FireDAC.Comp.Client;

type
 TCidades = class(TObject)
  private
   FConexao : TFDConnection;
   FCidades : TFDQuery;
  public
   constructor Create(poConexao:TFDConnection);
   destructor Destroy; override;
   function fncRetornaCidades: TFDQuery;


 end;

implementation

{ TCidades }

constructor TCidades.Create(poConexao: TFDConnection);
begin
FConexao := poConexao;

FCidades := TFDQuery.Create(nil);
FCidades.Close;
FCidades.Connection := FConexao;
FCidades.SQL.Clear;

end;

destructor TCidades.Destroy;
begin
  inherited;
end;

function TCidades.fncRetornaCidades: TFDQuery;
begin
FCidades.Close;
FCidades.SQL.Clear;
FCidades.SQL.Add('SELECT CID_DESCRICAO FROM CIDADE ORDER BY CID_DESCRICAO');
FCidades.Open();

Result := FCidades;
end;

end.
