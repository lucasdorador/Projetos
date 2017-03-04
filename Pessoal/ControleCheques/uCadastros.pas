unit uCadastros;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.Buttons, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, uVariaveis;

type
  TFCadastros = class(TForm)
    PageControl1: TPageControl;
    tsBancos: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    edtCodBancos: TEdit;
    edtDescricaoBancos: TEdit;
    Panel1: TPanel;
    btnGravar: TBitBtn;
    btnExcluir: TBitBtn;
    btnSair: TBitBtn;
    DSCadastros: TDataSource;
    FDCadastros: TFDQuery;
    dbCadastros: TDBGrid;
    tsConta: TTabSheet;
    Label3: TLabel;
    edtBancoContaCorrente: TEdit;
    Label4: TLabel;
    edtDescricaoConta: TEdit;
    Label5: TLabel;
    edtContaCorrente: TEdit;
    edtAgenciaConta: TEdit;
    Label6: TLabel;
    btnCons_Bancos: TBitBtn;
    procedure btnSairClick(Sender: TObject);
    procedure btnCons_BancosClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure dbCadastrosDblClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    procedure pcdCriaCamposTabela(piNumeroCampo, piTamanhoCampo: Integer;
      psTitulo, psNomeCampo: String; poAlinhamento: System.Classes.TAlignment;
      var poDBGrid: TDBGrid);
    procedure pcdColunasDBGRID(Tabela: TTipoTabelaCadastro);
    procedure pcdGravaDados;
    procedure LimpaDados(voTabela: TTipoTabelaCadastro);
    procedure pcdExcluirDados(voTabelas: TTipoTabelaCadastro);
    { Private declarations }
  public
    vgoTipoTabela : TTipoTabelaCadastro;
    procedure HabilitaPaletas(vPaleta: TTabSheet);
    { Public declarations }
  end;

var
  FCadastros: TFCadastros;

implementation

{$R *.dfm}

uses uConsultas, uPrincipal, uFuncoes, udmPrincipal;

procedure TFCadastros.btnCons_BancosClick(Sender: TObject);
begin
Application.CreateForm(TFConsultas, FConsultas);
FConsultas.vgsTabelaConsulta := ttcBanco;
FConsultas.vgsFormConsulta   := tfcCadastro;
FConsultas.ShowModal;
edtBancoContaCorrente.SetFocus;
FreeAndNil(FConsultas);
end;

procedure TFCadastros.btnExcluirClick(Sender: TObject);
begin
if vgoTipoTabela = tt_Banco then
   begin
   if Trim(edtCodBancos.Text) = '' then
      begin
      ShowMessage('Banco inválido para exclusão.');
      edtCodBancos.SetFocus;
      Abort;
      end;
   end
else if vgoTipoTabela = tt_Conta then
   begin
   if Trim(edtBancoContaCorrente.Text) = '' then
      begin
      ShowMessage('Banco inválido para exclusão.');
      edtBancoContaCorrente.SetFocus;
      Abort;
      end;

   if Trim(edtContaCorrente.Text) = '' then
      begin
      ShowMessage('Conta Corrente inválida para exclusão.');
      edtContaCorrente.SetFocus;
      Abort;
      end;
   end;

pcdExcluirDados(vgoTipoTabela);
end;

procedure TFCadastros.btnGravarClick(Sender: TObject);
begin
if vgoTipoTabela = tt_Banco then
   begin
   if Trim(edtCodBancos.Text) = '' then
      begin
      ShowMessage('Digite um banco válido.');
      edtCodBancos.SetFocus;
      Abort;
      end;

   if Trim(edtDescricaoBancos.Text) = '' then
      begin
      ShowMessage('Digite uma descrição válida para o Banco.');
      edtDescricaoBancos.SetFocus;
      Abort;
      end;
   end
else if vgoTipoTabela = tt_Conta then
   begin
   if Trim(edtBancoContaCorrente.Text) = '' then
      begin
      ShowMessage('Digite um banco válido.');
      edtBancoContaCorrente.SetFocus;
      Abort;
      end;

   if Trim(edtAgenciaConta.Text) = '' then
      begin
      ShowMessage('Digite uma agência válida.');
      edtAgenciaConta.SetFocus;
      Abort;
      end;

   if Trim(edtContaCorrente.Text) = '' then
      begin
      ShowMessage('Digite um número de conta corrente válido.');
      edtContaCorrente.SetFocus;
      Abort;
      end;

   if Trim(edtDescricaoConta.Text) = '' then
      begin
      ShowMessage('Digite uma descrição válida para a conta corrente.');
      edtDescricaoConta.SetFocus;
      Abort;
      end;
   end;

pcdGravaDados;
end;

procedure TFCadastros.btnSairClick(Sender: TObject);
begin
Close;
end;

procedure TFCadastros.dbCadastrosDblClick(Sender: TObject);
begin
if vgoTipoTabela = tt_Banco then
   begin
   edtCodBancos.Text       := FDCadastros.FieldByName('BC_CODIGO').AsString;
   edtDescricaoBancos.Text := FDCadastros.FieldByName('BC_DESCRICAO').AsString;
   end
else if vgoTipoTabela = tt_Conta then
   begin
   edtBancoContaCorrente.Text := FDCadastros.FieldByName('CC_BANCO').AsString;
   edtAgenciaConta.Text       := FDCadastros.FieldByName('CC_AGENCIA').AsString;
   edtContaCorrente.Text      := FDCadastros.FieldByName('CC_NUMERO').AsString;
   edtDescricaoConta.Text     := FDCadastros.FieldByName('CC_DESCRICAO').AsString;
   end;
end;

procedure TFCadastros.FormKeyPress(Sender: TObject; var Key: Char);
begin
if Key = #13 then
   begin
   Perform(Wm_NextDlgCtl,0,0);
   Key := #0;
   end
else if Key = #27 then {ESC}
   begin
   Close;
   end;
end;

procedure TFCadastros.FormShow(Sender: TObject);
begin
FPrincipal.PadronizaDbGrid(dbCadastros);
end;

procedure TFCadastros.pcdColunasDBGRID(Tabela: TTipoTabelaCadastro);
var
  I: Integer;
begin
dbCadastros.Columns.Clear;
if Tabela = tt_Banco then
   begin
   pcdCriaCamposTabela(0,  80,  'Codigo', 'BC_CODIGO', System.Classes.taLeftJustify, dbCadastros);
   pcdCriaCamposTabela(1,  360, 'Descrição', 'BC_DESCRICAO', System.Classes.taLeftJustify, dbCadastros);
   end
else if Tabela = tt_Conta then
   begin
   pcdCriaCamposTabela(0,  40,  'Banco', 'CC_BANCO', System.Classes.taLeftJustify, dbCadastros);
   pcdCriaCamposTabela(1,  55,  'Agência', 'CC_AGENCIA', System.Classes.taLeftJustify, dbCadastros);
   pcdCriaCamposTabela(2,  95,  'Conta Corrente', 'CC_NUMERO', System.Classes.taLeftJustify, dbCadastros);
   pcdCriaCamposTabela(3,  250, 'Descrição', 'CC_DESCRICAO', System.Classes.taLeftJustify, dbCadastros);
   end;

for I := 0 to dbCadastros.Columns.Count - 1 do
   begin
   dbCadastros.Columns[i].Title.Font.Style := [fsBold];
   end;
end;

procedure TFCadastros.pcdCriaCamposTabela(piNumeroCampo, piTamanhoCampo: Integer; psTitulo, psNomeCampo: String; poAlinhamento: System.Classes.TAlignment; var poDBGrid: TDBGrid);
begin
poDBGrid.Columns.Add;
poDBGrid.Columns[piNumeroCampo].Title.Caption := psTitulo;
poDBGrid.Columns[piNumeroCampo].FieldName     := psNomeCampo;
poDBGrid.Columns[piNumeroCampo].Width         := piTamanhoCampo;
poDBGrid.Columns[piNumeroCampo].Alignment     := poAlinhamento;
end;

procedure TFCadastros.HabilitaPaletas(vPaleta: TTabSheet);
begin
tsBancos.TabVisible := vPaleta = tsBancos;
tsConta.TabVisible  := vPaleta = tsConta;

FDCadastros.Connection := vgConexao;
if tsBancos.TabVisible then
   begin
   pcdCarregaDadosCadastro(FDCadastros, tt_Banco);
   pcdColunasDBGRID(tt_Banco)
   end
else if tsConta.TabVisible then
   begin
   pcdCarregaDadosCadastro(FDCadastros, tt_Conta);
   pcdColunasDBGRID(tt_Conta);
   end;
end;

procedure TFCadastros.pcdGravaDados;
var
   FDGravar : TFDQuery;
begin
FDGravar := TFDQuery.Create(nil);
try
FDGravar.Close;
FDGravar.Connection := vgConexao;

if vgoTipoTabela = tt_Conta then
   begin
   FDGravar.Close;
   FDGravar.SQL.Clear;
   FDGravar.SQL.Add('SELECT * FROM CONTAS WHERE CC_NUMERO = :NUMERO AND CC_BANCO = :BANCO');
   FDGravar.ParamByName('NUMERO').AsString := edtContaCorrente.Text;
   FDGravar.ParamByName('BANCO').AsString  := edtBancoContaCorrente.Text;
   FDGravar.Open;

   if FDGravar.IsEmpty then
      begin
      FDGravar.SQL.Clear;
      FDGravar.SQL.Add('INSERT INTO CONTAS (CC_NUMERO, CC_BANCO, CC_DESCRICAO, CC_AGENCIA) VALUES (:CC_NUMERO, :CC_BANCO, :CC_DESCRICAO, :CC_AGENCIA)');
      end
   else
      begin
      FDGravar.SQL.Add('UPDATE CONTAS');
      FDGravar.SQL.Add('SET CC_DESCRICAO = :CC_DESCRICAO,');
      FDGravar.SQL.Add('    CC_AGENCIA = :CC_AGENCIA');
      FDGravar.SQL.Add('WHERE (CC_NUMERO = :CC_NUMERO) AND (CC_BANCO = :CC_BANCO)');
      end;

   FDGravar.ParamByName('CC_NUMERO').AsString    := edtContaCorrente.Text;
   FDGravar.ParamByName('CC_BANCO').AsString     := edtBancoContaCorrente.Text;
   FDGravar.ParamByName('CC_DESCRICAO').AsString := edtDescricaoConta.Text;
   FDGravar.ParamByName('CC_AGENCIA').AsString   := edtAgenciaConta.Text;
   end
else if vgoTipoTabela = tt_Banco then
   begin
   FDGravar.Close;
   FDGravar.SQL.Clear;
   FDGravar.SQL.Add('SELECT * FROM BANCOS WHERE BC_CODIGO = :BANCO');
   FDGravar.ParamByName('BANCO').AsString  := edtCodBancos.Text;
   FDGravar.Open;

   if FDGravar.IsEmpty then
      begin
      FDGravar.SQL.Clear;
      FDGravar.SQL.Add('INSERT INTO BANCOS (BC_CODIGO, BC_DESCRICAO) VALUES (:BC_CODIGO, :BC_DESCRICAO)');
      end
   else
      begin
      FDGravar.SQL.Clear;
      FDGravar.SQL.Clear;
      FDGravar.SQL.Add('UPDATE BANCOS');
      FDGravar.SQL.Add('SET BC_DESCRICAO = :BC_DESCRICAO');
      FDGravar.SQL.Add('WHERE (BC_CODIGO = :BC_CODIGO)');
      end;

   FDGravar.ParamByName('BC_CODIGO').AsString    := edtCodBancos.Text;
   FDGravar.ParamByName('BC_DESCRICAO').AsString := edtDescricaoBancos.Text;
   end;

FDGravar.ExecSQL;

finally
   pcdCarregaDadosCadastro(FDCadastros, vgoTipoTabela);
   LimpaDados(vgoTipoTabela);
   FreeAndNil(FDGravar);
   end;
end;

procedure TFCadastros.LimpaDados(voTabela : TTipoTabelaCadastro);
begin
if voTabela = tt_Banco then
   begin
   edtCodBancos.Clear;
   edtDescricaoBancos.Clear;
   if edtCodBancos.CanFocus then
      edtCodBancos.SetFocus;
   end
else if voTabela = tt_Conta then
   begin
   edtBancoContaCorrente.Clear;
   edtDescricaoConta.Clear;
   edtAgenciaConta.Clear;
   edtContaCorrente.Clear;
   if edtBancoContaCorrente.CanFocus then
      edtBancoContaCorrente.SetFocus;
   end
end;

procedure TFCadastros.pcdExcluirDados(voTabelas : TTipoTabelaCadastro);
var
   FDGravar : TFDQuery;
begin
FDGravar := TFDQuery.Create(nil);
try
FDGravar.Close;
FDGravar.Connection := vgConexao;
if voTabelas = tt_Conta then
   begin
   if MessageDlg('Deseja realmente excluir a conta '+edtDescricaoConta.Text+' ?', MtConfirmation, [mbYes, mbNo], 0) = mrYes then
      begin
      FDGravar.SQL.Clear;
      FDGravar.SQL.Add('DELETE FROM CONTAS WHERE CC_NUMERO = :NUMERO AND CC_BANCO = :BANCO');
      FDGravar.ParamByName('NUMERO').AsString := edtContaCorrente.Text;
      FDGravar.ParamByName('BANCO').AsString  := edtBancoContaCorrente.Text;
      FDGravar.ExecSQL;
      end;
   end
else if voTabelas = tt_Banco then
   begin
   if MessageDlg('Deseja realmente excluir o banco '+edtDescricaoBancos.Text+' ?', MtConfirmation, [mbYes, mbNo], 0) = mrYes then
      begin
      FDGravar.SQL.Clear;
      FDGravar.SQL.Add('DELETE FROM BANCOS WHERE BC_CODIGO = :BANCO');
      FDGravar.ParamByName('BANCO').AsString  := edtCodBancos.Text;
      FDGravar.ExecSQL;
      end;
   end;

finally
   pcdCarregaDadosCadastro(FDCadastros, vgoTipoTabela);
   LimpaDados(vgoTipoTabela);
   FreeAndNil(FDGravar);
   end;
end;



end.

