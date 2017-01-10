unit uConsultas;

interface

uses
   FireDAC.Comp.Client, SysUtils, Vcl.Forms, Windows, Vcl.Controls, Data.DB,
   System.Classes, Vcl.CheckLst, UFuncoesFaciliteXE8, uConstantes;

type TConsultas = class
   public
      class function fncConsultaDescricaoEmpresa(psEmpresa : String; const poConexao : TFDConnection) : String;

end;

implementation

class function TConsultas.fncConsultaDescricaoEmpresa(psEmpresa : String; const poConexao : TFDConnection) : String;
var
   FDConsulta : TFDQuery;
begin
FDConsulta := TFDQuery.Create(nil);
try
FDConsulta.Close;
FDConsulta.Connection := poConexao;
FDConsulta.SQL.Clear;
FDConsulta.SQL.Add('SELECT EMP_DESCRICAO FROM EMPRESA WHERE EMP_CODIGO = :EMPRESA');
FDConsulta.ParamByName('EMPRESA').AsString := psEmpresa;
FDConsulta.Open;

Result := FDConsulta.FieldByName('EMP_DESCRICAO').AsString;
finally
   FreeAndNil(FDConsulta);
   end;
end;

end.
