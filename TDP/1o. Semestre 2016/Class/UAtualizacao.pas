unit UAtualizacao;

interface

uses
   FireDac.Comp.Client, System.SysUtils;

type
   TAtualizacao = class(TObject)

      private
       FConexao : TFDConnection;

      protected

      public
       constructor Create(PoConexao : TFDConnection);
       function fncAtualizaTabelasFirebird : TFDQuery;

      published

   end;

implementation

{ TAtualizacao }

constructor TAtualizacao.Create(PoConexao: TFDConnection);
begin
Inherited Create;

FConexao := PoConexao;
end;

function TAtualizacao.fncAtualizaTabelasFirebird: TFDQuery;
var
   QTabelas : TFDQuery;
begin
QTabelas := TFDQuery.Create(nil);
try
QTabelas.Close;
QTabelas.Connection := FConexao;
QTabelas.SQL.Clear;
QTabelas.SQL.Add('SELECT RDB$RELATION_NAME AS TABELAS FROM RDB$RELATIONS');
QTabelas.SQL.Add('WHERE RDB$SYSTEM_FLAG = 0');
QTabelas.SQL.Add('ORDER BY RDB$RELATION_NAME ');
QTabelas.Open;

Result := QTabelas;

finally
   //FreeAndNil(QTabelas);
   end;

end;

end.
