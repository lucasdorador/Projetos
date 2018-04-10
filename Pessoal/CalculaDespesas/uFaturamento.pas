unit uFaturamento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  uTDPNumberEditXE8, Vcl.Mask, Data.DB, Vcl.Grids, Vcl.DBGrids,
  uCRUDFaturamento;

type
  TFFaturamento = class(TForm)
    gbAnoBase: TGroupBox;
    Label1: TLabel;
    edtAno: TMaskEdit;
    Label2: TLabel;
    edtValor: TDPTNumberEditXE8;
    btnGravar: TBitBtn;
    btnExcluir: TBitBtn;
    btnFechar: TBitBtn;
    dbgFaturamento: TDBGrid;
    procedure btnFecharClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure dbgFaturamentoDblClick(Sender: TObject);
    procedure edtAnoExit(Sender: TObject);
  private
    vloFaturamento : TCrudFaturamento;
    procedure pcdAtualizaGRid;
    procedure pcdLimpaCamposFaturamento;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FFaturamento: TFFaturamento;

implementation

{$R *.dfm}

uses uDMPrincipal, uPrincipal;

procedure TFFaturamento.btnExcluirClick(Sender: TObject);
begin
vloFaturamento.Fat_Ano := DMPrincipal.FDFaturamentoFAT_ANO.AsString;

try
vloFaturamento.pcdExcluiFaturamento;
pcdAtualizaGRid;
pcdLimpaCamposFaturamento;
except
   on E:Exception do
      begin
      Fprincipal.pcdMensagem(E.Message);
      end;
   end;
end;

procedure TFFaturamento.btnFecharClick(Sender: TObject);
begin
Close;
end;

procedure TFFaturamento.btnGravarClick(Sender: TObject);
begin
if Trim(edtAno.Text) = '' then
   begin
   Fprincipal.pcdMensagem('Ano obrigatório');
   edtAno.SetFocus;
   Abort;
   end
else
   begin
   if not Fprincipal.fncValidaAno(edtAno.Text) then
      begin
      edtAno.SetFocus;
      Abort;
      end;
   end;

if edtValor.Value = 0 then
   begin
   Fprincipal.pcdMensagem('Valor obrigatório');
   edtValor.SetFocus;
   Abort;
   end;

vloFaturamento.Fat_Ano   := edtAno.Text;
vloFaturamento.Fat_Valor := edtValor.Value;

try
vloFaturamento.pcdGravaFaturamento;
pcdAtualizaGRid;
pcdLimpaCamposFaturamento;
except
   on E:Exception do
      begin
      Fprincipal.pcdMensagem(E.Message);
      end;
   end;
end;

procedure TFFaturamento.dbgFaturamentoDblClick(Sender: TObject);
begin
edtAno.Text    := DMPrincipal.FDFaturamentoFAT_ANO.AsString;
edtValor.Value := DMPrincipal.FDFaturamentoFAT_VALOR.AsFloat;
end;

procedure TFFaturamento.edtAnoExit(Sender: TObject);
begin
if Trim(edtAno.Text) <> '' then
   begin
   if Fprincipal.fncValidaAno(edtAno.Text) then
      begin
      edtValor.Value := vloFaturamento.fncRetornaValorFaturadoANO(edtAno.Text);
      end
   else
      begin
      edtAno.SetFocus;
      end;
   end;
end;

procedure TFFaturamento.pcdAtualizaGRid;
begin
DMPrincipal.FDFaturamento.Close;
DMPrincipal.FDFaturamento.SQL.Clear;
DMPrincipal.FDFaturamento.SQL.Add('SELECT FAT_ANO, FAT_VALOR FROM FATURAMENTO ORDER BY FAT_ANO DESC');
DMPrincipal.FDFaturamento.Open();
end;

procedure TFFaturamento.FormClose(Sender: TObject; var Action: TCloseAction);
begin
if Assigned(vloFaturamento) then
   FreeAndNil(vloFaturamento);
end;

procedure TFFaturamento.FormKeyPress(Sender: TObject; var Key: Char);
begin
if Key = #13 then
   begin
   Perform(WM_NEXTDLGCTL, 0, 0);
   Key := #0;
   end;
end;

procedure TFFaturamento.pcdLimpaCamposFaturamento;
begin
edtAno.Clear;
edtValor.Value := 0;

if edtAno.CanFocus then
   edtAno.SetFocus;
end;

procedure TFFaturamento.FormShow(Sender: TObject);
begin
vloFaturamento := TCRUDFaturamento.Create(DMPrincipal.poConexao);
pcdAtualizaGRid;
end;

end.
