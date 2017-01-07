unit UConfiguracao;

interface

uses
   FireDAC.Comp.Client, SysUtils, Vcl.Forms, Windows, Vcl.Controls, Data.DB,
   System.Classes, Vcl.CheckLst, UFuncoesFaciliteXE8, uConstantes;

type
   TConfiguracao = class(TObject)

   private
      FConexao : TFDConnection;
      vloFuncoes : TFuncoesGerais;
    FCONFAI_PRESIRPJ: Double;
    FCONFAI_EMPRESA: String;
    FCONFAI_ALIQCSLL: Double;
    FCONFAI_ALIQIRPJ: Double;
    FCONFAI_ALIQPIS: Double;
    FCONFAI_ALIQCOFINS: Double;
    FCONFAI_PRESCSLL: Double;
    FCONFAI_TIPOSNF: String;
    procedure SetCONFAI_ALIQCOFINS(const Value: Double);
    procedure SetCONFAI_ALIQCSLL(const Value: Double);
    procedure SetCONFAI_ALIQIRPJ(const Value: Double);
    procedure SetCONFAI_ALIQPIS(const Value: Double);
    procedure SetCONFAI_EMPRESA(const Value: String);
    procedure SetCONFAI_PRESCSLL(const Value: Double);
    procedure SetCONFAI_PRESIRPJ(const Value: Double);
    procedure SetCONFAI_TIPOSNF(const Value: String);

   public
      constructor Create(poConexao: TFDConnection);
      destructor Destroy; override;
      function fncRetornaTipoNF(psEmpresa: String) : TFDQuery;
      procedure pcdGravaConfiguracao;

   published
      property CONFAI_EMPRESA    : String read FCONFAI_EMPRESA write SetCONFAI_EMPRESA;
      property CONFAI_TIPOSNF    : String read FCONFAI_TIPOSNF write SetCONFAI_TIPOSNF;
      property CONFAI_ALIQPIS    : Double read FCONFAI_ALIQPIS write SetCONFAI_ALIQPIS;
      property CONFAI_ALIQCOFINS : Double read FCONFAI_ALIQCOFINS write SetCONFAI_ALIQCOFINS;
      property CONFAI_ALIQIRPJ   : Double read FCONFAI_ALIQIRPJ write SetCONFAI_ALIQIRPJ;
      property CONFAI_ALIQCSLL   : Double read FCONFAI_ALIQCSLL write SetCONFAI_ALIQCSLL;
      property CONFAI_PRESIRPJ   : Double read FCONFAI_PRESIRPJ write SetCONFAI_PRESIRPJ;
      property CONFAI_PRESCSLL   : Double read FCONFAI_PRESCSLL write SetCONFAI_PRESCSLL;

   end;

implementation

{ TConfiguracao }

constructor TConfiguracao.Create(poConexao: TFDConnection);
begin
inherited Create;

FConexao   := poConexao;
vloFuncoes := TFuncoesGerais.Create(FConexao);
end;

destructor TConfiguracao.Destroy;
begin
if Assigned(vloFuncoes) then
   FreeAndNil(vloFuncoes);

  inherited;
end;

function TConfiguracao.fncRetornaTipoNF(psEmpresa: String) : TFDQuery;
var
   FDConsulta : TFDQuery;
begin
vloFuncoes.pcdCriaFDQueryExecucao(FDConsulta, FConexao);
Result := nil;
FDConsulta.SQL.Clear;
FDConsulta.SQL.Add('SELECT DISTINCT(UPPER(NF_TIPO)) AS NF_TIPO FROM NFISCAL WHERE NF_EMPRESA = :EMPRESA ORDER BY NF_TIPO');
FDConsulta.ParamByName('EMPRESA').AsString := psEmpresa;
FDConsulta.Open;

if not FDConsulta.IsEmpty then
   Result := FDConsulta;
end;

procedure TConfiguracao.pcdGravaConfiguracao;
var
   FDConfig : TFDQuery;
begin
vloFuncoes.pcdCriaFDQueryExecucao(FDConfig, FConexao);
try
FDConfig.SQL.Clear;
FDConfig.SQL.Add('SELECT * FROM APURAIMPOSTOCONFIG WHERE CONFAI_EMPRESA = :EMPRESA');
FDConfig.ParamByName('EMPRESA').AsString := FCONFAI_EMPRESA;
FDConfig.Open;

if FDConfig.IsEmpty then
   begin
   FDConfig.SQL.Clear;
   FDConfig.SQL.Add('INSERT INTO APURAIMPOSTOCONFIG (CONFAI_EMPRESA, CONFAI_TIPOSNF, CONFAI_ALIQPIS, CONFAI_ALIQCOFINS,');
   FDConfig.SQL.Add('                                CONFAI_ALIQIRPJ, CONFAI_ALIQCSLL, CONFAI_PRESIRPJ, CONFAI_PRESCSLL)');
   FDConfig.SQL.Add('VALUES (:CONFAI_EMPRESA, :CONFAI_TIPOSNF, :CONFAI_ALIQPIS, :CONFAI_ALIQCOFINS,');
   FDConfig.SQL.Add('        :CONFAI_ALIQIRPJ, :CONFAI_ALIQCSLL, :CONFAI_PRESIRPJ, :CONFAI_PRESCSLL);');
   FDConfig.ParamByName('CONFAI_EMPRESA').AsString   := FCONFAI_EMPRESA;
   FDConfig.ParamByName('CONFAI_TIPOSNF').AsString   := FCONFAI_TIPOSNF;
   FDConfig.ParamByName('CONFAI_ALIQPIS').AsFloat    := FCONFAI_ALIQPIS;
   FDConfig.ParamByName('CONFAI_ALIQCOFINS').AsFloat := FCONFAI_ALIQCOFINS;
   FDConfig.ParamByName('CONFAI_ALIQIRPJ').AsFloat   := FCONFAI_ALIQIRPJ;
   FDConfig.ParamByName('CONFAI_ALIQCSLL').AsFloat   := FCONFAI_ALIQCSLL;
   FDConfig.ParamByName('CONFAI_PRESIRPJ').AsFloat   := FCONFAI_PRESIRPJ;
   FDConfig.ParamByName('CONFAI_PRESCSLL').AsFloat   := FCONFAI_PRESCSLL;
   FDConfig.ExecSQL;

   vloFuncoes.fncLogOperacao(FCONFAI_EMPRESA, '', '', 'Configuração de Imposto Gravada com as opções: '+
                                                      'Tipos: (' + Trim(Copy(FCONFAI_TIPOSNF, 1 , 90)) + ')'+
                                                      'Aliq PIS: ' + FormatFloat(',0.00', FCONFAI_ALIQPIS) +
                                                      'Aliq COFINS: ' + FormatFloat(',0.00', FCONFAI_ALIQCOFINS) +
                                                      'Aliq IRPJ: ' + FormatFloat(',0.00', FCONFAI_ALIQIRPJ) +
                                                      'Aliq CSLL: ' + FormatFloat(',0.00', FCONFAI_ALIQCSLL) +
                                                      'Pres IRPJ: ' + FormatFloat(',0.00', FCONFAI_PRESIRPJ) +
                                                      'Pres CSLL: ' + FormatFloat(',0.00', FCONFAI_PRESCSLL),
                                                      '',
                                                      OrigemLOG_ApuraImposta);
   end
else
   begin
   FDConfig.SQL.Clear;
   FDConfig.SQL.Add('UPDATE APURAIMPOSTOCONFIG');
   FDConfig.SQL.Add('SET CONFAI_TIPOSNF = :CONFAI_TIPOSNF,');
   FDConfig.SQL.Add('    CONFAI_ALIQPIS = :CONFAI_ALIQPIS,');
   FDConfig.SQL.Add('    CONFAI_ALIQCOFINS = :CONFAI_ALIQCOFINS,');
   FDConfig.SQL.Add('    CONFAI_ALIQIRPJ = :CONFAI_ALIQIRPJ,');
   FDConfig.SQL.Add('    CONFAI_ALIQCSLL = :CONFAI_ALIQCSLL,');
   FDConfig.SQL.Add('    CONFAI_PRESIRPJ = :CONFAI_PRESIRPJ,');
   FDConfig.SQL.Add('    CONFAI_PRESCSLL = :CONFAI_PRESCSLL');
   FDConfig.SQL.Add('WHERE (CONFAI_EMPRESA = :CONFAI_EMPRESA);');
   FDConfig.ParamByName('CONFAI_EMPRESA').AsString   := FCONFAI_EMPRESA;
   FDConfig.ParamByName('CONFAI_TIPOSNF').AsString   := FCONFAI_TIPOSNF;
   FDConfig.ParamByName('CONFAI_ALIQPIS').AsFloat    := FCONFAI_ALIQPIS;
   FDConfig.ParamByName('CONFAI_ALIQCOFINS').AsFloat := FCONFAI_ALIQCOFINS;
   FDConfig.ParamByName('CONFAI_ALIQIRPJ').AsFloat   := FCONFAI_ALIQIRPJ;
   FDConfig.ParamByName('CONFAI_ALIQCSLL').AsFloat   := FCONFAI_ALIQCSLL;
   FDConfig.ParamByName('CONFAI_PRESIRPJ').AsFloat   := FCONFAI_PRESIRPJ;
   FDConfig.ParamByName('CONFAI_PRESCSLL').AsFloat   := FCONFAI_PRESCSLL;
   FDConfig.ExecSQL;

   vloFuncoes.fncLogOperacao(FCONFAI_EMPRESA, '', '', 'Configuração de Imposto Alteradas com as opções: '+
                                                      'Tipos: (' + Trim(Copy(FCONFAI_TIPOSNF, 1 , 90)) + ')'+
                                                      'Aliq PIS: ' + FormatFloat(',0.00', FCONFAI_ALIQPIS) +
                                                      'Aliq COFINS: ' + FormatFloat(',0.00', FCONFAI_ALIQCOFINS) +
                                                      'Aliq IRPJ: ' + FormatFloat(',0.00', FCONFAI_ALIQIRPJ) +
                                                      'Aliq CSLL: ' + FormatFloat(',0.00', FCONFAI_ALIQCSLL) +
                                                      'Pres IRPJ: ' + FormatFloat(',0.00', FCONFAI_PRESIRPJ) +
                                                      'Pres CSLL: ' + FormatFloat(',0.00', FCONFAI_PRESCSLL),
                                                      '',
                                                      OrigemLOG_ApuraImposta);
   end;

finally
   FreeAndNil(FDConfig);
   end;
end;

procedure TConfiguracao.SetCONFAI_ALIQCOFINS(const Value: Double);
begin
  FCONFAI_ALIQCOFINS := Value;
end;

procedure TConfiguracao.SetCONFAI_ALIQCSLL(const Value: Double);
begin
  FCONFAI_ALIQCSLL := Value;
end;

procedure TConfiguracao.SetCONFAI_ALIQIRPJ(const Value: Double);
begin
  FCONFAI_ALIQIRPJ := Value;
end;

procedure TConfiguracao.SetCONFAI_ALIQPIS(const Value: Double);
begin
  FCONFAI_ALIQPIS := Value;
end;

procedure TConfiguracao.SetCONFAI_EMPRESA(const Value: String);
begin
  FCONFAI_EMPRESA := Value;
end;

procedure TConfiguracao.SetCONFAI_PRESCSLL(const Value: Double);
begin
  FCONFAI_PRESCSLL := Value;
end;

procedure TConfiguracao.SetCONFAI_PRESIRPJ(const Value: Double);
begin
  FCONFAI_PRESIRPJ := Value;
end;

procedure TConfiguracao.SetCONFAI_TIPOSNF(const Value: String);
begin
  FCONFAI_TIPOSNF := Value;
end;

end.
