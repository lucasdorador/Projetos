unit uClassBancoDados;

interface

uses
   FireDAc.Comp.Client, System.SysUtils;

type
  TCamadaBancoDados = class(TObject)
    private
     FConexao : TFDConnection;
    public
     constructor Create(poConexao : TFDConnection);
     Destructor Destroy; override;

     function fncBuscaTodosCheques : TFDQuery;
    published

  end;

implementation

{ TCamadaBancoDados }

uses uCriacaoComponentes;

constructor TCamadaBancoDados.Create(poConexao: TFDConnection);
begin
FConexao := poConexao;
end;

destructor TCamadaBancoDados.Destroy;
begin
  inherited;
end;

function TCamadaBancoDados.fncBuscaTodosCheques: TFDQuery;
var
   FDCheques : TFDQuery;
begin
FDCheques := TCriacaoFB.criaTFDQuery(FConexao);
try
FDCheques.Close;
FDCheques.SQL.Clear;
FDCheques.SQL.Add('SELECT * FROM CHEQUES');
FDCheques.Open();
FDCheques.FetchAll;
Result := FDCheques;
Except
   on e : exception do
      begin
      raise Exception.Create('Erro na função buscarTodosRepresentantes ' + e.Message);
      end;
   end;
end;

end.
