unit uCRUDApuracao;

interface

uses
   FireDAC.Comp.Client, SysUtils, Vcl.Forms, Windows, Vcl.Controls, Data.DB,
   System.Classes, Vcl.CheckLst, UFuncoesFaciliteXE8, uConstantes;

type
   TCRUDApuracaoMensal = class(TObject)
      private
         FConexao : TFDConnection;
         vloFuncoes : TFuncoesGerais;
         FClasseExcept: String;
         FAIMES_EMPRESA: String;
         FAIMES_RECEITAALTERADA: Double;
         FMensagemExcept: String;
         FAIMES_IMPOSTO: String;
         FAIMES_VALORIMPOSTO: Double;
         FAIMES_RECEITABRUTA: Double;
         FAIMES_MES: String;
         FAIMES_ANO: String;
         FAIMES_ALIQUOTAIMPOSTO: Double;
         procedure SetAIMES_ALIQUOTAIMPOSTO(const Value: Double);
         procedure SetAIMES_ANO(const Value: String);
         procedure SetAIMES_EMPRESA(const Value: String);
         procedure SetAIMES_IMPOSTO(const Value: String);
         procedure SetAIMES_MES(const Value: String);
         procedure SetAIMES_RECEITAALTERADA(const Value: Double);
         procedure SetAIMES_RECEITABRUTA(const Value: Double);
         procedure SetAIMES_VALORIMPOSTO(const Value: Double);
         procedure SetClasseExcept(const Value: String);
         procedure SetMensagemExcept(const Value: String);
      public
         Constructor Create(poConexao : TFDConnection);
         Destructor Destroy; override;
         function fncGravarApuracaoMensal: Boolean;
         function fncExcluiApuracaoMensal: Boolean;

      protected

      published
         property AIMES_EMPRESA         : String read FAIMES_EMPRESA write SetAIMES_EMPRESA;
         property AIMES_IMPOSTO         : String read FAIMES_IMPOSTO write SetAIMES_IMPOSTO;
         property AIMES_MES             : String read FAIMES_MES write SetAIMES_MES;
         property AIMES_ANO             : String read FAIMES_ANO write SetAIMES_ANO;
         property AIMES_RECEITABRUTA    : Double read FAIMES_RECEITABRUTA write SetAIMES_RECEITABRUTA;
         property AIMES_RECEITAALTERADA : Double read FAIMES_RECEITAALTERADA write SetAIMES_RECEITAALTERADA;
         property AIMES_ALIQUOTAIMPOSTO : Double read FAIMES_ALIQUOTAIMPOSTO write SetAIMES_ALIQUOTAIMPOSTO;
         property AIMES_VALORIMPOSTO    : Double read FAIMES_VALORIMPOSTO write SetAIMES_VALORIMPOSTO;
         property MensagemExcept        : String read FMensagemExcept write SetMensagemExcept;
         property ClasseExcept          : String read FClasseExcept write SetClasseExcept;

   end;

type
   TCRUDApuracaoTrimestral = class(TObject)
      private
         FConexao : TFDConnection;
         vloFuncoes : TFuncoesGerais;
    FClasseExcept: String;
    FMensagemExcept: String;
    FAITRIMES_IMPOSTO: String;
    FAITRIMES_VALORIMPOSTO: Double;
    FAITRIMES_TRIMESTRE: Integer;
    FAITRIMES_RETENCAOIMPOSTO: Double;
    FAITRIMES_RECEITABRUTA: Double;
    FAITRIMES_RECEITAFINANC: Double;
    FAITRIMES_ALIQIMPOSTO: Double;
    FAITRIMES_ADICIONALIRPJ: Double;
    FAITRIMES_ANO: String;
    FAITRIMES_PRESIMPOSTO: Double;
    FAITRIMES_EMPRESA: String;
    FAITRIMES_RECEITAALTERADA: Double;
    procedure SetClasseExcept(const Value: String);
    procedure SetMensagemExcept(const Value: String);
    procedure SetAITRIMES_ADICIONALIRPJ(const Value: Double);
    procedure SetAITRIMES_ALIQIMPOSTO(const Value: Double);
    procedure SetAITRIMES_ANO(const Value: String);
    procedure SetAITRIMES_EMPRESA(const Value: String);
    procedure SetAITRIMES_IMPOSTO(const Value: String);
    procedure SetAITRIMES_PRESIMPOSTO(const Value: Double);
    procedure SetAITRIMES_RECEITAALTERADA(const Value: Double);
    procedure SetAITRIMES_RECEITABRUTA(const Value: Double);
    procedure SetAITRIMES_RECEITAFINANC(const Value: Double);
    procedure SetAITRIMES_RETENCAOIMPOSTO(const Value: Double);
    procedure SetAITRIMES_TRIMESTRE(const Value: Integer);
    procedure SetAITRIMES_VALORIMPOSTO(const Value: Double);
      public
         Constructor Create(poConexao : TFDConnection);
         Destructor Destroy; override;
         function fncGravarApuracaoTrimestral: Boolean;
         function fncExcluiApuracaoTrimestral: Boolean;

      protected

      published
         property AITRIMES_EMPRESA          : String read FAITRIMES_EMPRESA write SetAITRIMES_EMPRESA;
         property AITRIMES_IMPOSTO          : String read FAITRIMES_IMPOSTO write SetAITRIMES_IMPOSTO;
         property AITRIMES_TRIMESTRE        : Integer read FAITRIMES_TRIMESTRE write SetAITRIMES_TRIMESTRE;
         property AITRIMES_ANO              : String read FAITRIMES_ANO write SetAITRIMES_ANO;
         property AITRIMES_RECEITABRUTA     : Double read FAITRIMES_RECEITABRUTA write SetAITRIMES_RECEITABRUTA;
         property AITRIMES_RECEITAALTERADA  : Double read FAITRIMES_RECEITAALTERADA write SetAITRIMES_RECEITAALTERADA;
         property AITRIMES_ALIQIMPOSTO      : Double read FAITRIMES_ALIQIMPOSTO write SetAITRIMES_ALIQIMPOSTO;
         property AITRIMES_PRESIMPOSTO      : Double read FAITRIMES_PRESIMPOSTO write SetAITRIMES_PRESIMPOSTO;
         property AITRIMES_RECEITAFINANC    : Double read FAITRIMES_RECEITAFINANC write SetAITRIMES_RECEITAFINANC;
         property AITRIMES_RETENCAOIMPOSTO  : Double read FAITRIMES_RETENCAOIMPOSTO write SetAITRIMES_RETENCAOIMPOSTO;
         property AITRIMES_ADICIONALIRPJ    : Double read FAITRIMES_ADICIONALIRPJ write SetAITRIMES_ADICIONALIRPJ;
         property AITRIMES_VALORIMPOSTO     : Double read FAITRIMES_VALORIMPOSTO write SetAITRIMES_VALORIMPOSTO;
         property MensagemExcept           :String read FMensagemExcept write SetMensagemExcept;
         property ClasseExcept             :String read FClasseExcept write SetClasseExcept;

   end;

implementation

{ TCRUDApuracaoMensal }

constructor TCRUDApuracaoMensal.Create(poConexao: TFDConnection);
begin
inherited Create;

FConexao   := poConexao;
vloFuncoes := TFuncoesGerais.Create(FConexao);
end;

destructor TCRUDApuracaoMensal.Destroy;
begin
if Assigned(vloFuncoes) then
   FreeAndNil(vloFuncoes);

  inherited;
end;

function TCRUDApuracaoMensal.fncExcluiApuracaoMensal: Boolean;
var
   FDApuracao : TFDQuery;
begin
vloFuncoes.pcdCriaFDQueryExecucao(FDApuracao, FConexao);
try
FDApuracao.SQL.Clear;
FDApuracao.SQL.Add('DELETE FROM APURAIMPOSTOMENSAL WHERE AIMES_EMPRESA = :EMPRESA AND AIMES_IMPOSTO = :IMPOSTO AND '+
                   '                                     AIMES_MES = :MES AND AIMES_ANO= :ANO');
FDApuracao.ParamByName('EMPRESA').AsString := FAIMES_EMPRESA;
FDApuracao.ParamByName('IMPOSTO').AsString := FAIMES_IMPOSTO;
FDApuracao.ParamByName('MES').AsString     := FAIMES_MES;
FDApuracao.ParamByName('ANO').AsString     := FAIMES_ANO;
FDApuracao.Open;

if FDApuracao.RowsAffected > 0 then
   begin
   vloFuncoes.fncLogOperacao(FAIMES_EMPRESA, '', '', 'Apuração do período: ' + FAIMES_MES + ' - ' + FAIMES_ANO +
                                                     ' para imposto ' + FAIMES_IMPOSTO + ', excluida com sucesso',
                                                     '',
                                                     OrigemLOG_ApuraImposta);
   end;

finally
   FreeAndNil(FDApuracao);
   end;
end;

function TCRUDApuracaoMensal.fncGravarApuracaoMensal: Boolean;
var
   FDApuracao : TFDQuery;
begin
Result := True;
vloFuncoes.pcdCriaFDQueryExecucao(FDApuracao, FConexao);
try
FDApuracao.SQL.Clear;
FDApuracao.SQL.Add('SELECT * FROM APURAIMPOSTOMENSAL WHERE AIMES_EMPRESA = :EMPRESA AND AIMES_IMPOSTO = :IMPOSTO AND '+
                   '                                       AIMES_MES = :MES AND AIMES_ANO= :ANO');
FDApuracao.ParamByName('EMPRESA').AsString := FAIMES_EMPRESA;
FDApuracao.ParamByName('IMPOSTO').AsString := FAIMES_IMPOSTO;
FDApuracao.ParamByName('MES').AsString     := FAIMES_MES;
FDApuracao.ParamByName('ANO').AsString     := FAIMES_ANO;
FDApuracao.Open;

if FDApuracao.IsEmpty then
   begin
   FDApuracao.SQL.Clear;
   FDApuracao.SQL.Add('INSERT INTO APURAIMPOSTOMENSAL (AIMES_EMPRESA, AIMES_IMPOSTO, AIMES_MES, AIMES_ANO,');
   FDApuracao.SQL.Add('                                AIMES_RECEITABRUTA, AIMES_RECEITAALTERADA, AIMES_ALIQUOTAIMPOSTO,');
   FDApuracao.SQL.Add('                                AIMES_VALORIMPOSTO)');
   FDApuracao.SQL.Add('VALUES (:AIMES_EMPRESA, :AIMES_IMPOSTO, :AIMES_MES, :AIMES_ANO,');
   FDApuracao.SQL.Add('        :AIMES_RECEITABRUTA, :AIMES_RECEITAALTERADA, :AIMES_ALIQUOTAIMPOSTO,');
   FDApuracao.SQL.Add('        :AIMES_VALORIMPOSTO)');
   FDApuracao.ParamByName('AIMES_EMPRESA').AsString        := FAIMES_EMPRESA;
   FDApuracao.ParamByName('AIMES_IMPOSTO').AsString        := FAIMES_IMPOSTO;
   FDApuracao.ParamByName('AIMES_MES').AsString            := FAIMES_MES;
   FDApuracao.ParamByName('AIMES_ANO').AsString            := FAIMES_ANO;
   FDApuracao.ParamByName('AIMES_RECEITABRUTA').AsFloat    := FAIMES_RECEITABRUTA;
   FDApuracao.ParamByName('AIMES_RECEITAALTERADA').AsFloat := FAIMES_RECEITAALTERADA;
   FDApuracao.ParamByName('AIMES_ALIQUOTAIMPOSTO').AsFloat := FAIMES_ALIQUOTAIMPOSTO;
   FDApuracao.ParamByName('AIMES_VALORIMPOSTO').AsFloat    := FAIMES_VALORIMPOSTO;

   try
   FDApuracao.ExecSQL;
   except
      on E:Exception do
         begin
         Result          := False;
         FMensagemExcept := e.Message;
         FClasseExcept   := e.ClassName;
         end;
      end;

   vloFuncoes.fncLogOperacao(FAIMES_EMPRESA, '', '', 'Apuração do período: ' + FAIMES_MES + ' - ' + FAIMES_ANO +
                                                     ' para imposto ' + FAIMES_IMPOSTO + ', gravado com sucesso',
                                                     '',
                                                     OrigemLOG_ApuraImposta);
   end
else
   begin
   FDApuracao.SQL.Clear;
   FDApuracao.SQL.Add('UPDATE APURAIMPOSTOMENSAL');
   FDApuracao.SQL.Add('SET AIMES_RECEITABRUTA = :AIMES_RECEITABRUTA,');
   FDApuracao.SQL.Add('    AIMES_RECEITAALTERADA = :AIMES_RECEITAALTERADA,');
   FDApuracao.SQL.Add('    AIMES_ALIQUOTAIMPOSTO = :AIMES_ALIQUOTAIMPOSTO,');
   FDApuracao.SQL.Add('    AIMES_VALORIMPOSTO = :AIMES_VALORIMPOSTO');
   FDApuracao.SQL.Add('WHERE (AIMES_EMPRESA = :AIMES_EMPRESA) AND (AIMES_IMPOSTO = :AIMES_IMPOSTO) AND');
   FDApuracao.SQL.Add('      (AIMES_MES = :AIMES_MES) AND (AIMES_ANO = :AIMES_ANO)');
   FDApuracao.ParamByName('AIMES_EMPRESA').AsString        := FAIMES_EMPRESA;
   FDApuracao.ParamByName('AIMES_IMPOSTO').AsString        := FAIMES_IMPOSTO;
   FDApuracao.ParamByName('AIMES_MES').AsString            := FAIMES_MES;
   FDApuracao.ParamByName('AIMES_ANO').AsString            := FAIMES_ANO;
   FDApuracao.ParamByName('AIMES_RECEITABRUTA').AsFloat    := FAIMES_RECEITABRUTA;
   FDApuracao.ParamByName('AIMES_RECEITAALTERADA').AsFloat := FAIMES_RECEITAALTERADA;
   FDApuracao.ParamByName('AIMES_ALIQUOTAIMPOSTO').AsFloat := FAIMES_ALIQUOTAIMPOSTO;
   FDApuracao.ParamByName('AIMES_VALORIMPOSTO').AsFloat    := FAIMES_VALORIMPOSTO;

   try
   FDApuracao.ExecSQL;
   except
      on E:Exception do
         begin
         Result          := False;
         FMensagemExcept := e.Message;
         FClasseExcept   := e.ClassName;
         end;
      end;

   vloFuncoes.fncLogOperacao(FAIMES_EMPRESA, '', '', 'Apuração do período: ' + FAIMES_MES + ' - ' + FAIMES_ANO +
                                                     ' para imposto ' + FAIMES_IMPOSTO + ', alterada com sucesso',
                                                     '',
                                                     OrigemLOG_ApuraImposta);
   end;

finally
   FreeAndNil(FDApuracao);
   end;
end;

procedure TCRUDApuracaoMensal.SetAIMES_ALIQUOTAIMPOSTO(const Value: Double);
begin
  FAIMES_ALIQUOTAIMPOSTO := Value;
end;

procedure TCRUDApuracaoMensal.SetAIMES_ANO(const Value: String);
begin
  FAIMES_ANO := Value;
end;

procedure TCRUDApuracaoMensal.SetAIMES_EMPRESA(const Value: String);
begin
  FAIMES_EMPRESA := Value;
end;

procedure TCRUDApuracaoMensal.SetAIMES_IMPOSTO(const Value: String);
begin
  FAIMES_IMPOSTO := Value;
end;

procedure TCRUDApuracaoMensal.SetAIMES_MES(const Value: String);
begin
  FAIMES_MES := Value;
end;

procedure TCRUDApuracaoMensal.SetAIMES_RECEITAALTERADA(const Value: Double);
begin
  FAIMES_RECEITAALTERADA := Value;
end;

procedure TCRUDApuracaoMensal.SetAIMES_RECEITABRUTA(const Value: Double);
begin
  FAIMES_RECEITABRUTA := Value;
end;

procedure TCRUDApuracaoMensal.SetAIMES_VALORIMPOSTO(const Value: Double);
begin
  FAIMES_VALORIMPOSTO := Value;
end;

procedure TCRUDApuracaoMensal.SetClasseExcept(const Value: String);
begin
  FClasseExcept := Value;
end;

procedure TCRUDApuracaoMensal.SetMensagemExcept(const Value: String);
begin
  FMensagemExcept := Value;
end;

{ TCRUDApuracaoTrimestral }

constructor TCRUDApuracaoTrimestral.Create(poConexao: TFDConnection);
begin
inherited Create;

FConexao   := poConexao;
vloFuncoes := TFuncoesGerais.Create(FConexao);
end;

destructor TCRUDApuracaoTrimestral.Destroy;
begin
if Assigned(vloFuncoes) then
   FreeAndNil(vloFuncoes);

  inherited;
end;

function TCRUDApuracaoTrimestral.fncExcluiApuracaoTrimestral: Boolean;
var
   FDApuracao : TFDQuery;
begin
vloFuncoes.pcdCriaFDQueryExecucao(FDApuracao, FConexao);
try
FDApuracao.SQL.Clear;
FDApuracao.SQL.Add('DELETE FROM APURAIMPOSTOTRIMESTRAL WHERE AITRIMES_EMPRESA = :EMPRESA AND '+
                   '                                         AITRIMES_TRIMESTRE = :TRIMESTRE AND '+
                   '                                         AITRIMES_ANO= :ANO AND '+
                   '                                         AITRIMES_IMPOSTO = :IMPOSTO');
FDApuracao.ParamByName('EMPRESA').AsString    := FAITRIMES_EMPRESA;
FDApuracao.ParamByName('TRIMESTRE').AsInteger := FAITRIMES_TRIMESTRE;
FDApuracao.ParamByName('ANO').AsString        := FAITRIMES_ANO;
FDApuracao.ParamByName('IMPOSTO').AsString    := FAITRIMES_IMPOSTO;
FDApuracao.Open;

if FDApuracao.RowsAffected > 0 then
   begin
   vloFuncoes.fncLogOperacao(FAITRIMES_EMPRESA, '', '', 'Apuração do trimestre: ' + IntToStr(FAITRIMES_TRIMESTRE) + ' - ' + FAITRIMES_ANO +
                                                        ' para imposto ' + FAITRIMES_IMPOSTO + ', exclída com sucesso',
                                                        '',
                                                        OrigemLOG_ApuraImposta);
   end;

finally
   FreeAndNil(FDApuracao);
   end;
end;

function TCRUDApuracaoTrimestral.fncGravarApuracaoTrimestral: Boolean;
var
   FDApuracao : TFDQuery;
begin
Result := True;
vloFuncoes.pcdCriaFDQueryExecucao(FDApuracao, FConexao);
try
FDApuracao.SQL.Clear;
FDApuracao.SQL.Add('SELECT * FROM APURAIMPOSTOTRIMESTRAL WHERE AITRIMES_EMPRESA = :EMPRESA AND '+
                   '                                           AITRIMES_TRIMESTRE = :TRIMESTRE AND '+
                   '                                           AITRIMES_ANO= :ANO AND '+
                   '                                           AITRIMES_IMPOSTO = :IMPOSTO');
FDApuracao.ParamByName('EMPRESA').AsString    := FAITRIMES_EMPRESA;
FDApuracao.ParamByName('TRIMESTRE').AsInteger := FAITRIMES_TRIMESTRE;
FDApuracao.ParamByName('ANO').AsString        := FAITRIMES_ANO;
FDApuracao.ParamByName('IMPOSTO').AsString    := FAITRIMES_IMPOSTO;
FDApuracao.Open;

if FDApuracao.IsEmpty then
   begin
   FDApuracao.SQL.Clear;
   FDApuracao.SQL.Add('INSERT INTO APURAIMPOSTOTRIMESTRAL (AITRIMES_EMPRESA, AITRIMES_IMPOSTO, AITRIMES_TRIMESTRE, AITRIMES_ANO,');
   FDApuracao.SQL.Add('                                    AITRIMES_RECEITABRUTA, AITRIMES_RECEITAALTERADA, AITRIMES_ALIQIMPOSTO,');
   FDApuracao.SQL.Add('                                    AITRIMES_PRESIMPOSTO, AITRIMES_RECEITAFINANC, AITRIMES_RETENCAOIMPOSTO,');
   FDApuracao.SQL.Add('                                    AITRIMES_ADICIONALIRPJ, AITRIMES_VALORIMPOSTO)');
   FDApuracao.SQL.Add('VALUES (:AITRIMES_EMPRESA, :AITRIMES_IMPOSTO, :AITRIMES_TRIMESTRE, :AITRIMES_ANO,');
   FDApuracao.SQL.Add('                                    :AITRIMES_RECEITABRUTA, :AITRIMES_RECEITAALTERADA, :AITRIMES_ALIQIMPOSTO,');
   FDApuracao.SQL.Add('                                    :AITRIMES_PRESIMPOSTO, :AITRIMES_RECEITAFINANC, :AITRIMES_RETENCAOIMPOSTO,');
   FDApuracao.SQL.Add('                                    :AITRIMES_ADICIONALIRPJ, :AITRIMES_VALORIMPOSTO); ');
   FDApuracao.ParamByName('AITRIMES_EMPRESA').AsString        := FAITRIMES_EMPRESA;
   FDApuracao.ParamByName('AITRIMES_IMPOSTO').AsString        := FAITRIMES_IMPOSTO;
   FDApuracao.ParamByName('AITRIMES_TRIMESTRE').AsInteger     := FAITRIMES_TRIMESTRE;
   FDApuracao.ParamByName('AITRIMES_ANO').AsString            := FAITRIMES_ANO;
   FDApuracao.ParamByName('AITRIMES_RECEITABRUTA').AsFloat    := FAITRIMES_RECEITABRUTA;
   FDApuracao.ParamByName('AITRIMES_RECEITAALTERADA').AsFloat := FAITRIMES_RECEITAALTERADA;
   FDApuracao.ParamByName('AITRIMES_ALIQIMPOSTO').AsFloat     := FAITRIMES_ALIQIMPOSTO;
   FDApuracao.ParamByName('AITRIMES_PRESIMPOSTO').AsFloat     := FAITRIMES_PRESIMPOSTO;
   FDApuracao.ParamByName('AITRIMES_RECEITAFINANC').AsFloat   := FAITRIMES_RECEITAFINANC;
   FDApuracao.ParamByName('AITRIMES_RETENCAOIMPOSTO').AsFloat := FAITRIMES_RETENCAOIMPOSTO;
   FDApuracao.ParamByName('AITRIMES_ADICIONALIRPJ').AsFloat   := FAITRIMES_ADICIONALIRPJ;
   FDApuracao.ParamByName('AITRIMES_VALORIMPOSTO').AsFloat    := FAITRIMES_VALORIMPOSTO;

   try
   FDApuracao.ExecSQL;
   except
      on E:Exception do
         begin
         Result          := False;
         FMensagemExcept := e.Message;
         FClasseExcept   := e.ClassName;
         end;
      end;

   vloFuncoes.fncLogOperacao(FAITRIMES_EMPRESA, '', '', 'Apuração do trimestre: ' + IntToStr(FAITRIMES_TRIMESTRE) + ' - ' + FAITRIMES_ANO +
                                                     ' para imposto ' + FAITRIMES_IMPOSTO + ', gravado com sucesso',
                                                     '',
                                                     OrigemLOG_ApuraImposta);
   end
else
   begin
   FDApuracao.SQL.Clear;
   FDApuracao.SQL.Add('UPDATE APURAIMPOSTOTRIMESTRAL');
   FDApuracao.SQL.Add('SET AITRIMES_RECEITABRUTA = :AITRIMES_RECEITABRUTA,');
   FDApuracao.SQL.Add('    AITRIMES_RECEITAALTERADA = :AITRIMES_RECEITAALTERADA,');
   FDApuracao.SQL.Add('    AITRIMES_ALIQIMPOSTO = :AITRIMES_ALIQIMPOSTO,');
   FDApuracao.SQL.Add('    AITRIMES_PRESIMPOSTO = :AITRIMES_PRESIMPOSTO,');
   FDApuracao.SQL.Add('    AITRIMES_RECEITAFINANC = :AITRIMES_RECEITAFINANC,');
   FDApuracao.SQL.Add('    AITRIMES_RETENCAOIMPOSTO = :AITRIMES_RETENCAOIMPOSTO,');
   FDApuracao.SQL.Add('    AITRIMES_ADICIONALIRPJ = :AITRIMES_ADICIONALIRPJ,');
   FDApuracao.SQL.Add('    AITRIMES_VALORIMPOSTO = :AITRIMES_VALORIMPOSTO');
   FDApuracao.SQL.Add('WHERE (AITRIMES_EMPRESA = :AITRIMES_EMPRESA) AND (AITRIMES_IMPOSTO = :AITRIMES_IMPOSTO) AND');
   FDApuracao.SQL.Add('      (AITRIMES_TRIMESTRE = :AITRIMES_TRIMESTRE) AND (AITRIMES_ANO = :AITRIMES_ANO);');
   FDApuracao.ParamByName('AITRIMES_EMPRESA').AsString        := FAITRIMES_EMPRESA;
   FDApuracao.ParamByName('AITRIMES_IMPOSTO').AsString        := FAITRIMES_IMPOSTO;
   FDApuracao.ParamByName('AITRIMES_TRIMESTRE').AsInteger     := FAITRIMES_TRIMESTRE;
   FDApuracao.ParamByName('AITRIMES_ANO').AsString            := FAITRIMES_ANO;
   FDApuracao.ParamByName('AITRIMES_RECEITABRUTA').AsFloat    := FAITRIMES_RECEITABRUTA;
   FDApuracao.ParamByName('AITRIMES_RECEITAALTERADA').AsFloat := FAITRIMES_RECEITAALTERADA;
   FDApuracao.ParamByName('AITRIMES_ALIQIMPOSTO').AsFloat     := FAITRIMES_ALIQIMPOSTO;
   FDApuracao.ParamByName('AITRIMES_PRESIMPOSTO').AsFloat     := FAITRIMES_PRESIMPOSTO;
   FDApuracao.ParamByName('AITRIMES_RECEITAFINANC').AsFloat   := FAITRIMES_RECEITAFINANC;
   FDApuracao.ParamByName('AITRIMES_RETENCAOIMPOSTO').AsFloat := FAITRIMES_RETENCAOIMPOSTO;
   FDApuracao.ParamByName('AITRIMES_ADICIONALIRPJ').AsFloat   := FAITRIMES_ADICIONALIRPJ;
   FDApuracao.ParamByName('AITRIMES_VALORIMPOSTO').AsFloat    := FAITRIMES_VALORIMPOSTO;
   try
   FDApuracao.ExecSQL;
   except
      on E:Exception do
         begin
         Result          := False;
         FMensagemExcept := e.Message;
         FClasseExcept   := e.ClassName;
         end;
      end;

   vloFuncoes.fncLogOperacao(FAITRIMES_EMPRESA, '', '', 'Apuração do trimestre: ' + IntToStr(FAITRIMES_TRIMESTRE) + ' - ' + FAITRIMES_ANO +
                                                     ' para imposto ' + FAITRIMES_IMPOSTO + ', alterada com sucesso',
                                                     '',
                                                     OrigemLOG_ApuraImposta);
   end;

finally
   FreeAndNil(FDApuracao);
   end;
end;

procedure TCRUDApuracaoTrimestral.SetAITRIMES_ADICIONALIRPJ(
  const Value: Double);
begin
  FAITRIMES_ADICIONALIRPJ := Value;
end;

procedure TCRUDApuracaoTrimestral.SetAITRIMES_ALIQIMPOSTO(const Value: Double);
begin
  FAITRIMES_ALIQIMPOSTO := Value;
end;

procedure TCRUDApuracaoTrimestral.SetAITRIMES_ANO(const Value: String);
begin
  FAITRIMES_ANO := Value;
end;

procedure TCRUDApuracaoTrimestral.SetAITRIMES_EMPRESA(const Value: String);
begin
  FAITRIMES_EMPRESA := Value;
end;

procedure TCRUDApuracaoTrimestral.SetAITRIMES_IMPOSTO(const Value: String);
begin
  FAITRIMES_IMPOSTO := Value;
end;

procedure TCRUDApuracaoTrimestral.SetAITRIMES_PRESIMPOSTO(const Value: Double);
begin
  FAITRIMES_PRESIMPOSTO := Value;
end;

procedure TCRUDApuracaoTrimestral.SetAITRIMES_RECEITAALTERADA(
  const Value: Double);
begin
  FAITRIMES_RECEITAALTERADA := Value;
end;

procedure TCRUDApuracaoTrimestral.SetAITRIMES_RECEITABRUTA(const Value: Double);
begin
  FAITRIMES_RECEITABRUTA := Value;
end;

procedure TCRUDApuracaoTrimestral.SetAITRIMES_RECEITAFINANC(
  const Value: Double);
begin
  FAITRIMES_RECEITAFINANC := Value;
end;

procedure TCRUDApuracaoTrimestral.SetAITRIMES_RETENCAOIMPOSTO(
  const Value: Double);
begin
  FAITRIMES_RETENCAOIMPOSTO := Value;
end;

procedure TCRUDApuracaoTrimestral.SetAITRIMES_TRIMESTRE(const Value: Integer);
begin
  FAITRIMES_TRIMESTRE := Value;
end;

procedure TCRUDApuracaoTrimestral.SetAITRIMES_VALORIMPOSTO(const Value: Double);
begin
  FAITRIMES_VALORIMPOSTO := Value;
end;

procedure TCRUDApuracaoTrimestral.SetClasseExcept(const Value: String);
begin
  FClasseExcept := Value;
end;

procedure TCRUDApuracaoTrimestral.SetMensagemExcept(const Value: String);
begin
  FMensagemExcept := Value;
end;

end.
