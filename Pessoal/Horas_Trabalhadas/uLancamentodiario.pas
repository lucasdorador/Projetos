unit uLancamentodiario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.Buttons, FireDAC.Stan.Param,
  Data.DB;

type
  TFLancamentodiario = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtData: TMaskEdit;
    edtHoraIni: TMaskEdit;
    edtHoraFinal: TMaskEdit;
    Label4: TLabel;
    mObservacao: TMemo;
    btnGravar: TBitBtn;
    btnExcluir: TBitBtn;
    procedure edtDataEnter(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure edtDataExit(Sender: TObject);
    procedure edtHoraIniExit(Sender: TObject);
    procedure edtHoraFinalExit(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FLancamentodiario: TFLancamentodiario;

implementation

uses
 uDMPrincipal, uFuncoes;

{$R *.dfm}

procedure TFLancamentodiario.btnExcluirClick(Sender: TObject);
begin
if edtData.Text = '  /  /    ' then
   begin
   ShowMessage('Data está em branco, verifique!');
   edtData.SetFocus;
   Abort;
   end;

if Trim(edtHoraIni.Text) = ':' then
   begin
   ShowMessage('Hora inicial está em branco, verifique!');
   edtHoraIni.SetFocus;
   Abort;
   end;

DMPrincipal.FDInsert.Close;
DMPrincipal.FDInsert.SQL.Clear;
DMPrincipal.FDInsert.SQL.Add('DELETE FROM LANCAMENTODIARIO WHERE DATALANC = :DATA AND HORAINICIAL = :HINICIAL');
DMPrincipal.FDInsert.ParamByName('DATA').AsDate     := StrToDate(edtData.Text);
DMPrincipal.FDInsert.ParamByName('HINICIAL').AsTime := StrToTime(edtHoraIni.Text);
DMPrincipal.FDInsert.ExecSQL;

edtData.SetFocus;
end;

procedure TFLancamentodiario.btnGravarClick(Sender: TObject);
begin
if edtData.Text = '  /  /    ' then
   begin
   ShowMessage('Data está em branco, verifique!');
   edtData.SetFocus;
   Abort;
   end;

if Trim(edtHoraIni.Text) = ':' then
   begin
   ShowMessage('Hora inicial está em branco, verifique!');
   edtHoraIni.SetFocus;
   Abort;
   end;

if Trim(edtHoraFinal.Text) = '' then
   begin
   ShowMessage('Hora final está em branco, verifique!');
   edtHoraFinal.SetFocus;
   Abort;
   end;

DMPrincipal.FDInsert.Close;
DMPrincipal.FDInsert.SQL.Clear;
DMPrincipal.FDInsert.SQL.Add('SELECT DATALANC FROM LANCAMENTODIARIO WHERE DATALANC = :DATA AND HORAINICIAL = :HINICIAL');
DMPrincipal.FDInsert.ParamByName('DATA').AsDate     := StrToDate(edtData.Text);
DMPrincipal.FDInsert.ParamByName('HINICIAL').AsTime := StrToTime(edtHoraIni.Text);
DMPrincipal.FDInsert.Open();

if DMPrincipal.FDInsert.IsEmpty then
   begin
   DMPrincipal.FDInsert.SQL.Clear;
   DMPrincipal.FDInsert.SQL.Add('INSERT INTO LANCAMENTODIARIO (DATALANC, HORAINICIAL, '+
                                'HORAFINAL, OBSERVACAO) VALUES '+
                                '(:DATALANC, :HORAINICIAL, :HORAFINAL, :OBSERVACAO);');
   end
else
   begin
   DMPrincipal.FDInsert.SQL.Clear;
   DMPrincipal.FDInsert.SQL.Add('UPDATE LANCAMENTODIARIO '+
                                'SET HORAFINAL = :HORAFINAL, '+
                                '    OBSERVACAO = :OBSERVACAO '+
                                'WHERE (DATALANC = :DATALANC) AND (HORAINICIAL = :HORAINICIAL);');
   end;

DMPrincipal.FDInsert.ParamByName('DATALANC').AsDate      := StrToDate(edtData.Text);
DMPrincipal.FDInsert.ParamByName('HORAINICIAL').AsTime   := StrToTime(edtHoraIni.Text);
DMPrincipal.FDInsert.ParamByName('HORAFINAL').AsTime     := StrToTime(edtHoraFinal.Text);
DMPrincipal.FDInsert.ParamByName('OBSERVACAO').AsString  := mObservacao.Text;
DMPrincipal.FDInsert.ExecSQL;

edtData.SetFocus;
end;

procedure TFLancamentodiario.edtDataEnter(Sender: TObject);
begin
edtData.Clear;
edtHoraIni.Clear;
edtHoraFinal.Clear;
mObservacao.Lines.Clear;

edtData.Text := FormatDateTime('dd/mm/yyyy', Now);
end;

procedure TFLancamentodiario.edtDataExit(Sender: TObject);
begin
if edtData.Text <> '  /  /    ' then
   TFuncoesData.pcdValidaData(edtData.Text);
end;

procedure TFLancamentodiario.edtHoraFinalExit(Sender: TObject);
begin
if Trim(edtHoraFinal.Text) <> ':' then
   TFuncoesHora.pcdValidaHora(edtHoraFinal.Text);
end;

procedure TFLancamentodiario.edtHoraIniExit(Sender: TObject);
begin
if Trim(edtHoraIni.Text) <> ':' then
   TFuncoesHora.pcdValidaHora(edtHoraIni.Text);

DMPrincipal.FDInsert.Close;
DMPrincipal.FDInsert.SQL.Clear;
DMPrincipal.FDInsert.SQL.Add('SELECT HORAFINAL, OBSERVACAO FROM LANCAMENTODIARIO WHERE DATALANC = :DATA AND HORAINICIAL = :HINICIAL');
DMPrincipal.FDInsert.ParamByName('DATA').AsDate     := StrToDate(edtData.Text);
DMPrincipal.FDInsert.ParamByName('HINICIAL').AsTime := StrToTime(edtHoraIni.Text);
DMPrincipal.FDInsert.Open();

if not DMPrincipal.FDInsert.IsEmpty then
   begin
   edtHoraFinal.Text := FormatDateTime('hh:mm', DMPrincipal.FDInsert.FieldByName('HORAFINAL').AsDateTime);
   mObservacao.Text  := DMPrincipal.FDInsert.FieldByName('OBSERVACAO').AsString;
   end
else
   begin
   if edtHoraIni.Text = '08:00' then
      mObservacao.Text := 'Reunião Diária - Sprint';
   end;
end;

procedure TFLancamentodiario.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Key = VK_RETURN then
   Perform(Wm_NextDlgCtl,0,0)
else if Key = VK_ESCAPE then
   Close;
end;

end.
