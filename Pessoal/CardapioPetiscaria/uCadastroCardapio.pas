unit uCadastroCardapio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, uDAOGrupo,
  uTDPNumberEditXE8, Vcl.ExtCtrls, uDAOCardapio, DMPrincipal;

type
  TFCadastroCardapio = class(TForm)
    Label1: TLabel;
    edtCodGrupo: TEdit;
    Label2: TLabel;
    pDescricaoGrupo: TPanel;
    Label4: TLabel;
    edtDescricaoProduto: TEdit;
    Label5: TLabel;
    edtValorInteira: TDPTNumberEditXE8;
    Label6: TLabel;
    edtValorMeia: TDPTNumberEditXE8;
    Panel2: TPanel;
    btnSair: TBitBtn;
    btnExcluir: TBitBtn;
    btnGravar: TBitBtn;
    btnBuscaGrupo: TBitBtn;
    btnBuscaProduto: TBitBtn;
    btnImprimir: TBitBtn;
    procedure btnSairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnBuscaGrupoClick(Sender: TObject);
    procedure edtCodGrupoExit(Sender: TObject);
    procedure edtCodGrupoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtDescricaoProdutoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnBuscaProdutoClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure edtCodGrupoEnter(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure edtCodGrupoKeyPress(Sender: TObject; var Key: Char);
  private
    vloDAOCardapio : TDAOCardapio;
    vloDAOGrupo    : TDAOGrupo;
    vlbLimpaDados  : Boolean;
    procedure pcdLimpaCampos;
    { Private declarations }
  public
      vgiCodProduto  : Integer;
    { Public declarations }
  end;

var
  FCadastroCardapio: TFCadastroCardapio;

implementation

{$R *.dfm}

uses uCons_Grupos, uCons_Produtos;

procedure TFCadastroCardapio.btnBuscaGrupoClick(Sender: TObject);
begin
Application.CreateForm(TFCons_Grupos, FCons_Grupos);
FCons_Grupos.ShowModal;
FreeAndNil(FCons_Grupos);

if Trim(edtCodGrupo.Text) <> '' then
   edtCodGrupoExit(Sender);

if edtDescricaoProduto.CanFocus then
   edtDescricaoProduto.SetFocus;
end;

procedure TFCadastroCardapio.btnBuscaProdutoClick(Sender: TObject);
begin
Application.CreateForm(TFCons_Produtos, FCons_Produtos);
FCons_Produtos.ShowModal;
FreeAndNil(FCons_Produtos);

if Trim(edtCodGrupo.Text) <> '' then
   edtCodGrupoExit(Sender);

btnExcluir.Enabled := True;

if edtDescricaoProduto.CanFocus then
   edtDescricaoProduto.SetFocus;
end;

procedure TFCadastroCardapio.btnExcluirClick(Sender: TObject);
begin
vloDAOCardapio.PRO_CODIGO := vgiCodProduto;
vloDAOCardapio.PRO_GRUPO  := StrToInt(edtCodGrupo.Text);
vloDAOCardapio.fncDeletaProduto;

pcdLimpaCampos;
end;

procedure TFCadastroCardapio.btnGravarClick(Sender: TObject);
begin
if ((Trim(edtCodGrupo.Text) = '') or
    ((Trim(edtCodGrupo.Text) <> '') and (Trim(pDescricaoGrupo.Caption) = ''))) then
   begin
   ShowMessage('Código do Grupo inválido.');
   vlbLimpaDados := False;
   edtCodGrupo.SetFocus;
   Abort;
   end;

if Trim(edtDescricaoProduto.Text) = '' then
   begin
   ShowMessage('Descrição do Produto inválido.');
   edtDescricaoProduto.SetFocus;
   Abort;
   end;

if edtValorInteira.Value = 0 then
   begin
   ShowMessage('Valor da Inteira tem que ser maior que 0(Zero).');
   edtValorInteira.SetFocus;
   Abort;
   end;

vloDAOCardapio.PRO_CODIGO       := vgiCodProduto;
vloDAOCardapio.PRO_GRUPO        := StrToInt(edtCodGrupo.Text);
vloDAOCardapio.PRO_DESCRICAO    := edtDescricaoProduto.Text;
vloDAOCardapio.PRO_VALORMEIA    := edtValorMeia.Value;
vloDAOCardapio.PRO_VALORINTEIRA := edtValorInteira.Value;
vloDAOCardapio.fncInsereProduto;

pcdLimpaCampos;
end;

procedure TFCadastroCardapio.btnImprimirClick(Sender: TObject);
begin
if FileExists(ExtractFilePath(Application.ExeName) + 'Relatorios\Rel_Cardapio.fr3') then
   begin
   DMPrinc.FDRel_Cardapio.Open();
   DMPrinc.FDRel_Cardapio.Refresh;
   DMPrinc.frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Relatorios\Rel_Cardapio.fr3');
   DMPrinc.frxReport1.ShowReport(True);
   end
else
   ShowMessage('O Relatório não foi localizado, copie o arquivo: Rel_Cardapio.fr3 para a pasta: ' + ExtractFilePath(Application.ExeName)+ 'Relatorios\');
end;

procedure TFCadastroCardapio.btnSairClick(Sender: TObject);
begin
Close;
end;

procedure TFCadastroCardapio.edtCodGrupoEnter(Sender: TObject);
begin
if vlbLimpaDados then
   pcdLimpaCampos
else
   vlbLimpaDados := True;
end;

procedure TFCadastroCardapio.edtCodGrupoExit(Sender: TObject);
begin
if Trim(edtCodGrupo.Text) <> '' then
   begin
   vloDAOGrupo.GRUPO_CODIGO := StrToInt(edtCodGrupo.Text);
   pDescricaoGrupo.Caption  := vloDAOGrupo.fncConsultaGrupo;
   end
else
  pDescricaoGrupo.Caption  := '';
end;

procedure TFCadastroCardapio.edtCodGrupoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Key = VK_F2 then
   btnBuscaGrupo.Click;
end;

procedure TFCadastroCardapio.edtCodGrupoKeyPress(Sender: TObject;
  var Key: Char);
begin
if not( key in['0'..'9',#08,#13,#27,#42] ) then
   key:=#0;
end;

procedure TFCadastroCardapio.edtDescricaoProdutoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
if Key = VK_F2 then
   btnBuscaProduto.Click;
end;

procedure TFCadastroCardapio.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
case Key of
   VK_F3     : btnGravar.Click;
   VK_F4     : btnExcluir.Click;
   VK_F5     : btnImprimir.Click;
   VK_ESCAPE : btnSair.Click;
end;
end;

procedure TFCadastroCardapio.FormKeyPress(Sender: TObject; var Key: Char);
begin
if Key = #13 then
   begin
   Perform(Wm_NextDlgCtl,0,0);
   Key := #0;
   end
end;

procedure TFCadastroCardapio.FormShow(Sender: TObject);
begin
vloDAOCardapio := TDAOCardapio.Create(DMPrinc.FDConnection1);
vloDAOGrupo    := TDAOGrupo.Create(DMPrinc.FDConnection1);
vgiCodProduto  := 0;
vlbLimpaDados  := True;
end;

procedure TFCadastroCardapio.pcdLimpaCampos;
begin
edtCodGrupo.Clear;
edtDescricaoProduto.Clear;
edtValorInteira.Value   := 0;
edtValorMeia.Value      := 0;
pDescricaoGrupo.Caption := '';
vgiCodProduto           := 0;
btnExcluir.Enabled      := False;

if edtCodGrupo.CanFocus then
   edtCodGrupo.SetFocus;

end;

end.
