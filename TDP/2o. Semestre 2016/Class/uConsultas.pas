unit uConsultas;

interface

uses
   FireDAC.Comp.Client, SysUtils, Vcl.Forms, Windows, Vcl.Controls, Data.DB,
   System.Classes, Vcl.CheckLst, UFuncoesFaciliteXE8, uConstantes;

type TConsultas = class
   public
      class function fncConsultaDescricaoEmpresa(psEmpresa : String; const poConexao : TFDConnection) : String;
      class function fncConsultaDadosEmpresa(psEmpresa : String; const poConexao : TFDConnection) : TFDQuery;
      class function fncConsultaDadosApuracaoMensal(psEmpresa : String; const poConexao : TFDConnection) : TFDQuery;
      class function fncConsultaDadosApuracaoTrimestral(psEmpresa : String; const poConexao : TFDConnection) : TFDQuery;
      class function fncConsultaAliquotaIRPJ(psEmpresa : String; const poConexao : TFDConnection) : Double;
      class function fncConsultaAliquotaCSLL(psEmpresa : String; const poConexao : TFDConnection) : Double;
      class function fncConsultaPresuncaoIRPJ(psEmpresa : String; const poConexao : TFDConnection) : Double;
      class function fncConsultaPresuncaoCSLL(psEmpresa : String; const poConexao : TFDConnection) : Double;

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

class function TConsultas.fncConsultaPresuncaoCSLL(psEmpresa: String;
  const poConexao: TFDConnection): Double;
var
   FDConsulta : TFDQuery;
begin
FDConsulta := TFDQuery.Create(nil);
try
FDConsulta.Close;
FDConsulta.Connection := poConexao;
FDConsulta.SQL.Clear;
FDConsulta.SQL.Add('SELECT CONFAI_PRESCSLL FROM APURAIMPOSTOCONFIG WHERE CONFAI_EMPRESA = :EMPRESA');
FDConsulta.ParamByName('EMPRESA').AsString := psEmpresa;
FDConsulta.Open;

Result := FDConsulta.FieldByName('CONFAI_PRESCSLL').AsFloat;
finally
   FreeAndNil(FDConsulta);
   end;
end;

class function TConsultas.fncConsultaPresuncaoIRPJ(psEmpresa: String;
  const poConexao: TFDConnection): Double;
var
   FDConsulta : TFDQuery;
begin
FDConsulta := TFDQuery.Create(nil);
try
FDConsulta.Close;
FDConsulta.Connection := poConexao;
FDConsulta.SQL.Clear;
FDConsulta.SQL.Add('SELECT CONFAI_PRESIRPJ FROM APURAIMPOSTOCONFIG WHERE CONFAI_EMPRESA = :EMPRESA');
FDConsulta.ParamByName('EMPRESA').AsString := psEmpresa;
FDConsulta.Open;

Result := FDConsulta.FieldByName('CONFAI_PRESIRPJ').AsFloat;
finally
   FreeAndNil(FDConsulta);
   end;
end;

class function TConsultas.fncConsultaDadosApuracaoTrimestral(psEmpresa: String;
  const poConexao: TFDConnection): TFDQuery;
var
   FDConsulta : TFDQuery;
begin
FDConsulta := TFDQuery.Create(nil);
FDConsulta.Close;
FDConsulta.Connection := poConexao;
FDConsulta.SQL.Clear;
FDConsulta.SQL.Add('SELECT * FROM APURAIMPOSTOTRIMESTRAL WHERE AITRIMES_EMPRESA = :EMPRESA ORDER BY AITRIMES_EMPRESA, AITRIMES_TRIMESTRE, AITRIMES_IMPOSTO');
FDConsulta.ParamByName('EMPRESA').AsString := psEmpresa;
FDConsulta.Open;

Result := FDConsulta;
end;

class function TConsultas.fncConsultaAliquotaCSLL(psEmpresa: String;
  const poConexao: TFDConnection): Double;
var
   FDConsulta : TFDQuery;
begin
FDConsulta := TFDQuery.Create(nil);
try
FDConsulta.Close;
FDConsulta.Connection := poConexao;
FDConsulta.SQL.Clear;
FDConsulta.SQL.Add('SELECT CONFAI_ALIQCSLL FROM APURAIMPOSTOCONFIG WHERE CONFAI_EMPRESA = :EMPRESA');
FDConsulta.ParamByName('EMPRESA').AsString := psEmpresa;
FDConsulta.Open;

Result := FDConsulta.FieldByName('CONFAI_ALIQCSLL').AsFloat;
finally
   FreeAndNil(FDConsulta);
   end;
end;

class function TConsultas.fncConsultaAliquotaIRPJ(psEmpresa: String;
  const poConexao: TFDConnection): Double;
var
   FDConsulta : TFDQuery;
begin
FDConsulta := TFDQuery.Create(nil);
try
FDConsulta.Close;
FDConsulta.Connection := poConexao;
FDConsulta.SQL.Clear;
FDConsulta.SQL.Add('SELECT CONFAI_ALIQIRPJ FROM APURAIMPOSTOCONFIG WHERE CONFAI_EMPRESA = :EMPRESA');
FDConsulta.ParamByName('EMPRESA').AsString := psEmpresa;
FDConsulta.Open;

Result := FDConsulta.FieldByName('CONFAI_ALIQIRPJ').AsFloat;

finally
   FreeAndNil(FDConsulta);
   end;
end;

class function TConsultas.fncConsultaDadosApuracaoMensal(psEmpresa: String;
  const poConexao: TFDConnection): TFDQuery;
var
   FDConsulta : TFDQuery;
begin
FDConsulta := TFDQuery.Create(nil);
FDConsulta.Close;
FDConsulta.Connection := poConexao;
FDConsulta.SQL.Clear;
FDConsulta.SQL.Add('SELECT * FROM APURAIMPOSTOMENSAL WHERE AIMES_EMPRESA = :EMPRESA ORDER BY AIMES_EMPRESA, AIMES_MES, AIMES_IMPOSTO');
FDConsulta.ParamByName('EMPRESA').AsString := psEmpresa;
FDConsulta.Open;

Result := FDConsulta;
end;

class function TConsultas.fncConsultaDadosEmpresa(psEmpresa : String; const poConexao : TFDConnection) : TFDQuery;
var
   FDConsulta : TFDQuery;
begin
FDConsulta := TFDQuery.Create(nil);
FDConsulta.Close;
FDConsulta.Connection := poConexao;
FDConsulta.SQL.Clear;
FDConsulta.SQL.Add('SELECT EMP_CGC, EMP_DESCRICAO, EMP_TELEFONE, EMP_CIDADE FROM EMPRESA WHERE EMP_CODIGO = :EMPRESA');
FDConsulta.ParamByName('EMPRESA').AsString := psEmpresa;
FDConsulta.Open;

Result := FDConsulta;

end;

end.
