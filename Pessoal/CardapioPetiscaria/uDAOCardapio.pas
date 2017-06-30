unit uDAOCardapio;

interface

uses
   UCardapio, FireDAc.Comp.Client;

type TDAOCardapio = class(TCardapio)
  private
     FConexao : TFDConnection;

  public
     constructor Create(poConexao: TFDConnection);
     destructor Destroy;
     function fncInsereProduto: Boolean;
     function fncDeletaProduto: Boolean;

  published

end;

implementation

uses
  System.SysUtils;

{ TDAOCardapio }

constructor TDAOCardapio.Create(poConexao: TFDConnection);
begin
inherited Create;

FConexao := poConexao;
end;

destructor TDAOCardapio.Destroy;
begin
inherited Destroy;
end;

function TDAOCardapio.fncDeletaProduto: Boolean;
var
   poQuery : TFDQuery;
begin
poQuery := TFDQuery.Create(nil);

try
poQuery.Close;
poQuery.Connection := FConexao;
poQuery.SQL.Clear;
poQuery.SQL.Add('DELETE FROM CARDAPIO WHERE (PRO_CODIGO = :PRO_CODIGO) AND (PRO_GRUPO = :PRO_GRUPO)');
poQuery.ParamByName('PRO_CODIGO').AsInteger := PRO_CODIGO;
poQuery.ParamByName('PRO_GRUPO').AsInteger  := PRO_GRUPO;
poQuery.ExecSQL;

finally
   FreeAndNil(poQuery);
   end;
end;

function TDAOCardapio.fncInsereProduto: Boolean;
var
   poQuery : TFDQuery;
begin
poQuery := TFDQuery.Create(nil);

try
poQuery.Close;
poQuery.Connection := FConexao;
poQuery.SQL.Clear;
if PRO_CODIGO = 0 then
   begin
   poQuery.SQL.Add('INSERT INTO CARDAPIO (PRO_GRUPO, PRO_DESCRICAO,');
   poQuery.SQL.Add('                      PRO_VALORMEIA, PRO_VALORINTEIRA)');
   poQuery.SQL.Add('VALUES (:PRO_GRUPO, :PRO_DESCRICAO, :PRO_VALORMEIA, :PRO_VALORINTEIRA)');
   end
else
   begin
   poQuery.SQL.Add('UPDATE CARDAPIO');
   poQuery.SQL.Add('SET PRO_DESCRICAO = :PRO_DESCRICAO,');
   poQuery.SQL.Add('    PRO_VALORMEIA = :PRO_VALORMEIA,');
   poQuery.SQL.Add('    PRO_VALORINTEIRA = :PRO_VALORINTEIRA');
   poQuery.SQL.Add('WHERE (PRO_CODIGO = :PRO_CODIGO) AND (PRO_GRUPO = :PRO_GRUPO)');
   poQuery.ParamByName('PRO_CODIGO').AsInteger  := PRO_CODIGO;
   end;

poQuery.ParamByName('PRO_GRUPO').AsInteger      := PRO_GRUPO;
poQuery.ParamByName('PRO_DESCRICAO').AsString   := PRO_DESCRICAO;
poQuery.ParamByName('PRO_VALORMEIA').AsFloat    := PRO_VALORMEIA;
poQuery.ParamByName('PRO_VALORINTEIRA').AsFloat := PRO_VALORINTEIRA;
poQuery.ExecSQL;

finally
   FreeAndNil(poQuery);
   end;
end;

end.
