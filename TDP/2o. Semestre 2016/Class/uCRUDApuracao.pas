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
                                                     ' para imposto ' + FAIMES_IMPOSTO + ', gravado com sucesso',
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

end.
