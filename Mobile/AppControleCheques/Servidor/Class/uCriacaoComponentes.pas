unit uCriacaoComponentes;

interface

uses FireDAC.Comp.Client, System.SysUtils, Data.DB, System.Classes;

type TCriacaoFB = class(TObject)
   public
      class function  criaTFDQuery(FConexao: TFDConnection): TFDQuery;
  end;

implementation

{ TCriacaoFB }

class function TCriacaoFB.criaTFDQuery(FConexao: TFDConnection): TFDQuery;
var
   vlFDQuery : TFDQuery;
begin
vlFDQuery := TFDQuery.Create(nil);
vlFDQuery.Connection := FConexao;
Result := vlFDQuery;
end;

end.
