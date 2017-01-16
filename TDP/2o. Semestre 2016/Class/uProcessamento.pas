unit uProcessamento;

interface

uses
   FireDAC.Comp.Client, SysUtils, Vcl.Forms, Windows, Vcl.Controls, Data.DB,
   System.Classes, Vcl.CheckLst, UFuncoesFaciliteXE8, uConstantes;

type TProcessamento = class
   private
      class var vloFuncoes : TFuncoesGerais;
      class var vldPeriodoTrimestreInicial : String;
      class var vldPeriodoTrimestreFinal : String;
      class procedure pcdMesesTrimestre(piTrimestre: Integer; var poFDMemTable: TFDMemTable);
      class procedure pcdApuraImpostoTrimestre(piTrimestre: Integer; psAno: String; var poFDMemTable: TFDMemTable; poConexao: TFDConnection);
      class procedure pcdApuraImpostoMensal(piMes: Integer; psAno: String; var poFDMemTable: TFDMemTable; poConexao: TFDConnection);
      class function fncCalculaIRPJ(var vldPresuncaoIR, vldAliqIRPJ, vldValorApurado, vldReceitaFinac, vldAdicionalIR, vldDeducaoIR, vldBaseImposto: Double): Double;
    class function fncCalculaCSLL(var vldPresuncaoIR, vldAliqCSLL,
      vldValorApurado, vldDeducaoCSLL, vldBaseImposto: Double): Double; static;
   public
      class var vgTipoSelecionados : String;
      class var vgdValorDigitadoTrimestral : Double;
      class var vgbRecalcula : Boolean;
      class procedure pcdApuraMesTrimestre(piTrimestre: Integer; psAno: String; var poFDMemTable: TFDMemTable); static;
      class function fncRetornaDataFinal(piMes, piAno: Integer): String;
      class function fncProcessaTrimestre(psEmpresa: String; piTrimestre: Integer; psAno: String; var poMemTable : TFDMemTable; pdDedecaoCSLL, pdDeducaoIRPJ, pdReceitaFinanc : Double; const poConexao: TFDConnection) : Boolean;
      class function fncProcessaMes(psEmpresa: String; piMes: Integer; psAno: String; var poMemTable : TFDMemTable; const poConexao: TFDConnection) : Boolean;
    class procedure pcdGravarRegistroTabela(var poMemTable: TFDMemTable; vldValorApurado: Double; vldValorIRPJ: Double; vldValorCSLL: Double; vldReceitaFinanceira: Double; vldAdicionalIR: Double; vldBaseImpostoIRPJ: Double; vldDeducaoIRPJ: Double; vldDeducaoCSLL: Double; vldBaseImpostoCSLL: Double);

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

class procedure TProcessamento.pcdApuraMesTrimestre(piTrimestre: Integer; psAno: String; var poFDMemTable: TFDMemTable);
var
   vlDataIni, vlDataFim : String;
begin
if piTrimestre = 1 then
   begin
   vlDataIni := '01/01/' + psAno;
   vlDataFim := '31/03/' + psAno;
   end
else if piTrimestre = 2 then
   begin
   vlDataIni := '01/04/' + psAno;
   vlDataFim := '30/06/' + psAno;
   end
else if piTrimestre = 3 then
   begin
   vlDataIni := '01/07/' + psAno;
   vlDataFim := '30/09/' + psAno;
   end
else
   begin
   vlDataIni := '01/10/' + psAno;
   vlDataFim := '31/12/' + psAno;
   end;

TProcessamento.vldPeriodoTrimestreInicial := vlDataIni;
TProcessamento.vldPeriodoTrimestreFinal   := vlDataFim;
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

class function TProcessamento.fncProcessaTrimestre(psEmpresa: String; piTrimestre: Integer; psAno: String; var poMemTable : TFDMemTable;
                                                   pdDedecaoCSLL, pdDeducaoIRPJ, pdReceitaFinanc : Double;
                                                   const poConexao: TFDConnection) : Boolean;
var
   FDConsultaNFFiscal : TFDQuery;
   vldValorApurado, vldAliqIRPJ, vldAliqCSLL,
   vldValorIRPJ, vldValorCSLL, vldPresuncaoIRPJ,
   vldReceitaFinanceira, vldAdicionalIR, vldBaseImpostoIRPJ,
   vldDeducaoIRPJ, vldDeducaoCSLL, vldPresuncaoCSLL, vldBaseImpostoCSLL : Double;
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
pcdApuraMesTrimestre(piTrimestre, psAno, poMemTable);
vldValorApurado      := 0;
vldAliqIRPJ          := 0;
vldAliqCSLL          := 0;
vldValorIRPJ         := 0;
vldValorCSLL         := 0;
vldPresuncaoIRPJ     := 0;
vldReceitaFinanceira := pdReceitaFinanc;
vldAdicionalIR       := 0;
vldBaseImpostoIRPJ   := 0;
vldDeducaoIRPJ       := pdDeducaoIRPJ;
vldDeducaoCSLL       := pdDedecaoCSLL;
vldPresuncaoCSLL     := 0;
vldBaseImpostoCSLL   := 0;

if vgdValorDigitadoTrimestral = 0 then
   begin
   FDConsultaNFFiscal.SQL.Clear;
   FDConsultaNFFiscal.SQL.Add('SELECT SUM(NF_VALOR) AS VALOR FROM NFISCAL WHERE NF_EMPRESA = :EMPRESA AND NF_TIPO IN ('+vgTipoSelecionados+') AND');
   FDConsultaNFFiscal.SQL.Add('                                                 NF_EMISSAO BETWEEN :DATAINI AND :DATAFIM AND ');
   FDConsultaNFFiscal.SQL.Add('                                                ((NF_OPERACAO = :OPERACAO) or (NF_OPERACAO IS NULL)) AND');
   FDConsultaNFFiscal.SQL.Add('                                                 NF_STATUSNFE = :STATUS');
   FDConsultaNFFiscal.ParamByName('EMPRESA').AsString  := psEmpresa;
   FDConsultaNFFiscal.ParamByName('DATAINI').AsString  := FormatDateTime('mm/dd/yyyy', StrToDate(TProcessamento.vldPeriodoTrimestreInicial));
   FDConsultaNFFiscal.ParamByName('DATAFIM').AsString  := FormatDateTime('mm/dd/yyyy', StrToDate(TProcessamento.vldPeriodoTrimestreFinal));
   FDConsultaNFFiscal.ParamByName('OPERACAO').AsString := 'False';
   FDConsultaNFFiscal.ParamByName('STATUS').AsString   := 'I';
   FDConsultaNFFiscal.Open;

   vldValorApurado := FDConsultaNFFiscal.FieldByName('VALOR').AsFloat;
   end
else
   vldValorApurado := vgdValorDigitadoTrimestral;

FDConsultaNFFiscal.SQL.Clear;
FDConsultaNFFiscal.SQL.Add('SELECT * FROM APURAIMPOSTOCONFIG WHERE CONFAI_EMPRESA = :EMPRESA');
FDConsultaNFFiscal.ParamByName('EMPRESA').AsString  := psEmpresa;
FDConsultaNFFiscal.Open;

vldAliqIRPJ      := FDConsultaNFFiscal.FieldByName('CONFAI_ALIQIRPJ').AsFloat;
vldAliqCSLL      := FDConsultaNFFiscal.FieldByName('CONFAI_ALIQCSLL').AsFloat;
vldPresuncaoIRPJ := FDConsultaNFFiscal.FieldByName('CONFAI_PRESIRPJ').AsFloat;
vldPresuncaoCSLL := FDConsultaNFFiscal.FieldByName('CONFAI_PRESCSLL').AsFloat;

//CALCULAR IRPJ
vldValorIRPJ     := fncCalculaIRPJ(vldPresuncaoIRPJ, vldAliqIRPJ, vldValorApurado,
                                   vldReceitaFinanceira, vldAdicionalIR, vldDeducaoIRPJ,
                                   vldBaseImpostoIRPJ);

//CALCULAR CSLL
vldValorCSLL     := fncCalculaCSLL(vldPresuncaoCSLL, vldAliqCSLL, vldValorApurado, vldDeducaoCSLL, vldBaseImpostoCSLL);
pcdGravarRegistroTabela(poMemTable, vldValorApurado, vldValorIRPJ, vldValorCSLL, vldReceitaFinanceira, vldAdicionalIR, vldBaseImpostoIRPJ, vldDeducaoIRPJ, vldDeducaoCSLL, vldBaseImpostoCSLL);

finally
   FreeAndNil(vloFuncoes);
   FreeAndNil(FDConsultaNFFiscal);
   end;


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

class procedure TProcessamento.pcdGravarRegistroTabela(var poMemTable: TFDMemTable; vldValorApurado: Double; vldValorIRPJ: Double; vldValorCSLL: Double; vldReceitaFinanceira: Double; vldAdicionalIR: Double; vldBaseImpostoIRPJ: Double; vldDeducaoIRPJ: Double; vldDeducaoCSLL: Double; vldBaseImpostoCSLL: Double);
begin
poMemTable.Append;
poMemTable.FieldByName('IMPOSTO').AsString := 'IRPJ';
poMemTable.FieldByName('BASECALCULO').AsFloat := vldValorApurado;
poMemTable.FieldByName('RECEITAFINAC').AsFloat := vldReceitaFinanceira;
poMemTable.FieldByName('AdicionalIRPJ').AsFloat := vldAdicionalIR;
poMemTable.FieldByName('DeducoesImposto').AsFloat := vldDeducaoIRPJ;
poMemTable.FieldByName('ValorImposto').AsFloat := vldValorIRPJ;
poMemTable.FieldByName('BaseImposto').AsFloat := vldBaseImpostoIRPJ;
poMemTable.FieldByName('ValorApurado').AsFloat := vldValorApurado;
poMemTable.Post;


poMemTable.Append;
poMemTable.FieldByName('IMPOSTO').AsString := 'CSLL';
poMemTable.FieldByName('BASECALCULO').AsFloat := vldValorApurado;
poMemTable.FieldByName('RECEITAFINAC').AsFloat := 0;
poMemTable.FieldByName('AdicionalIRPJ').AsFloat := 0;
poMemTable.FieldByName('DeducoesImposto').AsFloat := vldDeducaoCSLL;
poMemTable.FieldByName('ValorImposto').AsFloat := vldValorCSLL;
poMemTable.FieldByName('BaseImposto').AsFloat := vldBaseImpostoCSLL;
poMemTable.FieldByName('ValorApurado').AsFloat := vldValorApurado;
poMemTable.Post;
end;

class function TProcessamento.fncCalculaIRPJ(var vldPresuncaoIR: Double; var vldAliqIRPJ: Double; var vldValorApurado :Double; var vldReceitaFinac: Double; var vldAdicionalIR: Double; var vldDeducaoIR: Double; var vldBaseImposto: Double): Double;
var
   vlCalculo, vlAdicional : Double;
begin
vlCalculo := 0;

vlCalculo      := vldValorApurado * (vldPresuncaoIR / 100); //Calculando a Presunção do IRPJ
vldBaseImposto := vlCalculo + vldReceitaFinac; // Somando a Receita Financeira (Base do Imposto)

if vldBaseImposto > 60000 then // Calculo do Adicional caso o Valor seja maior que R$ 60.000,00.
   begin
   vlAdicional    := vldBaseImposto - 60000;
   vldAdicionalIR := vlAdicional * 0.10;
   end;

vlCalculo := vldBaseImposto * (vldAliqIRPJ / 100);

if vldAdicionalIR > 0 then // Caso o Valor do adicional seja maior que Zero, ele adiciona 10% no valor do imposto.
   vlCalculo := vlCalculo + vldAdicionalIR;

vlCalculo := vlCalculo - vldDeducaoIR;

Result := vlCalculo
end;

class function TProcessamento.fncCalculaCSLL(var vldPresuncaoIR: Double; var vldAliqCSLL: Double; var vldValorApurado :Double; var vldDeducaoCSLL: Double; var vldBaseImposto: Double): Double;
var
   vlCalculo : Double;
begin
vlCalculo      := 0;
vldBaseImposto := vldValorApurado * (vldPresuncaoIR / 100); //Calculando a Presunção do CSLL
vlCalculo      := vldBaseImposto * (vldAliqCSLL / 100); // Aplicando a Alíquota do CSLL
vlCalculo      := vlCalculo - vldDeducaoCSLL;

Result := vlCalculo
end;

end.

