unit uLancamentoOS;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls,
  Vcl.Buttons, Data.DB, Vcl.Grids, Vcl.DBGrids;

type
  TFLancamentoOS = class(TForm)
    GroupBox1: TGroupBox;
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
    GroupBox2: TGroupBox;
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
    DBGrid1: TDBGrid;
    GroupBox3: TGroupBox;
    Label13: TLabel;
    Panel2: TPanel;
    Label14: TLabel;
    Panel3: TPanel;
    Label15: TLabel;
    Panel4: TPanel;
    BitBtn3: TBitBtn;
    procedure edtOSExit(Sender: TObject);
    procedure edtHoraInicialExit(Sender: TObject);
    procedure edtHoraFinalExit(Sender: TObject);
    procedure edtHoraPropostaExit(Sender: TObject);
    procedure edtHoraDisponivelExit(Sender: TObject);
    procedure edtHoraPerdidaExit(Sender: TObject);
    procedure edtDataInicialExit(Sender: TObject);
    procedure edtDataFinalExit(Sender: TObject);
    procedure edtDataTrabalhadaExit(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
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
  private
    procedure pcdValidaHora(psHora: string);
    procedure pcdValidaData(psData: string);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FLancamentoOS: TFLancamentoOS;

implementation

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
if Trim(edtHoraPerdida.Text) <> ':' then
   pcdValidaHora(edtHoraPerdida.Text);

if edtHoraPerdida.Text > edtHoraDisponivel.Text then
   begin
   ShowMessage('Horas perdidas maior do que as disponíveis, verifique!');
   Abort;
   end;

pHorasTrabalhadas.Caption := FormatDateTime('hh:mm', StrToTime(edtHoraDisponivel.Text) - StrToTime(edtHoraPerdida.Text));
end;

procedure TFLancamentoOS.edtHoraPropostaExit(Sender: TObject);
begin
if Trim(edtHoraProposta.Text) <> ':' then
   pcdValidaHora(edtHoraProposta.Text);
end;

procedure TFLancamentoOS.edtOSExit(Sender: TObject);
begin
if Trim(edtOS.Text) <> '' then
   edtOS.Text := FormatFloat('000000', StrToFloat(edtOS.Text));
end;

procedure TFLancamentoOS.edtSprintExit(Sender: TObject);
begin
if Trim(edtSprint.Text) <> '' then
   edtSprint.Text := FormatFloat('000', StrToFloat(edtSprint.Text));
end;

procedure TFLancamentoOS.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Key = VK_RETURN then
   Perform(Wm_NextDlgCtl,0,0)
else if Key = VK_ESCAPE then
   Close;
end;

procedure TFLancamentoOS.btnGravarDadosDiariosClick(Sender: TObject);
begin
//Metodo para gravar

edtDataTrabalhada.Clear;
edtHoraDisponivel.Clear;
edtHoraPerdida.Clear;
pHorasTrabalhadas.Caption := '0:00';

if edtDataTrabalhada.CanFocus then
   edtDataTrabalhada.SetFocus;
end;

procedure TFLancamentoOS.btnGravarOSClick(Sender: TObject);
begin
//Metodo para gravar

if edtDataTrabalhada.CanFocus then
   edtDataTrabalhada.SetFocus;
end;

procedure TFLancamentoOS.DBGrid1CellClick(Column: TColumn);
begin
DBGrid1.Hint := Column.DisplayName;
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

procedure TFLancamentoOS.edtHoraDisponivelExit(Sender: TObject);
begin
if Trim(edtHoraDisponivel.Text) <> ':' then
   pcdValidaHora(edtHoraDisponivel.Text);
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
