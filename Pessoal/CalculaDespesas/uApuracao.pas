unit uApuracao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Mask, uGeraApuracao, uCRUDDespesas, uCRUDFaturamento, uCRUDConfiguracao;

type
  TFApuracao = class(TForm)
    pgcApuracao: TPageControl;
    ts_ApuracaoAnual: TTabSheet;
    ts_ApuracaoFechadas: TTabSheet;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    edtAno: TMaskEdit;
    btnApuracao: TBitBtn;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    btnImprimir: TBitBtn;
    cbAno: TComboBox;
    btnFechar2: TBitBtn;
    btnFechar: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnApuracaoClick(Sender: TObject);
  private
    vloGeraApuracao  : TGeraApuracao;
    vloFaturamento   : TCrudFaturamento;
    vloDespesas      : TCrudDespesas;
    vloConfiguracoes : TCRUDConfiguracao;
    procedure HabilitaPaletas(vPaleta: TTabSheet);
    { Private declarations }
  public
     vPaleta: String;
    { Public declarations }
  end;

var
  FApuracao: TFApuracao;

implementation

{$R *.dfm}

uses uDMPrincipal, uPrincipal;


procedure TFApuracao.btnApuracaoClick(Sender: TObject);
var
   vlsAPUR_ANO                : String;
   vldAPUR_RECEITABRUTA, vldAPUR_DESPESAS, vldAPUR_LUCROEVIDENCIADO,
   vldAPUR_PORCENTAGEMISENTA, vldAPUR_VALORISENTO, vldAPUR_VALORTRIBUTADO,
   vldAPUR_VALORDECLARARIR    : Double;
   vlbAPUR_DECLARA            : Boolean;
begin
vldAPUR_RECEITABRUTA      := 0;
vldAPUR_DESPESAS          := 0;
vldAPUR_LUCROEVIDENCIADO  := 0;
vldAPUR_PORCENTAGEMISENTA := 0;
vldAPUR_VALORISENTO       := 0;
vldAPUR_VALORTRIBUTADO    := 0;
vldAPUR_VALORDECLARARIR   := 0;
vlsAPUR_ANO               := '';
vlbAPUR_DECLARA           := False;

if Trim(edtAno.Text) = '' then
   begin
   Fprincipal.pcdMensagem('Ano obrigatório');
   edtAno.SetFocus;
   Abort;
   end;

{ TODO -oLUCAS -cTESTES :
Fazer todas as validações:
 - Faturamento do Ano
 - Despesas do Ano
 - Alíquota de Isenção
 - Valor do IR a Declarar }

if MessageDlg('Deseja gerar a apuração do ano ' + edtAno.Text + '?', mtInformation, [mbYes, mbNo], 0) = mrYes then
   begin
   vlsAPUR_ANO               := edtAno.Text;
   vldAPUR_DESPESAS          := vloDespesas.fncRetornaValorTotalANO(edtAno.Text);
   vldAPUR_RECEITABRUTA      := vloFaturamento.fncRetornaValorFaturadoANO(edtAno.Text);

   vloConfiguracoes.pcdRetornaValorFaturadoANO(edtAno.Text);
   vldAPUR_PORCENTAGEMISENTA := vloConfiguracoes.poRetornoConfig.CONFIG_PORCENTAGEMISENTO;
   vldAPUR_VALORDECLARARIR   := vloConfiguracoes.poRetornoConfig.CONFIG_VALORDECLARARIR;

   vldAPUR_LUCROEVIDENCIADO  := (vldAPUR_RECEITABRUTA - vldAPUR_DESPESAS);
   vldAPUR_VALORISENTO       := (vldAPUR_RECEITABRUTA * (vldAPUR_PORCENTAGEMISENTA / 100));
   vldAPUR_VALORTRIBUTADO    := (vldAPUR_LUCROEVIDENCIADO - vldAPUR_VALORISENTO);
   vlbAPUR_DECLARA           := vldAPUR_VALORTRIBUTADO > vldAPUR_VALORDECLARARIR;

   vloGeraApuracao.APUR_RECEITABRUTA      := vldAPUR_RECEITABRUTA;
   vloGeraApuracao.APUR_DESPESAS          := vldAPUR_DESPESAS;
   vloGeraApuracao.APUR_LUCROEVIDENCIADO  := vldAPUR_LUCROEVIDENCIADO;
   vloGeraApuracao.APUR_PORCENTAGEMISENTA := vldAPUR_PORCENTAGEMISENTA;
   vloGeraApuracao.APUR_VALORISENTO       := vldAPUR_VALORISENTO;
   vloGeraApuracao.APUR_VALORTRIBUTADO    := vldAPUR_VALORTRIBUTADO;
   vloGeraApuracao.APUR_VALORDECLARARIR   := vldAPUR_VALORDECLARARIR;
   vloGeraApuracao.APUR_ANO               := vlsAPUR_ANO;

   if vlbAPUR_DECLARA then
      vloGeraApuracao.APUR_DECLARA        := 'True'
   else
      vloGeraApuracao.APUR_DECLARA        := 'False';

   vloGeraApuracao.pcdGravaApuracao;
   end;
end;

procedure TFApuracao.btnFecharClick(Sender: TObject);
begin
Close;
end;

procedure TFApuracao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
if Assigned(vloGeraApuracao) then
   FreeAndNil(vloGeraApuracao);

if Assigned(vloDespesas) then
   FreeAndNil(vloDespesas);

if Assigned(vloFaturamento) then
   FreeAndNil(vloFaturamento);

if Assigned(vloConfiguracoes) then
   FreeAndNil(vloConfiguracoes);
end;

procedure TFApuracao.FormKeyPress(Sender: TObject; var Key: Char);
begin
if Key = #13 then
   begin
   Perform(WM_NEXTDLGCTL, 0, 0);
   Key := #0;
   end;
end;

procedure TFApuracao.FormShow(Sender: TObject);
begin
if Trim(vPaleta) = 'Apuração' then
   begin
   HabilitaPaletas(ts_ApuracaoAnual);
   if edtAno.CanFocus then
      edtAno.SetFocus;
   end
else if Trim(vPaleta) = 'Fechadas' then
   begin
   HabilitaPaletas(ts_ApuracaoFechadas);
   if cbAno.CanFocus then
      cbAno.SetFocus;
   end;

vloGeraApuracao  := TGeraApuracao.Create(DMPrincipal.poConexao);
vloDespesas      := TCrudDespesas.Create(DMPrincipal.poConexao);
vloFaturamento   := TCRUDFaturamento.Create(DMPrincipal.poConexao);
vloConfiguracoes := TCRUDConfiguracao.Create(DMPrincipal.poConexao);
end;

procedure TFApuracao.HabilitaPaletas(vPaleta: TTabSheet);
begin
ts_ApuracaoAnual.TabVisible    := vPaleta = ts_ApuracaoAnual;
ts_ApuracaoFechadas.TabVisible := vPaleta = ts_ApuracaoFechadas;
end;

end.
