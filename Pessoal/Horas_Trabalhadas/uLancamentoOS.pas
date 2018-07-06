unit uLancamentoOS;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls,
  Vcl.Buttons, Data.DB, Vcl.Grids, Vcl.DBGrids, uClass_LancamentoOS;

type
  TFLancamentoOS = class(TForm)
    gbOS: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    edtOS: TMaskEdit;
    edtSprint: TMaskEdit;
    edtCliente: TMaskEdit;
    edtDataInicial: TMaskEdit;
    edtDataFinal: TMaskEdit;
    edtHoraInicial: TMaskEdit;
    edtHoraProposta: TMaskEdit;
    edtHoraFinal: TMaskEdit;
    gbDiario: TGroupBox;
    Label9: TLabel;
    edtDataTrabalhada: TMaskEdit;
    Label10: TLabel;
    edtHoraDisponivel: TMaskEdit;
    Label11: TLabel;
    edtHoraPerdida: TMaskEdit;
    Label12: TLabel;
    pHorasTrabalhadas: TPanel;
    btnGravarOS: TBitBtn;
    btnExcluirOS: TBitBtn;
    btnGravarDadosDiarios: TBitBtn;
    btnExcluirDadosDiarios: TBitBtn;
    dbDiario: TDBGrid;
    gbTotalizador: TGroupBox;
    Label13: TLabel;
    pTotal_Proposta: TPanel;
    Label14: TLabel;
    pTotal_Trabalhada: TPanel;
    Label15: TLabel;
    pTotal_Saldo: TPanel;
    btnRecalcular: TBitBtn;
    procedure edtOSExit(Sender: TObject);
    procedure edtHoraInicialExit(Sender: TObject);
    procedure edtHoraFinalExit(Sender: TObject);
    procedure edtHoraPerdidaExit(Sender: TObject);
    procedure edtDataInicialExit(Sender: TObject);
    procedure edtDataFinalExit(Sender: TObject);
    procedure edtDataTrabalhadaExit(Sender: TObject);
    procedure dbDiarioCellClick(Column: TColumn);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnGravarOSClick(Sender: TObject);
    procedure btnGravarDadosDiariosClick(Sender: TObject);
    procedure edtSprintExit(Sender: TObject);
    procedure edtDataInicialKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtDataFinalKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtDataTrabalhadaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtHoraInicialKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtHoraFinalKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnExcluirDadosDiariosClick(Sender: TObject);
    procedure edtOSEnter(Sender: TObject);
    procedure dbDiarioDblClick(Sender: TObject);
    procedure btnRecalcularClick(Sender: TObject);
    procedure btnExcluirOSClick(Sender: TObject);
    procedure edtClienteKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    poLancamentoOS : TClass_LancamentoOS;
    procedure pcdValidaHora(psHora: string);
    procedure pcdValidaData(psData: string);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FLancamentoOS: TFLancamentoOS;

implementation

uses
 uDMPrincipal, uConsultaCliente;

{$R *.dfm}

procedure TFLancamentoOS.edtHoraFinalExit(Sender: TObject);
begin
if Trim(edtHoraFinal.Text) <> ':' then
   pcdValidaHora(edtHoraFinal.Text);
end;

procedure TFLancamentoOS.edtHoraFinalKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
If ((Shift = [ssCtrl]) And (Key = Ord('H'))) Then
   Begin
   edtHoraFinal.Text := FormatDateTime('hh:mm', Now);
   edtHoraProposta.SetFocus;
   End;
end;

procedure TFLancamentoOS.edtHoraInicialExit(Sender: TObject);
begin
if Trim(edtHoraInicial.Text) <> ':' then
   pcdValidaHora(edtHoraInicial.Text);
end;

procedure TFLancamentoOS.edtHoraInicialKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
If ((Shift = [ssCtrl]) And (Key = Ord('H'))) Then
   Begin
   edtHoraInicial.Text := FormatDateTime('hh:mm', Now);
   edtDataFinal.SetFocus;
   End;
end;

procedure TFLancamentoOS.edtHoraPerdidaExit(Sender: TObject);
begin
if edtHoraPerdida.Text > edtHoraDisponivel.Text then
   begin
   ShowMessage('Horas perdidas maior do que as disponíveis, verifique!');
   Abort;
   end;

if (Trim(edtHoraDisponivel.Text) <> ':') and (Trim(edtHoraPerdida.Text) <> ':') then
   pHorasTrabalhadas.Caption := FormatDateTime('hh:mm', StrToTime(edtHoraDisponivel.Text) - StrToTime(edtHoraPerdida.Text));
end;

procedure TFLancamentoOS.edtOSEnter(Sender: TObject);
begin
edtOS.Clear;
edtSprint.Clear;
edtCliente.Clear;
edtDataInicial.Clear;
edtHoraInicial.Clear;
edtDataFinal.Clear;
edtHoraFinal.Clear;
edtHoraProposta.Clear;
gbDiario.Enabled := False;
dbDiario.Enabled := False;
gbTotalizador.Enabled := False;
dbDiario.DataSource := nil;
edtDataTrabalhada.Clear;
edtHoraDisponivel.Clear;
edtHoraPerdida.Clear;
pHorasTrabalhadas.Caption := '0:00';
pTotal_Proposta.Caption   := '0:00';
pTotal_Trabalhada.Caption := '0:00';
pTotal_Saldo.Caption      := '0:00';
end;

procedure TFLancamentoOS.edtOSExit(Sender: TObject);
begin
if Trim(edtOS.Text) <> '' then
   edtOS.Text := FormatFloat('000000', StrToFloat(edtOS.Text));


end;

procedure TFLancamentoOS.edtSprintExit(Sender: TObject);
begin
if Trim(edtSprint.Text) <> '' then
   begin
   edtSprint.Text := FormatFloat('000', StrToFloat(edtSprint.Text));

   if Trim(edtOS.Text) <> '' then
      begin
      poLancamentoOS.NumeroOS               := edtOS.Text;
      poLancamentoOS.Sprint                 := StrToInt(edtSprint.Text);
      poLancamentoOS.QueryLancamento_Diario := DMPrincipal.FDLancamento_Diario;
      poLancamentoOS.EncontraDados;

      if Trim(poLancamentoOS.Cliente) <> '' then
         begin
         edtCliente.Text      := poLancamentoOS.Cliente;
         edtDataInicial.Text  := FormatDateTime('dd/mm/yyyy', poLancamentoOS.DataInicial);
         edtHoraInicial.Text  := FormatDateTime('hh:mm', poLancamentoOS.HoraInicial);

         if poLancamentoOS.DataFinal = 0 then
            edtDataFinal.Clear
         else
            edtDataFinal.Text := FormatDateTime('dd/mm/yyyy', poLancamentoOS.DataFinal);

         if poLancamentoOS.HoraFinal = 0 then
            edtHoraFinal.Clear
         else
            edtHoraFinal.Text := FormatDateTime('hh:mm', poLancamentoOS.HoraFinal);

         edtHoraProposta.Text := poLancamentoOS.HoraProposta;

         if poLancamentoOS.QueryLancamento_Diario <> nil then
            begin
            dbDiario.Enabled := True;
            DMPrincipal.FDLancamento_Diario.Close;
            DMPrincipal.FDLancamento_Diario.Open();

            dbDiario.DataSource := DMPrincipal.dsLancamento_Diario;
            DMPrincipal.dsLancamento_Diario.DataSet := DMPrincipal.FDLancamento_Diario;
            btnRecalcularClick(Sender);
            end;

         gbDiario.Enabled := True;
         gbTotalizador.Enabled := True;
         end;
      end;
   end;
end;

procedure TFLancamentoOS.FormClose(Sender: TObject; var Action: TCloseAction);
begin
if Assigned(poLancamentoOS) then
   FreeAndNil(poLancamentoOS);
end;

procedure TFLancamentoOS.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Key = VK_RETURN then
   Perform(Wm_NextDlgCtl,0,0)
else if Key = VK_ESCAPE then
   Close;
end;

procedure TFLancamentoOS.FormShow(Sender: TObject);
begin
poLancamentoOS := TClass_LancamentoOS.Create(DMPrincipal.FDConnection1);


end;

procedure TFLancamentoOS.btnRecalcularClick(Sender: TObject);
var
   vTotalizador : TTotalizador;
begin
if (Trim(edtOS.Text) <> '') and (Trim(edtSprint.Text) <> '') then
   begin
   poLancamentoOS.NumeroOS   := edtOS.Text;
   poLancamentoOS.Sprint     := StrToInt(edtSprint.Text);
   vTotalizador              := poLancamentoOS.fncTotalizador;
   pTotal_Proposta.Caption   := vTotalizador.HProposta;
   pTotal_Trabalhada.Caption := vTotalizador.HTrabalhada;
   pTotal_Saldo.Caption      := vTotalizador.HSaldo;

   if vTotalizador.HSaldoNegativo then
      pTotal_Saldo.Font.Color := clRed
   else
      pTotal_Saldo.Font.Color := clBlue;
   end;
end;

procedure TFLancamentoOS.btnExcluirDadosDiariosClick(Sender: TObject);
begin
//Metodo para excluir

if Trim(edtOS.Text) = '' then
   begin
   ShowMessage('Número da OS está em branco, verifique!');
   edtOS.SetFocus;
   Abort;
   end;

if Trim(edtSprint.Text) = '' then
   begin
   ShowMessage('O número da Sprint está em branco, verifique!');
   edtSprint.SetFocus;
   Abort;
   end;

if Trim(edtDataTrabalhada.Text) = '' then
   begin
   ShowMessage('Data trabalhada está em branco, verifique!');
   edtDataTrabalhada.SetFocus;
   Abort;
   end;

poLancamentoOS.DataTrabalhada := StrToDate(edtDataTrabalhada.Text);
poLancamentoOS.NumeroOS       := edtOS.Text;
poLancamentoOS.Sprint         := StrToInt(edtSprint.Text);

try
   poLancamentoOS.pcdExcluirDados_Diario;
   edtDataTrabalhada.Clear;
   edtHoraDisponivel.Clear;
   edtHoraPerdida.Clear;
   pHorasTrabalhadas.Caption := '0:00';
   DMPrincipal.FDLancamento_Diario.Refresh;
except
   on E:Exception do
      begin
      ShowMessage(E.Message);
      end;
   end;
end;

procedure TFLancamentoOS.btnExcluirOSClick(Sender: TObject);
begin
if Trim(edtOS.Text) = '' then
   begin
   ShowMessage('Número da OS está em branco, verifique!');
   edtOS.SetFocus;
   Abort;
   end;

if Trim(edtSprint.Text) = '' then
   begin
   ShowMessage('O número da Sprint está em branco, verifique!');
   edtSprint.SetFocus;
   Abort;
   end;

poLancamentoOS.NumeroOS       := edtOS.Text;
poLancamentoOS.Sprint         := StrToInt(edtSprint.Text);

try
   poLancamentoOS.pcdExcluirDados;

   if edtOS.CanFocus then
      edtOS.SetFocus;
except
   on E:Exception do
      begin
      ShowMessage(E.Message);
      end;
   end;

end;

procedure TFLancamentoOS.btnGravarDadosDiariosClick(Sender: TObject);
begin
//Metodo para gravar

if Trim(edtOS.Text) = '' then
   begin
   ShowMessage('Número da OS está em branco, verifique!');
   edtOS.SetFocus;
   Abort;
   end;

if Trim(edtSprint.Text) = '' then
   begin
   ShowMessage('O número da Sprint está em branco, verifique!');
   edtSprint.SetFocus;
   Abort;
   end;

if Trim(edtDataTrabalhada.Text) = '' then
   begin
   ShowMessage('Data trabalhada está em branco, verifique!');
   edtDataTrabalhada.SetFocus;
   Abort;
   end;

if Trim(edtHoraPerdida.Text) = '' then
   begin
   ShowMessage('Hora perdida está em branco, verifique!');
   edtHoraPerdida.SetFocus;
   Abort;
   end;

if Trim(edtHoraDisponivel.Text) = '' then
   begin
   ShowMessage('Hora disponível está em branco, verifique!');
   edtHoraDisponivel.SetFocus;
   Abort;
   end;

poLancamentoOS.NumeroOS       := edtOS.Text;
poLancamentoOS.Sprint         := StrToInt(edtSprint.Text);
poLancamentoOS.DataTrabalhada := StrToDate(edtDataTrabalhada.Text);
poLancamentoOS.HoraPerdida    := edtHoraPerdida.Text;
poLancamentoOS.HoraDisponivel := edtHoraDisponivel.Text;
poLancamentoOS.HoraTrabalhada := pHorasTrabalhadas.Caption;

try
   poLancamentoOS.pcdGravarDados_Diario;
   edtDataTrabalhada.Clear;
   edtHoraDisponivel.Clear;
   edtHoraPerdida.Clear;
   pHorasTrabalhadas.Caption := '0:00';
   DMPrincipal.FDLancamento_Diario.Refresh;
   btnRecalcularClick(Sender);

   if edtDataTrabalhada.CanFocus then
      edtDataTrabalhada.SetFocus;
except
   on E:Exception do
      begin
      ShowMessage(E.Message);
      end;
   end;
end;

procedure TFLancamentoOS.btnGravarOSClick(Sender: TObject);
begin
//Metodo para gravar

if Trim(edtOS.Text) = '' then
   begin
   ShowMessage('Número da OS está em branco, verifique!');
   edtOS.SetFocus;
   Abort;
   end;

if Trim(edtSprint.Text) = '' then
   begin
   ShowMessage('O número da Sprint está em branco, verifique!');
   edtSprint.SetFocus;
   Abort;
   end;

if Trim(edtCliente.Text) = '' then
   begin
   ShowMessage('Cliente está em branco, verifique!');
   edtCliente.SetFocus;
   Abort;
   end;

if edtDataInicial.Text = '  /  /    ' then
   begin
   ShowMessage('Data Inicial está em branco, verifique!');
   edtDataInicial.SetFocus;
   Abort;
   end;

if Trim(edtHoraInicial.Text) = ':' then
   begin
   ShowMessage('Hora inicial está em branco, verifique!');
   edtHoraInicial.SetFocus;
   Abort;
   end;

if Trim(edtHoraProposta.Text) = ':' then
   begin
   ShowMessage('Hora proposta está em branco, verifique!');
   edtHoraProposta.SetFocus;
   Abort;
   end;

poLancamentoOS.NumeroOS     := edtOS.Text;
poLancamentoOS.Sprint       := StrToInt(edtSprint.Text);
poLancamentoOS.Cliente      := edtCliente.Text;
poLancamentoOS.DataInicial  := StrToDate(edtDataInicial.Text);
poLancamentoOS.HoraInicial  := StrToTime(edtHoraInicial.Text);

if edtDataFinal.Text = '  /  /    ' then
   poLancamentoOS.DataFinal := 0
else
   poLancamentoOS.DataFinal := StrToDate(edtDataFinal.Text);

if Trim(edtHoraFinal.Text) = ':' then
   poLancamentoOS.HoraFinal := 0
else
   poLancamentoOS.HoraFinal := StrToTime(edtHoraFinal.Text);

poLancamentoOS.HoraProposta := edtHoraProposta.Text;

try
   poLancamentoOS.pcdGravarDados;
   gbDiario.Enabled := True;
   gbTotalizador.Enabled := True;
   dbDiario.Enabled := True;

   if edtDataTrabalhada.CanFocus then
      edtDataTrabalhada.SetFocus;
except
   on E:Exception do
      begin
      ShowMessage(E.Message);
      end;
   end;
end;

procedure TFLancamentoOS.dbDiarioCellClick(Column: TColumn);
begin
dbDiario.Hint := Column.DisplayName;
end;

procedure TFLancamentoOS.dbDiarioDblClick(Sender: TObject);
begin
if not dbDiario.DataSource.DataSet.IsEmpty then
   begin
   edtDataTrabalhada.Text    := dbDiario.DataSource.DataSet.FieldByName('DATATRABALHADA').AsString;
   edtHoraDisponivel.Text    := dbDiario.DataSource.DataSet.FieldByName('HORADISPONIVEL').AsString;
   edtHoraPerdida.Text       := dbDiario.DataSource.DataSet.FieldByName('HORAPERDIDA').AsString;
   pHorasTrabalhadas.Caption := dbDiario.DataSource.DataSet.FieldByName('HORATRABALHADA').AsString;
   end;
end;

procedure TFLancamentoOS.edtClienteKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Key = VK_F2 then
   begin
   Application.CreateForm(TFConsultaCliente, FConsultaCliente);
   try
   FConsultaCliente.ShowModal;
   finally
      FreeAndNil(FConsultaCliente);
      end;

   edtCliente.Text := DMPrincipal.vgsClienteSelecionado;
   end;
end;

procedure TFLancamentoOS.edtDataFinalExit(Sender: TObject);
begin
if edtDataFinal.Text <> '  /  /    ' then
   pcdValidaData(edtDataFinal.Text);
end;

procedure TFLancamentoOS.edtDataFinalKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
If ((Shift = [ssCtrl]) And (Key = Ord('D'))) Then
   Begin
   edtDataFinal.Text := FormatDateTime('dd/mm/yyyy', Now);
   edtHoraFinal.SetFocus;
   End;
end;

procedure TFLancamentoOS.edtDataInicialExit(Sender: TObject);
begin
if edtDataInicial.Text <> '  /  /    ' then
   pcdValidaData(edtDataInicial.Text);
end;

procedure TFLancamentoOS.edtDataInicialKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
If ((Shift = [ssCtrl]) And (Key = Ord('D'))) Then
   Begin
   edtDataInicial.Text := FormatDateTime('dd/mm/yyyy', Now);
   edtHoraInicial.SetFocus;
   End;
end;

procedure TFLancamentoOS.edtDataTrabalhadaExit(Sender: TObject);
begin
if edtDataTrabalhada.Text <> '  /  /    ' then
   pcdValidaData(edtDataTrabalhada.Text);
end;

procedure TFLancamentoOS.edtDataTrabalhadaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
If ((Shift = [ssCtrl]) And (Key = Ord('D'))) Then
   Begin
   edtDataTrabalhada.Text := FormatDateTime('dd/mm/yyyy', Now);
   edtHoraDisponivel.SetFocus;
   End;
end;

procedure TFLancamentoOS.pcdValidaHora(psHora: string);
begin
try
StrToTime(psHora);
except
   ShowMessage('Hora inválida, verifique!');
   Abort;
   end;
end;

procedure TFLancamentoOS.pcdValidaData(psData: string);
begin
try
StrToDate(psData);
except
   ShowMessage('Data inválida, verifique!');
   Abort;
   end;
end;

end.
