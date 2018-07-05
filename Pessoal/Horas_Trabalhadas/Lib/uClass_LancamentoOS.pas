{$M+}
unit uClass_LancamentoOS;

interface

uses
   FireDAC.Comp.Client, System.SysUtils;

type
  TClass_LancamentoOS = class(TObject)
  private
    FConexao : TFDConnection;
    FQLancamentoOS : TFDQuery;
    FHoraFinal: TTime;
    FHoraInicial: TTime;
    FHoraPerdida: TTime;
    FSprint: String;
    FCliente: String;
    FNumeroOS: String;
    FDataTrabalhada: TDate;
    FHoraProposta: TTime;
    FHoraDisponivel: TTime;
    FDataFinal: TDate;
    FDataInicial: TDate;
    procedure SetCliente(const Value: String);
    procedure SetDataFinal(const Value: TDate);
    procedure SetDataInicial(const Value: TDate);
    procedure SetDataTrabalhada(const Value: TDate);
    procedure SetHoraDisponivel(const Value: TTime);
    procedure SetHoraFinal(const Value: TTime);
    procedure SetHoraInicial(const Value: TTime);
    procedure SetHoraPerdida(const Value: TTime);
    procedure SetHoraProposta(const Value: TTime);
    procedure SetNumeroOS(const Value: String);
    procedure SetSprint(const Value: String);
  public
    constructor Create(poConexao: TFDConnection);
    destructor Destroy; override;
    function fncGravarDados : Boolean;
    function fncExcluirDados : Boolean;
  published
    property NumeroOS       : String read FNumeroOS write SetNumeroOS;
    property Sprint         : String read FSprint write SetSprint;
    property Cliente        : String read FCliente write SetCliente;
    property DataInicial    : TDate read FDataInicial write SetDataInicial;
    property HoraInicial    : TTime read FHoraInicial write SetHoraInicial;
    property DataFinal      : TDate read FDataFinal write SetDataFinal;
    property HoraFinal      : TTime read FHoraFinal write SetHoraFinal;
    property HoraProposta   : TTime read FHoraProposta write SetHoraProposta;
    property DataTrabalhada : TDate read FDataTrabalhada write SetDataTrabalhada;
    property HoraDisponivel : TTime read FHoraDisponivel write SetHoraDisponivel;
    property HoraPerdida    : TTime read FHoraPerdida write SetHoraPerdida;
   end;

implementation

{ TClass_LancamentoOS }

constructor TClass_LancamentoOS.Create(poConexao: TFDConnection);
begin
FHoraFinal      := 0;
FHoraInicial    := 0;
FHoraPerdida    := 0;
FSprint         := '';
FCliente        := '';
FNumeroOS       := '';
FDataTrabalhada := 0;
FHoraProposta   := 0;
FHoraDisponivel := 0;
FDataFinal      := 0;
FDataInicial    := 0;

FConexao := poConexao;
FQLancamentoOS.Close;
FQLancamentoOS.Connection := FConexao;

end;

destructor TClass_LancamentoOS.Destroy;
begin

  inherited;
end;

function TClass_LancamentoOS.fncExcluirDados: Boolean;
begin
Result := True;
FQLancamentoOS.Close;
FQLancamentoOS.SQL.Clear;
FQLancamentoOS.SQL.Add('DELETE FROM LANCAMENTOOS WHERE NUMEROOS = :OS AND SPRINT = :SPRINT');
FQLancamentoOS.ParamByName('OS').AsString     := FNumeroOS;
FQLancamentoOS.ParamByName('SPRINT').AsString := FSprint;

try
   FQLancamentoOS.ExecSQL
except
   on E:Exception do
      begin
      Result := False;
      raise  Exception.Create('Houve um erro ao excluir o registro: '+FNumeroOS+' com a mensagem: '+e.Message);
      end;
   end;
end;

function TClass_LancamentoOS.fncGravarDados: Boolean;
begin
Result := True;
FQLancamentoOS.Close;
FQLancamentoOS.SQL.Clear;
FQLancamentoOS.SQL.Add('SELECT NUMEROOS FROM LANCAMENTOOS WHERE NUMEROOS = :OS AND SPRINT = :SPRINT');
FQLancamentoOS.ParamByName('OS').AsString     := FNumeroOS;
FQLancamentoOS.ParamByName('SPRINT').AsString := FSprint;
FQLancamentoOS.Open();

if not FQLancamentoOS.IsEmpty then
   begin
   FQLancamentoOS.Close;
   FQLancamentoOS.SQL.Clear;                //parei
   FQLancamentoOS.SQL.Add('INSERT INTO LANCAMENTOOS ()');
   FQLancamentoOS.ParamByName('OS').AsString     := FNumeroOS;
   FQLancamentoOS.ParamByName('SPRINT').AsString := FSprint;
   FQLancamentoOS.Open();


   try
      FQLancamentoOS.ExecSQL
   except
      on E:Exception do
         begin
         Result := False;
         raise  Exception.Create('Houve um erro ao excluir o registro: '+FNumeroOS+' com a mensagem: '+e.Message);
         end;
      end;
   end;



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

procedure TClass_LancamentoOS.SetHoraDisponivel(const Value: TTime);
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

procedure TClass_LancamentoOS.SetHoraPerdida(const Value: TTime);
begin
  FHoraPerdida := Value;
end;

procedure TClass_LancamentoOS.SetHoraProposta(const Value: TTime);
begin
  FHoraProposta := Value;
end;

procedure TClass_LancamentoOS.SetNumeroOS(const Value: String);
begin
  FNumeroOS := Value;
end;

procedure TClass_LancamentoOS.SetSprint(const Value: String);
begin
  FSprint := Value;
end;

end.
