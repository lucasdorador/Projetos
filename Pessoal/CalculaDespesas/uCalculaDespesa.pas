unit uCalculaDespesa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask,
  uTDPNumberEditXE8, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.Buttons, uCRUDDespesas;

type
  TFCalculaDespesa = class(TForm)
    gbAnoBase: TGroupBox;
    Label1: TLabel;
    edtAno: TMaskEdit;
    gbDespesas: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    edtDescricao: TEdit;
    edtValor: TDPTNumberEditXE8;
    dbgDespesas: TDBGrid;
    pTotal: TPanel;
    Label4: TLabel;
    btnGravar: TBitBtn;
    btnExcluir: TBitBtn;
    btnFechar: TBitBtn;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnGravarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtAnoExit(Sender: TObject);
    procedure edtAnoEnter(Sender: TObject);
    procedure edtAnoChange(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbgDespesasDblClick(Sender: TObject);
  private
    vloDespesas : TCrudDespesas;
    procedure pcdLimpaCamposDespesa;
    procedure pcdAtualizaGRid;
    procedure pcdAtualizaValorTotal;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FCalculaDespesa: TFCalculaDespesa;

implementation

{$R *.dfm}

uses uDMPrincipal, uPrincipal;

procedure TFCalculaDespesa.pcdLimpaCamposDespesa;
begin
edtDescricao.Clear;
edtValor.Value := 0;

if edtDescricao.CanFocus then
   edtDescricao.SetFocus;
end;

procedure TFCalculaDespesa.btnExcluirClick(Sender: TObject);
begin
vloDespesas.cd_Sequencia := DMPrincipal.FDDespesasDESP_SEQUENCIA.AsInteger;

try
vloDespesas.pcdExcluirDadosBanco;
pcdAtualizaGRid;
pcdLimpaCamposDespesa;
except
   on E:Exception do
      begin
      Fprincipal.pcdMensagem(E.Message);
      end;
   end;
end;

procedure TFCalculaDespesa.btnFecharClick(Sender: TObject);
begin
Close;
end;

procedure TFCalculaDespesa.btnGravarClick(Sender: TObject);
begin
if Trim(edtAno.Text) = '' then
   begin
   Fprincipal.pcdMensagem('Ano obrigatório');
   edtAno.SetFocus;
   Abort;
   end;

if Trim(edtDescricao.Text) = '' then
   begin
   Fprincipal.pcdMensagem('Descrição obrigatória');
   edtDescricao.SetFocus;
   Abort;
   end;

if edtValor.Value = 0 then
   begin
   Fprincipal.pcdMensagem('Valor obrigatório');
   edtValor.SetFocus;
   Abort;
   end;

vloDespesas.cd_Ano       := edtAno.Text;
vloDespesas.cd_Descricao := edtDescricao.Text;
vloDespesas.cd_Valor     := edtValor.Value;

try
vloDespesas.pcdGravarDadosBanco;
pcdAtualizaGRid;
pcdLimpaCamposDespesa;
except
   on E:Exception do
      begin
      Fprincipal.pcdMensagem(E.Message);
      end;
   end;
end;

procedure TFCalculaDespesa.dbgDespesasDblClick(Sender: TObject);
begin
edtDescricao.Text := DMPrincipal.FDDespesasDESP_DESCRICAO.AsString;
edtValor.Value    := DMPrincipal.FDDespesasDESP_VALOR.AsFloat;
end;

procedure TFCalculaDespesa.edtAnoChange(Sender: TObject);
begin
gbDespesas.Enabled := True;
end;

procedure TFCalculaDespesa.edtAnoEnter(Sender: TObject);
begin
DMPrincipal.FDDespesas.Close;
pcdLimpaCamposDespesa;
pTotal.Caption := '0,00';
gbDespesas.Enabled := False;
end;

procedure TFCalculaDespesa.edtAnoExit(Sender: TObject);
begin
pcdAtualizaGRid;
end;

procedure TFCalculaDespesa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
if Assigned(vloDespesas) then
   FreeAndNil(vloDespesas);
end;

procedure TFCalculaDespesa.FormKeyPress(Sender: TObject; var Key: Char);
begin
if Key = #13 then
   begin
   Perform(WM_NEXTDLGCTL, 0, 0);
   Key := #0;
   end;
end;

procedure TFCalculaDespesa.FormShow(Sender: TObject);
begin
vloDespesas := TCrudDespesas.Create(DMPrincipal.poConexao);
end;

procedure TFCalculaDespesa.pcdAtualizaGRid;
begin
DMPrincipal.FDDespesas.Close;
DMPrincipal.FDDespesas.ParamByName('ANO').AsString := edtAno.Text;
DMPrincipal.FDDespesas.Open();

pcdAtualizaValorTotal;
end;

procedure TFCalculaDespesa.pcdAtualizaValorTotal;
begin
pTotal.Caption := FormatFloat(',0.00', vloDespesas.fncRetornaValorTotalANO(edtAno.Text));
end;

end.
