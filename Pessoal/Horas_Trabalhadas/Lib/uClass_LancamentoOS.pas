{$M+}
unit uClass_LancamentoOS;

interface

uses
   FireDAC.Comp.Client, FireDAC.Stan.Param, System.SysUtils, Data.DB;

type
   TTotalizador = record
     HProposta      : String;
     HTrabalhada    : String;
     HSaldo         : String;
     HSaldoNegativo : Boolean;
   end;

type
  TClass_LancamentoOS = class(TObject)
  private
    FConexao : TFDConnection;
    FQLancamentoOS : TFDQuery;
    FHoraFinal: TTime;
    FHoraInicial: TTime;
    FHoraPerdida: String;
    FSprint: Integer;
    FCliente: String;
    FNumeroOS: String;
    FDataTrabalhada: TDate;
    FHoraProposta: String;
    FHoraDisponivel: String;
    FDataFinal: TDate;
    FDataInicial: TDate;
    FQueryLancamento_Diario: TFDQuery;
    FHoraTrabalhada: String;
    function fncCopiaAte(psTexto, psCaracter: String): string;
    function fncRetornaSubtracaoHora(psHora01, psHora02: String) : String;
    procedure SetCliente(const Value: String);
    procedure SetDataFinal(const Value: TDate);
    procedure SetDataInicial(const Value: TDate);
    procedure SetDataTrabalhada(const Value: TDate);
    procedure SetHoraDisponivel(const Value: String);
    procedure SetHoraFinal(const Value: TTime);
    procedure SetHoraInicial(const Value: TTime);
    procedure SetHoraPerdida(const Value: String);
    procedure SetHoraProposta(const Value: String);
    procedure SetNumeroOS(const Value: String);
    procedure SetSprint(const Value: Integer);
    procedure SetQueryLancamento_Diario(const Value: TFDQuery);
    function fncRetornaMinuto(psTexto: String): string;
    procedure SetHoraTrabalhada(const Value: String);
  public
    constructor Create(poConexao: TFDConnection);
    destructor Destroy; override;
    procedure pcdGravarDados;
    procedure pcdExcluirDados;
    procedure pcdGravarDados_Diario;
    procedure pcdExcluirDados_Diario;
    procedure EncontraDados;
    function fncTotalizador : TTotalizador;
  published
    property NumeroOS       : String read FNumeroOS write SetNumeroOS;
    property Sprint         : Integer read FSprint write SetSprint;
    property Cliente        : String read FCliente write SetCliente;
    property DataInicial    : TDate read FDataInicial write SetDataInicial;
    property HoraInicial    : TTime read FHoraInicial write SetHoraInicial;
    property DataFinal      : TDate read FDataFinal write SetDataFinal;
    property HoraFinal      : TTime read FHoraFinal write SetHoraFinal;
    property HoraProposta   : String read FHoraProposta write SetHoraProposta;
    property DataTrabalhada : TDate read FDataTrabalhada write SetDataTrabalhada;
    property HoraDisponivel : String read FHoraDisponivel write SetHoraDisponivel;
    property HoraPerdida    : String read FHoraPerdida write SetHoraPerdida;
    property HoraTrabalhada : String read FHoraTrabalhada write SetHoraTrabalhada;
    property QueryLancamento_Diario : TFDQuery read FQueryLancamento_Diario write SetQueryLancamento_Diario;
   end;

implementation

{ TClass_LancamentoOS }

constructor TClass_LancamentoOS.Create(poConexao: TFDConnection);
begin
FHoraFinal      := 0;
FHoraInicial    := 0;
FHoraPerdida    := '';
FSprint         := 0;
FCliente        := '';
FNumeroOS       := '';
FDataTrabalhada := 0;
FHoraProposta   := '';
FHoraDisponivel := '';
FDataFinal      := 0;
FDataInicial    := 0;

FConexao := poConexao;

FQLancamentoOS := TFDQuery.Create(nil);
FQLancamentoOS.Close;
FQLancamentoOS.Connection := FConexao;

end;

destructor TClass_LancamentoOS.Destroy;
begin
if Assigned(FQLancamentoOS) then
   FreeAndNil(FQLancamentoOS);

FConexao.Close;
  inherited;
end;

procedure TClass_LancamentoOS.EncontraDados;
begin
FQLancamentoOS.Close;
FQLancamentoOS.SQL.Clear;
FQLancamentoOS.SQL.Add('SELECT * FROM LANCAMENTOOS WHERE NUMEROOS = :OS AND SPRINT = :SPRINT');
FQLancamentoOS.ParamByName('OS').AsString      := FNumeroOS;
FQLancamentoOS.ParamByName('SPRINT').AsInteger := FSprint;
FQLancamentoOS.Open();

if not FQLancamentoOS.IsEmpty then
   begin
   FCliente      := FQLancamentoOS.FieldByName('Cliente').AsString;
   FDataInicial  := FQLancamentoOS.FieldByName('DataInicial').AsDateTime;
   FHoraInicial  := FQLancamentoOS.FieldByName('HoraInicial').AsDateTime;
   FDataFinal    := FQLancamentoOS.FieldByName('DataFinal').AsDateTime;
   FHoraFinal    := FQLancamentoOS.FieldByName('HoraFinal').AsDateTime;
   FHoraProposta := FQLancamentoOS.FieldByName('HoraProposta').AsString;

   FQueryLancamento_Diario.Close;
   FQueryLancamento_Diario.SQL.Clear;
   FQueryLancamento_Diario.SQL.Add('SELECT * FROM LANCAMENTOOS_DIARIO WHERE NUMEROOS = :OS AND SPRINT = :SPRINT ORDER BY DATATRABALHADA');
   FQueryLancamento_Diario.ParamByName('OS').AsString      := FNumeroOS;
   FQueryLancamento_Diario.ParamByName('SPRINT').AsInteger := FSprint;
   FQueryLancamento_Diario.Open();
   end
else
   begin
   FCliente      := '';
   FDataInicial  := 0;
   FHoraInicial  := 0;
   FDataFinal    := 0;
   FHoraFinal    := 0;
   FHoraProposta := '';
   FQueryLancamento_Diario := nil;
   end;
end;

function TClass_LancamentoOS.fncCopiaAte(psTexto, psCaracter: String): string;
var
   I: Integer;
begin
for I := 1 to Length(psTexto) do
   begin
   if Copy(psTexto, I, 1) <> psCaracter then
      Result := Result + Copy(psTexto, I, 1)
   else
      Break;
   end;
end;

function TClass_LancamentoOS.fncRetornaMinuto(psTexto: String): string;
var
   I: Integer;
   vlbAchouCaracter : Boolean;
begin
vlbAchouCaracter := False;
for I := 1 to Length(psTexto) do
   begin
   if vlbAchouCaracter then
      begin
      Result := Result + Copy(psTexto, I, 1)
      end
   else
      begin
      if Copy(psTexto, I, 1) = ':' then
         vlbAchouCaracter := True;
      end
   end;
end;

procedure TClass_LancamentoOS.pcdExcluirDados;
begin
FQLancamentoOS.Close;
FQLancamentoOS.SQL.Clear;
FQLancamentoOS.SQL.Add('DELETE FROM LANCAMENTOOS WHERE NUMEROOS = :OS AND SPRINT = :SPRINT');
FQLancamentoOS.ParamByName('OS').AsString      := FNumeroOS;
FQLancamentoOS.ParamByName('SPRINT').AsInteger := FSprint;

try
   FQLancamentoOS.ExecSQL;

   try
      FDataTrabalhada := StrToDate('01/01/1900');
      pcdExcluirDados_Diario;
   except
      on E:Exception do
         begin
         raise  Exception.Create(e.Message);
         end;
      end;
except
   on E:Exception do
      begin
      raise  Exception.Create('Houve um erro ao excluir o registro: '+FNumeroOS+' com a mensagem: '+e.Message);
      end;
   end;
end;

procedure TClass_LancamentoOS.pcdExcluirDados_Diario;
begin
FQLancamentoOS.Close;
FQLancamentoOS.SQL.Clear;

if FDataTrabalhada <> StrToDate('01/01/1900') then
   begin
   FQLancamentoOS.SQL.Add('DELETE FROM LANCAMENTOOS_DIARIO WHERE NUMEROOS = :OS AND SPRINT = :SPRINT AND DATATRABALHADA = :DATATRABALHADA');
   FQLancamentoOS.ParamByName('DATATRABALHADA').AsDateTime := FDataTrabalhada;
   end
else
   FQLancamentoOS.SQL.Add('DELETE FROM LANCAMENTOOS_DIARIO WHERE NUMEROOS = :OS AND SPRINT = :SPRINT');

FQLancamentoOS.ParamByName('OS').AsString      := FNumeroOS;
FQLancamentoOS.ParamByName('SPRINT').AsInteger := FSprint;

try
   FQLancamentoOS.ExecSQL
except
   on E:Exception do
      begin
      raise  Exception.Create('Houve um erro ao excluir o registro diário: '+FNumeroOS+' com a mensagem: '+e.Message);
      end;
   end;
end;

procedure TClass_LancamentoOS.pcdGravarDados;
begin
FQLancamentoOS.Close;
FQLancamentoOS.SQL.Clear;
FQLancamentoOS.SQL.Add('SELECT NUMEROOS FROM LANCAMENTOOS WHERE NUMEROOS = :OS AND SPRINT = :SPRINT');
FQLancamentoOS.ParamByName('OS').AsString      := FNumeroOS;
FQLancamentoOS.ParamByName('SPRINT').AsInteger := FSprint;
FQLancamentoOS.Open();

FQLancamentoOS.Refresh;

if FQLancamentoOS.IsEmpty then
   begin
   FQLancamentoOS.Close;
   FQLancamentoOS.SQL.Clear;
   FQLancamentoOS.SQL.Add('INSERT INTO LANCAMENTOOS (NUMEROOS, SPRINT, CLIENTE, DATAINICIAL, HORAINICIAL, DATAFINAL,');
   FQLancamentoOS.SQL.Add('                          HORAFINAL, HORAPROPOSTA)');

   if FDataFinal = 0 then
      begin
      FQLancamentoOS.SQL.Add('VALUES (:NUMEROOS, :SPRINT, :CLIENTE, :DATAINICIAL, :HORAINICIAL, null,');
      FQLancamentoOS.SQL.Add('        null, :HORAPROPOSTA);');
      end
   else
      begin
      FQLancamentoOS.SQL.Add('VALUES (:NUMEROOS, :SPRINT, :CLIENTE, :DATAINICIAL, :HORAINICIAL, :DATAFINAL,');
      FQLancamentoOS.SQL.Add('        :HORAFINAL, :HORAPROPOSTA);');
      end;
   end
else
   begin
   FQLancamentoOS.Close;
   FQLancamentoOS.SQL.Clear;
   FQLancamentoOS.SQL.Add('UPDATE LANCAMENTOOS');
   FQLancamentoOS.SQL.Add('SET CLIENTE = :CLIENTE, DATAINICIAL = :DATAINICIAL,');

   if FDataFinal = 0 then
      begin
      FQLancamentoOS.SQL.Add('    HORAINICIAL = :HORAINICIAL, DATAFINAL = null,');
      FQLancamentoOS.SQL.Add('    HORAFINAL = null, HORAPROPOSTA = :HORAPROPOSTA');
      end
   else
      begin
      FQLancamentoOS.SQL.Add('    HORAINICIAL = :HORAINICIAL, DATAFINAL = :DATAFINAL,');
      FQLancamentoOS.SQL.Add('    HORAFINAL = :HORAFINAL, HORAPROPOSTA = :HORAPROPOSTA');
      end;

   FQLancamentoOS.SQL.Add('WHERE (NUMEROOS = :NUMEROOS) AND (SPRINT = :SPRINT)');
   end;

FQLancamentoOS.ParamByName('NUMEROOS').AsString         := FNumeroOS;
FQLancamentoOS.ParamByName('SPRINT').AsInteger          := FSprint;
FQLancamentoOS.ParamByName('CLIENTE').AsString          := FCliente;
FQLancamentoOS.ParamByName('DATAINICIAL').AsDateTime    := FDataInicial;
FQLancamentoOS.ParamByName('HORAINICIAL').AsTime        := FHoraInicial;
FQLancamentoOS.ParamByName('HORAPROPOSTA').AsString     := FHoraProposta;

if FDataFinal <> 0 then
   begin
   FQLancamentoOS.ParamByName('DATAFINAL').AsDateTime      := FDataFinal;
   FQLancamentoOS.ParamByName('HORAFINAL').AsTime          := FHoraFinal;
   end;

try
   FQLancamentoOS.ExecSQL
except
   on E:Exception do
      begin
      raise  Exception.Create('Houve um erro ao adicionar/editar o registro: '+FNumeroOS+' com a mensagem: '+e.Message);
      end;
   end;
end;

procedure TClass_LancamentoOS.pcdGravarDados_Diario;
begin
FQLancamentoOS.Close;
FQLancamentoOS.SQL.Clear;
FQLancamentoOS.SQL.Add('SELECT NUMEROOS FROM LANCAMENTOOS_DIARIO WHERE NUMEROOS = :OS AND SPRINT = :SPRINT AND DATATRABALHADA = :DATATRABALHADA');
FQLancamentoOS.ParamByName('OS').AsString               := FNumeroOS;
FQLancamentoOS.ParamByName('SPRINT').AsInteger          := FSprint;
FQLancamentoOS.ParamByName('DATATRABALHADA').AsDateTime := FDataTrabalhada;
FQLancamentoOS.Open();

if FQLancamentoOS.IsEmpty then
   begin
   FQLancamentoOS.Close;
   FQLancamentoOS.SQL.Clear;
   FQLancamentoOS.SQL.Add('INSERT INTO LANCAMENTOOS_DIARIO (NUMEROOS, SPRINT, DATATRABALHADA, HORADISPONIVEL, HORAPERDIDA, HORATRABALHADA)');
   FQLancamentoOS.SQL.Add('VALUES (:NUMEROOS, :SPRINT, :DATATRABALHADA, :HORADISPONIVEL, :HORAPERDIDA, :HORATRABALHADA)');
   end
else
   begin
   FQLancamentoOS.Close;
   FQLancamentoOS.SQL.Clear;
   FQLancamentoOS.SQL.Add('UPDATE LANCAMENTOOS_DIARIO');
   FQLancamentoOS.SQL.Add('SET DATATRABALHADA = :DATATRABALHADA,');
   FQLancamentoOS.SQL.Add('    HORADISPONIVEL = :HORADISPONIVEL,');
   FQLancamentoOS.SQL.Add('    HORAPERDIDA = :HORAPERDIDA,');
   FQLancamentoOS.SQL.Add('    HORATRABALHADA = :HORATRABALHADA');
   FQLancamentoOS.SQL.Add('WHERE (NUMEROOS = :NUMEROOS) AND (SPRINT = :SPRINT);');
   end;

FQLancamentoOS.ParamByName('NUMEROOS').AsString         := FNumeroOS;
FQLancamentoOS.ParamByName('SPRINT').AsInteger          := FSprint;
FQLancamentoOS.ParamByName('DATATRABALHADA').AsDateTime := FDataTrabalhada;
FQLancamentoOS.ParamByName('HORADISPONIVEL').AsString   := FHoraDisponivel;
FQLancamentoOS.ParamByName('HORAPERDIDA').AsString      := FHoraPerdida;
FQLancamentoOS.ParamByName('HORATRABALHADA').AsString   := FHoraTrabalhada;

try
   FQLancamentoOS.ExecSQL
except
   on E:Exception do
      begin
      raise  Exception.Create('Houve um erro ao adicionar/editar diários o registro: '+FNumeroOS+' com a mensagem: '+e.Message);
      end;
   end;
end;

function TClass_LancamentoOS.fncRetornaSubtracaoHora(psHora01, psHora02: String): String;
var
   vliHora01, vliMinuto01, vliHora02, vliMinuto02 : Integer;
begin
vliHora01    := StrToInt(fncCopiaAte(psHora01, ':'));
vliMinuto01  := StrToInt(fncRetornaMinuto(psHora01));
vliHora02    := StrToInt(fncCopiaAte(psHora02, ':'));
vliMinuto02  := StrToInt(fncRetornaMinuto(psHora02));

Result       := FormatFloat('00', (vliHora01 - vliHora02)) + ':' + FormatFloat('00', (vliMinuto01 - vliMinuto02));
end;

function TClass_LancamentoOS.fncTotalizador: TTotalizador;
var
   TotalHorasTrabalhadas : TTime;
   HorasPropostas : String;
begin
Result.HProposta      := '';
Result.HTrabalhada    := '';
Result.HSaldo         := '';
Result.HSaldoNegativo := False;
TotalHorasTrabalhadas := 0;
HorasPropostas        := '';

FQLancamentoOS.Close;
FQLancamentoOS.SQL.Clear;
FQLancamentoOS.SQL.Add('SELECT HORAPROPOSTA FROM LANCAMENTOOS WHERE NUMEROOS = :OS AND SPRINT = :SPRINT');
FQLancamentoOS.ParamByName('OS').AsString      := FNumeroOS;
FQLancamentoOS.ParamByName('SPRINT').AsInteger := FSprint;
FQLancamentoOS.Open();

HorasPropostas   := FQLancamentoOS.FieldByName('HORAPROPOSTA').AsString;
Result.HProposta := HorasPropostas;

FQLancamentoOS.Close;
FQLancamentoOS.SQL.Clear;
FQLancamentoOS.SQL.Add('SELECT HORATRABALHADA FROM LANCAMENTOOS_DIARIO WHERE NUMEROOS = :OS AND SPRINT = :SPRINT');
FQLancamentoOS.ParamByName('OS').AsString      := FNumeroOS;
FQLancamentoOS.ParamByName('SPRINT').AsInteger := FSprint;
FQLancamentoOS.Open();
FQLancamentoOS.First;

while not FQLancamentoOS.Eof do
   begin
   TotalHorasTrabalhadas := TotalHorasTrabalhadas + FQLancamentoOS.FieldByName('HORATRABALHADA').AsDateTime;
   FQLancamentoOS.Next;
   end;

Result.HTrabalhada := FormatDateTime('hh:mm', TotalHorasTrabalhadas);

Result.HSaldo         := fncRetornaSubtracaoHora(HoraProposta, FormatDateTime('hh:mm', TotalHorasTrabalhadas));
Result.HSaldoNegativo := (FormatDateTime('hh:mm', TotalHorasTrabalhadas) > HorasPropostas);

end;

procedure TClass_LancamentoOS.SetCliente(const Value: String);
begin
  FCliente := Value;
end;

procedure TClass_LancamentoOS.SetDataFinal(const Value: TDate);
begin
  FDataFinal := Value;
end;

procedure TClass_LancamentoOS.SetDataInicial(const Value: TDate);
begin
  FDataInicial := Value;
end;

procedure TClass_LancamentoOS.SetDataTrabalhada(const Value: TDate);
begin
  FDataTrabalhada := Value;
end;

procedure TClass_LancamentoOS.SetHoraDisponivel(const Value: String);
begin
  FHoraDisponivel := Value;
end;

procedure TClass_LancamentoOS.SetHoraFinal(const Value: TTime);
begin
  FHoraFinal := Value;
end;

procedure TClass_LancamentoOS.SetHoraInicial(const Value: TTime);
begin
  FHoraInicial := Value;
end;

procedure TClass_LancamentoOS.SetHoraPerdida(const Value: String);
begin
  FHoraPerdida := Value;
end;

procedure TClass_LancamentoOS.SetHoraProposta(const Value: String);
begin
  FHoraProposta := Value;
end;

procedure TClass_LancamentoOS.SetHoraTrabalhada(const Value: String);
begin
  FHoraTrabalhada := Value;
end;

procedure TClass_LancamentoOS.SetNumeroOS(const Value: String);
begin
  FNumeroOS := Value;
end;

procedure TClass_LancamentoOS.SetQueryLancamento_Diario(const Value: TFDQuery);
begin
  FQueryLancamento_Diario := Value;
end;

procedure TClass_LancamentoOS.SetSprint(const Value: Integer);
begin
  FSprint := Value;
end;

end.
