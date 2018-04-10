unit uConfiguracao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTDPNumberEditXE8, Vcl.StdCtrls,
  Vcl.Mask, Vcl.Buttons, uCRUDConfiguracao, Data.DB, Vcl.Grids, Vcl.DBGrids;

type
  TFConfiguracao = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    edtAno: TMaskEdit;
    Label2: TLabel;
    edtAliquotaIsenta: TDPTNumberEditXE8;
    edtValorIRPF: TDPTNumberEditXE8;
    Label3: TLabel;
    btnFechar: TBitBtn;
    btnExcluir: TBitBtn;
    btnGravar: TBitBtn;
    dbConfiguracao: TDBGrid;
    procedure btnFecharClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure edtAnoExit(Sender: TObject);
    procedure dbConfiguracaoDblClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure edtAliquotaIsentaExit(Sender: TObject);
  private
    vloConfiguracao : TCRUDConfiguracao;
    procedure pcdAtualizaGRid;
    procedure pcdLimpaCamposConfiguracao;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FConfiguracao: TFConfiguracao;

implementation

{$R *.dfm}

uses uPrincipal, uDMPrincipal;

procedure TFConfiguracao.btnExcluirClick(Sender: TObject);
begin
vloConfiguracao.CONFIG_ANO := edtAno.Text;

try
vloConfiguracao.pcdExcluiConfiguracao;
pcdAtualizaGRid;
pcdLimpaCamposConfiguracao;
except
   on E:Exception do
      begin
      Fprincipal.pcdMensagem(E.Message);
      end;
   end;
end;

procedure TFConfiguracao.btnFecharClick(Sender: TObject);
begin
Close;
end;

procedure TFConfiguracao.btnGravarClick(Sender: TObject);
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

if edtAliquotaIsenta.Value = 0 then
   begin
   Fprincipal.pcdMensagem('Alíquota Isenção obrigatória');
   edtAliquotaIsenta.SetFocus;
   Abort;
   end;

if edtValorIRPF.Value = 0 then
   begin
   Fprincipal.pcdMensagem('Valor Limite para Imposto de Renda obrigatório');
   edtValorIRPF.SetFocus;
   Abort;
   end;

vloConfiguracao.CONFIG_ANO               := edtAno.Text;
vloConfiguracao.CONFIG_PORCENTAGEMISENTO := edtAliquotaIsenta.Value;
vloConfiguracao.CONFIG_VALORDECLARARIR   := edtValorIRPF.Value;

try
vloConfiguracao.pcdGravaConfiguracao;
pcdAtualizaGRid;
pcdLimpaCamposConfiguracao;
except
   on E:Exception do
      begin
      Fprincipal.pcdMensagem(E.Message);
      end;
   end;
end;

procedure TFConfiguracao.dbConfiguracaoDblClick(Sender: TObject);
begin
edtAno.Text             := DMPrincipal.FDConfiguracaoCONFIG_ANO.AsString;
edtAliquotaIsenta.Value := DMPrincipal.FDConfiguracaoCONFIG_PORCENTAGEMISENTO.AsFloat;
edtValorIRPF.Value      := DMPrincipal.FDConfiguracaoCONFIG_VALORDECLARARIR.AsFloat;
end;

procedure TFConfiguracao.edtAliquotaIsentaExit(Sender: TObject);
begin
if edtAliquotaIsenta.Value > 100 then
   begin
   Fprincipal.pcdMensagem('Não é permitido alíquota maior do que 100 (Cem).');
   edtAliquotaIsenta.Value := 0;
   edtAliquotaIsenta.SetFocus;
   Abort;
   end;
end;

procedure TFConfiguracao.edtAnoExit(Sender: TObject);
begin
if Trim(edtAno.Text) <> '' then
   begin
   if Fprincipal.fncValidaAno(edtAno.Text) then
      begin
      vloConfiguracao.pcdRetornaValorFaturadoANO(edtAno.Text);
      edtAliquotaIsenta.Value := vloConfiguracao.poRetornoConfig.CONFIG_PORCENTAGEMISENTO;
      edtValorIRPF.Value      := vloConfiguracao.poRetornoConfig.CONFIG_VALORDECLARARIR;
      end
   else
      begin
      edtAno.SetFocus;
      end;
   end;
end;

procedure TFConfiguracao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
if Assigned(vloConfiguracao) then
   FreeAndNil(vloConfiguracao);
end;

procedure TFConfiguracao.FormKeyPress(Sender: TObject; var Key: Char);
begin
if Key = #13 then
   begin
   Perform(WM_NEXTDLGCTL, 0, 0);
   Key := #0;
   end;
end;

procedure TFConfiguracao.FormShow(Sender: TObject);
begin
vloConfiguracao := TCRUDConfiguracao.Create(DMPrincipal.poConexao);
pcdAtualizaGRid;
end;

procedure TFConfiguracao.pcdAtualizaGRid;
begin
DMPrincipal.FDConfiguracao.Close;
DMPrincipal.FDConfiguracao.SQL.Clear;
DMPrincipal.FDConfiguracao.SQL.Add('SELECT CONFIG_ANO, CONFIG_PORCENTAGEMISENTO, CONFIG_VALORDECLARARIR FROM CONFIGURACAO ORDER BY CONFIG_ANO DESC');
DMPrincipal.FDConfiguracao.Open();
end;

procedure TFConfiguracao.pcdLimpaCamposConfiguracao;
begin
edtAno.Clear;
edtValorIRPF.Value      := 0;
edtAliquotaIsenta.Value := 0;

if edtAno.CanFocus then
   edtAno.SetFocus;
end;

end.
