unit uDAOGrupo;

interface

uses
   UGrupos, FireDAc.Comp.Client;

type TDAOGrupo = class(TGrupos)
  private
     FConexao : TFDConnection;

  public
     constructor Create(poConexao: TFDConnection);
     destructor Destroy;
     function fncConsultaGrupo: String;

  published

end;

implementation

uses
  System.SysUtils;

{ TDAOCardapio }

constructor TDAOGrupo.Create(poConexao: TFDConnection);
begin
inherited Create;

FConexao := poConexao;
end;

destructor TDAOGrupo.Destroy;
begin
inherited Destroy;
end;

function TDAOGrupo.fncConsultaGrupo: String;
var
   poQuery : TFDQuery;
begin
poQuery := TFDQuery.Create(nil);

try
poQuery.Close;
poQuery.Connection := FConexao;
poQuery.SQL.Clear;
poQuery.SQL.Add('SELECT GRUPO_DESCRICAO FROM GRUPO WHERE GRUPO_CODIGO = :CODIGO');
poQuery.ParamByName('CODIGO').AsInteger := GRUPO_CODIGO;
poQuery.Open;

Result := poQuery.FieldByName('GRUPO_DESCRICAO').AsString;

finally
   FreeAndNil(poQuery);
   end;
end;

end.

