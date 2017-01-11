unit uProcessamento;

interface

uses
   FireDAC.Comp.Client, SysUtils, Vcl.Forms, Windows, Vcl.Controls, Data.DB,
   System.Classes, Vcl.CheckLst, UFuncoesFaciliteXE8, uConstantes;

type TProcessamento = class
   private
      class var vloFuncoes : TFuncoesGerais;
      class procedure pcdMesesTrimestre(piTrimestre: Integer; var poFDMemTable: TFDMemTable);
      class procedure pcdApuraImpostoTrimestre(piTrimestre: Integer; psAno: String; var poFDMemTable: TFDMemTable; poConexao: TFDConnection);
      class procedure pcdApuraImpostoMensal(piMes: Integer; psAno: String; var poFDMemTable: TFDMemTable; poConexao: TFDConnection);
      class function fncRetornaDataFinal(piMes, piAno: Integer): String;
   public
      class var vgTipoSelecionados : String;
      class function fncProcessaTrimestre(piTrimestre: Integer; psAno: String; var poMemTable : TFDMemTable;
                                         const poConexao: TFDConnection) : Boolean;
      class function fncProcessaMes(psEmpresa: String; piMes: Integer; psAno: String; var poMemTable : TFDMemTable;
                                    const poConexao: TFDConnection) : Boolean;

end;

implementation

class procedure TProcessamento.pcdApuraImpostoTrimestre(piTrimestre: Integer; psAno: String; var poFDMemTable: TFDMemTable; poConexao: TFDConnection);
begin


end;

class procedure TProcessamento.pcdApuraImpostoMensal(piMes: Integer; psAno: String; var poFDMemTable: TFDMemTable; poConexao: TFDConnection);
begin


end;

class function TProcessamento.fncRetornaDataFinal(piMes, piAno: Integer): String;
var
   vlDataFinal : String;
begin
if ((piMes = 1) or (piMes = 3) or
    (piMes = 5) or (piMes = 7) or
    (piMes = 8) or (piMes = 10) or
    (piMes = 12)) then
   begin
   vlDataFinal := '31/'+FormatFloat('00', piMes)+'/'+FormatFloat('0000', piAno);
   end
else if ((piMes = 4) or (piMes = 6) or
         (piMes = 9) or (piMes = 11)) then
   begin
   vlDataFinal := '30/'+FormatFloat('00', piMes)+'/'+FormatFloat('0000', piAno);
   end
else
   begin
   if IsLeapYear(piAno) then
      vlDataFinal := '29/'+FormatFloat('00', piMes)+'/'+FormatFloat('0000', piAno)
   else
      vlDataFinal := '28/'+FormatFloat('00', piMes)+'/'+FormatFloat('0000', piAno);
   end;

Result := vlDataFinal;
end;

class procedure TProcessamento.pcdMesesTrimestre(piTrimestre: Integer; var poFDMemTable: TFDMemTable);
var
   vgsMeses : Array[1..3] of String;
  I: Integer;
begin
if not poFDMemTable.IsEmpty then
   begin
   poFDMemTable.First;

   while not poFDMemTable.Eof do
      poFDMemTable.Delete;
   end;

if piTrimestre = 1 then
   begin
   vgsMeses[1] := 'JANEIRO';
   vgsMeses[2] := 'FEVEREIRO';
   vgsMeses[3] := 'MARÇO';
   end
else if piTrimestre = 2 then
   begin
   vgsMeses[1] := 'ABRIL';
   vgsMeses[2] := 'MAIO';
   vgsMeses[3] := 'JUNHO';
   end
else if piTrimestre = 3 then
   begin
   vgsMeses[1] := 'JULHO';
   vgsMeses[2] := 'AGOSTO';
   vgsMeses[3] := 'SETEMBRO';
   end
else
   begin
   vgsMeses[1] := 'OUTUBRO';
   vgsMeses[2] := 'NOVEMBRO';
   vgsMeses[3] := 'DEZEMBRO';
   end;

for I := Low(vgsMeses) to High(vgsMeses) do
   begin
   poFDMemTable.Append;
   poFDMemTable.FieldByName('Mes').AsString := vgsMeses[I];
   poFDMemTable.Post;
   end;
end;

class function TProcessamento.fncProcessaTrimestre(piTrimestre: Integer; psAno: String; var poMemTable : TFDMemTable;
                                                   const poConexao: TFDConnection) : Boolean;
begin
pcdMesesTrimestre(piTrimestre, poMemTable);



end;

class function TProcessamento.fncProcessaMes(psEmpresa: String; piMes: Integer; psAno: String; var poMemTable : TFDMemTable;
                                             const poConexao: TFDConnection) : Boolean;
var
   FDConsultaNFFiscal : TFDQuery;
   vldValorApurado, vldAliqPis, vldAliqCofins,
   vldValorPis, vldValorCofins : Double;
begin
if not poMemTable.IsEmpty then
   begin
   poMemTable.First;

   while not poMemTable.Eof do
      poMemTable.Delete;
   end;

vloFuncoes := TFuncoesGerais.Create(poConexao);
vloFuncoes.pcdCriaFDQueryExecucao(FDConsultaNFFiscal, poConexao);
try
FDConsultaNFFiscal.SQL.Clear;
FDConsultaNFFiscal.SQL.Add('SELECT SUM(NF_VALOR) AS VALOR FROM NFISCAL WHERE NF_EMPRESA = :EMPRESA AND NF_TIPO IN ('+vgTipoSelecionados+') AND');
FDConsultaNFFiscal.SQL.Add('                                                 NF_EMISSAO BETWEEN :DATAINI AND :DATAFIM AND ');
FDConsultaNFFiscal.SQL.Add('                                                ((NF_OPERACAO = :OPERACAO) or (NF_OPERACAO IS NULL)) AND');
FDConsultaNFFiscal.SQL.Add('                                                 NF_STATUSNFE = :STATUS');
FDConsultaNFFiscal.ParamByName('EMPRESA').AsString  := psEmpresa;
FDConsultaNFFiscal.ParamByName('DATAINI').AsString  := FormatDateTime('mm/dd/yyyy', StrToDate('01/'+FormatFloat('00', piMes)+'/'+psAno));
FDConsultaNFFiscal.ParamByName('DATAFIM').AsString  := FormatDateTime('mm/dd/yyyy', StrToDate(fncRetornaDataFinal(piMes, StrToInt(psAno))));
FDConsultaNFFiscal.ParamByName('OPERACAO').AsString := 'False';
FDConsultaNFFiscal.ParamByName('STATUS').AsString   := 'I';
FDConsultaNFFiscal.Open;
vldValorApurado := FDConsultaNFFiscal.FieldByName('VALOR').AsFloat;

FDConsultaNFFiscal.SQL.Clear;
FDConsultaNFFiscal.SQL.Add('SELECT * FROM APURAIMPOSTOCONFIG WHERE CONFAI_EMPRESA = :EMPRESA');
FDConsultaNFFiscal.ParamByName('EMPRESA').AsString  := psEmpresa;
FDConsultaNFFiscal.Open;

vldAliqPis     := FDConsultaNFFiscal.FieldByName('CONFAI_ALIQPIS').AsFloat;
vldAliqCofins  := FDConsultaNFFiscal.FieldByName('CONFAI_ALIQCOFINS').AsFloat;

vldValorPis    := vldValorApurado * (vldAliqPis / 100);
vldValorCofins := vldValorApurado * (vldAliqCofins / 100);

poMemTable.Append;
poMemTable.FieldByName('IMPOSTO').AsString     := 'PIS';
poMemTable.FieldByName('VALORAPURADO').AsFloat := vldValorApurado;
poMemTable.FieldByName('BASECALCULO').AsFloat  := vldValorApurado;
poMemTable.FieldByName('ALIQUOTA').AsFloat     := vldAliqPis;
poMemTable.FieldByName('VALORIMPOSTO').AsFloat := vldValorPis;
poMemTable.Post;

poMemTable.Append;
poMemTable.FieldByName('IMPOSTO').AsString     := 'COFINS';
poMemTable.FieldByName('VALORAPURADO').AsFloat := vldValorApurado;
poMemTable.FieldByName('BASECALCULO').AsFloat  := vldValorApurado;
poMemTable.FieldByName('ALIQUOTA').AsFloat     := vldAliqCofins;
poMemTable.FieldByName('VALORIMPOSTO').AsFloat := vldValorCofins;
poMemTable.Post;

finally
   FreeAndNil(vloFuncoes);
   FreeAndNil(FDConsultaNFFiscal);
   end;
end;


end.

