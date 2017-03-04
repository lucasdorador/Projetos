unit uControleCheques;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons,
  Vcl.Mask, uTDPNumberEditXE8, Data.DB, Vcl.Grids, Vcl.DBGrids, FireDac.Comp.Script,
  FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Stan.Intf, FireDAC.Comp.UI,
  IBX.IBScript, FireDAc.Comp.Client, FireDAc.Stan.Def, FireDAc.Dapt,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.Comp.DataSet;

type
  TFControleCheques = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    btnCons_Bancos: TBitBtn;
    PBancos: TPanel;
    edtContaCorrente: TEdit;
    btnCons_ContaCorrente: TBitBtn;
    PContaCorrente: TPanel;
    edtBanco: TMaskEdit;
    edtNumeroCheque: TEdit;
    edtValor: TDPTNumberEditXE8;
    edtData: TMaskEdit;
    edtCompensacao: TMaskEdit;
    btnGravar: TBitBtn;
    btnExcluir: TBitBtn;
    btnSair: TBitBtn;
    DBGrid1: TDBGrid;
    FDCheques: TFDQuery;
    dsCheques: TDataSource;
    FDChequesCH_CODIGO: TIntegerField;
    FDChequesCH_BANCO: TStringField;
    FDChequesCH_CONTACORRENTE: TStringField;
    FDChequesCH_NUMEROCHEQUE: TStringField;
    FDChequesCH_VALOR: TFloatField;
    FDChequesCH_DATALANCAMENTO: TDateField;
    FDChequesCH_DATACOMPENSACAO: TDateField;
    Label7: TLabel;
    edtFornecedor: TEdit;
    FDChequesCH_FORNECEDOR: TStringField;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure edtDataEnter(Sender: TObject);
    procedure edtBancoExit(Sender: TObject);
    procedure edtContaCorrenteExit(Sender: TObject);
    procedure btnCons_BancosClick(Sender: TObject);
    procedure btnCons_ContaCorrenteClick(Sender: TObject);
    procedure edtContaCorrenteKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtBancoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnGravarClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure edtDataExit(Sender: TObject);
    procedure edtCompensacaoExit(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
  private
    function fncUltimoCodigoCheque: Integer;
    procedure pcdAtualizaTabela;
    procedure pcdLimpaDados;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FControleCheques: TFControleCheques;

implementation

{$R *.dfm}

uses uTabelas, uFuncoes, uVariaveis, udmPrincipal, uConsultas;

procedure TFControleCheques.btnCons_BancosClick(Sender: TObject);
begin
Application.CreateForm(TFConsultas, FConsultas);
FConsultas.vgsTabelaConsulta := ttcBanco;
FConsultas.vgsFormConsulta   := tfcControle;
FConsultas.ShowModal;
edtBanco.SetFocus;
FreeAndNil(FConsultas);
end;

procedure TFControleCheques.btnCons_ContaCorrenteClick(Sender: TObject);
begin
Application.CreateForm(TFConsultas, FConsultas);
FConsultas.vgsTabelaConsulta := ttcConta;
FConsultas.vgBanco           := edtBanco.Text;
if Trim(edtBanco.Text) = '' then
   begin
   ShowMessage('Escolha um banco válido antes de pesquisar uma conta!');
   edtBanco.SetFocus;
   Abort;
   end;
FConsultas.ShowModal;
edtContaCorrente.SetFocus;
FreeAndNil(FConsultas);
end;

procedure TFControleCheques.btnExcluirClick(Sender: TObject);
var
   QCheques : TFDQuery;
begin
QCheques :=  TFDQuery.Create(nil);
try
if MessageDlg('Deseja realmente excluir esse lançamento?', MtConfirmation, [mbYes, mbNo], 0) = MrYes then
   begin
   QCheques.Close;
   QCheques.Connection := vgConexao;
   QCheques.SQL.Clear;
   QCheques.SQL.Add('DELETE FROM CHEQUES WHERE CH_BANCO = :BAN AND CH_CONTACORRENTE = :CON AND CH_NUMEROCHEQUE = :NUM');
   QCheques.ParamByName('BAN').AsString := edtBanco.Text;
   QCheques.ParamByName('CON').AsString := edtContaCorrente.Text;
   QCheques.ParamByName('NUM').AsString := edtNumeroCheque.Text;
   try
   QCheques.ExecSQL;
   except
      on E:Exception do
         begin
         ShowMessage('Houve um erro na exclusão com a mensagem: ' + e.Message);
         Abort;
         end;
      end;
   end;

finally
   pcdAtualizaTabela;
   FreeAndNil(QCheques);
   pcdLimpaDados;
   btnGravar.Enabled  := False;
   btnExcluir.Enabled := False;
   end;
end;

procedure TFControleCheques.btnGravarClick(Sender: TObject);
var
   QCheques : TFDQuery;
begin
QCheques :=  TFDQuery.Create(nil);
if ((Trim(edtBanco.Text) = '') or (Trim(PBancos.Caption) = '')) then
   begin
   ShowMessage('Digite um banco válido!');
   edtBanco.SetFocus;
   Abort;
   end;

if ((Trim(edtContaCorrente.Text) = '') or (Trim(PContaCorrente.Caption) = '')) then
   begin
   ShowMessage('Digite uma conta válida!');
   edtContaCorrente.SetFocus;
   Abort;
   end;

if Trim(edtFornecedor.Text) = '' then
   begin
   ShowMessage('Digite um fornecedor válido!');
   edtFornecedor.SetFocus;
   Abort;
   end;

if ((Trim(edtNumeroCheque.Text) = '')) then
   begin
   ShowMessage('Digite um cheque válido!');
   edtNumeroCheque.SetFocus;
   Abort;
   end;

if (edtValor.Value <= 0) then
   begin
   ShowMessage('Digite um valor válido!');
   edtValor.SetFocus;
   Abort;
   end;

if (edtData.Text = '  /  /    ') then
   begin
   ShowMessage('Digite uma data válida!');
   edtData.SetFocus;
   Abort;
   end;

try
QCheques.Close;
QCheques.Connection := vgConexao;
QCheques.SQL.Clear;
QCheques.SQL.Add('SELECT * FROM CHEQUES WHERE CH_BANCO = :BAN AND CH_CONTACORRENTE = :CON AND CH_NUMEROCHEQUE = :NUM');
QCheques.ParamByName('BAN').AsString := edtBanco.Text;
QCheques.ParamByName('CON').AsString := edtContaCorrente.Text;
QCheques.ParamByName('NUM').AsString := edtNumeroCheque.Text;
QCheques.Open;

if QCheques.IsEmpty then
   begin
   QCheques.SQL.Clear;
   QCheques.SQL.Add('INSERT INTO CHEQUES (CH_CODIGO, CH_BANCO, CH_CONTACORRENTE, CH_NUMEROCHEQUE, '+
                    '                     CH_VALOR, CH_DATALANCAMENTO, CH_DATACOMPENSACAO, CH_FORNECEDOR) VALUES '+
                    '(:CH_CODIGO, :CH_BANCO, :CH_CONTACORRENTE, :CH_NUMEROCHEQUE, :CH_VALOR, '+
                    ' :CH_DATALANCAMENTO, :CH_DATACOMPENSACAO, :CH_FORNECEDOR);');
   QCheques.ParamByName('CH_CODIGO').AsInteger         := fncUltimoCodigoCheque;
   QCheques.ParamByName('CH_BANCO').AsString           := edtBanco.Text;
   QCheques.ParamByName('CH_CONTACORRENTE').AsString   := edtContaCorrente.Text;
   QCheques.ParamByName('CH_NUMEROCHEQUE').AsString    := edtNumeroCheque.Text;
   QCheques.ParamByName('CH_VALOR').AsFloat            := edtValor.Value;
   QCheques.ParamByName('CH_DATALANCAMENTO').AsString  := FormatDateTime('mm/dd/yyyy', StrToDate(edtData.Text));
   if edtCompensacao.Text <> '  /  /    ' then
      QCheques.ParamByName('CH_DATACOMPENSACAO').AsString := FormatDateTime('mm/dd/yyyy', StrToDate(edtCompensacao.Text));
   QCheques.ParamByName('CH_FORNECEDOR').AsString      := Trim(edtFornecedor.Text);
   try
   QCheques.ExecSQL;
   except
      on E:Exception do
         begin
         ShowMessage('Houve um erro na inserção com a mensagem: ' + e.Message);
         Abort;
         end;
      end;
   end
else
   begin
   QCheques.SQL.Clear;
   QCheques.SQL.Add('UPDATE CHEQUES '+
                    'SET CH_VALOR = :CH_VALOR, '+
                    '    CH_DATALANCAMENTO = :CH_DATALANCAMENTO, '+
                    '    CH_DATACOMPENSACAO = :CH_DATACOMPENSACAO, '+
                    '    CH_FORNECEDOR      = :CH_FORNECEDOR '+
                    'WHERE (CH_NUMEROCHEQUE = :CH_NUMEROCHEQUE) AND (CH_BANCO = :CH_BANCO) AND'+
                    '(CH_CONTACORRENTE = :CH_CONTACORRENTE);');
   QCheques.ParamByName('CH_BANCO').AsString           := edtBanco.Text;
   QCheques.ParamByName('CH_CONTACORRENTE').AsString   := edtContaCorrente.Text;
   QCheques.ParamByName('CH_NUMEROCHEQUE').AsString    := edtNumeroCheque.Text;
   QCheques.ParamByName('CH_VALOR').AsFloat            := edtValor.Value;
   QCheques.ParamByName('CH_DATALANCAMENTO').AsString  := FormatDateTime('mm/dd/yyyy', StrToDate(edtData.Text));
   QCheques.ParamByName('CH_DATACOMPENSACAO').AsString := FormatDateTime('mm/dd/yyyy', StrToDate(edtCompensacao.Text));
   QCheques.ParamByName('CH_FORNECEDOR').AsString      := Trim(edtFornecedor.Text);
   try
   QCheques.ExecSQL;
   except
      on E:Exception do
         begin
         ShowMessage('Houve um erro na alteração com a mensagem: ' + e.Message);
         Abort;
         end;
      end;
   end;

finally
   pcdAtualizaTabela;
   FreeAndNil(QCheques);
   pcdLimpaDados;
   btnGravar.Enabled  := False;
   btnExcluir.Enabled := False;
   end;
end;

function TFControleCheques.fncUltimoCodigoCheque: Integer;
var
   QCheques : TFDQuery;
begin
QCheques :=  TFDQuery.Create(nil);
try
QCheques.Close;
QCheques.Connection := vgConexao;
QCheques.SQL.Clear;
QCheques.SQL.Add('SELECT MAX(CH_CODIGO) AS CODIGO FROM CHEQUES');
QCheques.Open;

if QCheques.FieldByName('CODIGO').AsInteger = 0 then
   Result := 1
else
   Result := QCheques.FieldByName('CODIGO').AsInteger + 1;

finally
   FreeAndNil(QCheques);
   end;
end;

procedure TFControleCheques.btnSairClick(Sender: TObject);
begin
Close;
end;

procedure TFControleCheques.DBGrid1CellClick(Column: TColumn);
begin
DBGrid1.Hint     := dsCheques.DataSet.FieldByName('CH_FORNECEDOR').AsString;
DBGrid1.ShowHint := True;
end;

procedure TFControleCheques.DBGrid1DblClick(Sender: TObject);
begin
edtBanco.Enabled               := False;
edtContaCorrente.Enabled       := False;
edtNumeroCheque.Enabled        := False;
btnCons_Bancos.Enabled         := False;
btnCons_ContaCorrente.Enabled  := False;

edtBanco.Text         := FDChequesCH_BANCO.AsString;
if Trim(edtBanco.Text) <> '' then
   edtBancoExit(Sender);
edtContaCorrente.Text := FDChequesCH_CONTACORRENTE.AsString;
if Trim(edtContaCorrente.Text) <> '' then
   edtContaCorrenteExit(Sender);
edtNumeroCheque.Text  := FDChequesCH_NUMEROCHEQUE.AsString;
edtValor.Value        := FDChequesCH_VALOR.AsFloat;
edtData.Text          := FDChequesCH_DATALANCAMENTO.AsString;
edtCompensacao.Text   := FDChequesCH_DATACOMPENSACAO.AsString;
edtFornecedor.Text    := FDChequesCH_FORNECEDOR.AsString;

if edtCompensacao.CanFocus then
   edtCompensacao.SetFocus;

btnGravar.Enabled  := True;
btnExcluir.Enabled := True;
end;

procedure TFControleCheques.edtBancoExit(Sender: TObject);
begin
if Trim(edtBanco.Text) <> '' then
   PBancos.Caption := fncPesquisaBanco(vgConexao, edtBanco.Text);

btnGravar.Enabled := True;
end;

procedure TFControleCheques.edtBancoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if ((Key = VK_F2) and (btnCons_Bancos.Enabled)) then
   btnCons_BancosClick(Sender);
end;

procedure TFControleCheques.edtCompensacaoExit(Sender: TObject);
begin
if edtCompensacao.Text <> '  /  /    ' then
   begin
   try
   StrToDate(edtCompensacao.Text);
   except
      ShowMessage('Digite uma data válida!');
      edtCompensacao.SetFocus;
      Abort;
      end;
   end;
end;

procedure TFControleCheques.edtContaCorrenteExit(Sender: TObject);
begin
if ((Trim(edtContaCorrente.Text) <> '') and (Trim(edtBanco.Text) <> '')) then
   PContaCorrente.Caption := fncPesquisaContaCorrente(vgConexao, edtContaCorrente.Text, edtBanco.Text);
end;

procedure TFControleCheques.edtContaCorrenteKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
if ((Key = VK_F2) and (btnCons_ContaCorrente.Enabled)) then
   btnCons_ContaCorrenteClick(Sender);
end;

procedure TFControleCheques.edtDataEnter(Sender: TObject);
begin
if edtData.Text = '  /  /    ' then
   edtData.Text := FormatDateTime('dd/mm/yyyy', Date);

end;

procedure TFControleCheques.edtDataExit(Sender: TObject);
begin
if edtData.Text <> '  /  /    ' then
   begin
   try
   StrToDate(edtData.Text);
   except
      ShowMessage('Digite uma data válida!');
      edtData.SetFocus;
      Abort;
      end;
   end;
end;

procedure TFControleCheques.FormKeyPress(Sender: TObject; var Key: Char);
begin
if Key = #13 then
   begin
   Perform(Wm_NextDlgCtl,0,0);
   Key := #0;
   end
else if Key = #27 then {ESC}
   begin
   btnSairClick(Sender);
   end;
end;

procedure TFControleCheques.FormShow(Sender: TObject);
begin
pcdAtualizaTabela;
edtBanco.SetFocus;
end;

procedure TFControleCheques.pcdAtualizaTabela;
begin
FDCheques.Close;
FDCheques.Connection := vgConexao;
FDCheques.SQL.Clear;
FDCheques.SQL.Add('SELECT * FROM CHEQUES');
FDCheques.Open();

TFloatField(FDCheques.FieldByName('CH_VALOR')).DisplayFormat := ',0.00';
FDCheques.FieldByName('CH_VALOR').EditMask := ',0.00';
end;

procedure TFControleCheques.pcdLimpaDados;
begin
edtBanco.Enabled               := True;
edtContaCorrente.Enabled       := True;
edtNumeroCheque.Enabled        := True;
btnCons_Bancos.Enabled         := True;
btnCons_ContaCorrente.Enabled  := True;
edtBanco.Clear;
PBancos.Caption := '';
edtContaCorrente.Clear;
PContaCorrente.Caption := '';
edtNumeroCheque.Clear;
edtValor.Value := 0;
edtData.Clear;
edtCompensacao.Clear;
edtFornecedor.Clear;

edtBanco.SetFocus;
end;

end.
