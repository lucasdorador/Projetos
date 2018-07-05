unit uPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Menus,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Ani, FMX.Objects, FMX.TabControl,
  FMX.Edit, FMX.EditBox, FMX.NumberBox, FMX.DateTimeCtrls, FireDAC.Comp.Client;

type
  TFprincipal = class(TForm)
    MainMenu1: TMainMenu;
    Cadastro: TMenuItem;
    Produto: TMenuItem;
    Movimentacao: TMenuItem;
    Compras: TMenuItem;
    Vendas: TMenuItem;
    Sair: TMenuItem;
    TabPrincipal: TTabControl;
    TabCadProduto: TTabItem;
    TabCompras: TTabItem;
    TabVendas: TTabItem;
    recButoesProduto: TRectangle;
    btnCadProduto_Sair: TButton;
    btnCadProduto_Excluir: TButton;
    btnCadProduto_Gravar: TButton;
    recBotoesMovEntrada: TRectangle;
    btnMovEntrada_Sair: TButton;
    btnMovEntrada_Excluir: TButton;
    btnMovEntrada_Gravar: TButton;
    recBotoesMovSaida: TRectangle;
    btnMovSaida_Sair: TButton;
    btnMovSaida_Excluir: TButton;
    btnMovSaida_Gravar: TButton;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    edtDescricaoProduto: TEdit;
    Label4: TLabel;
    edtProEstoque: TNumberBox;
    edtCodProduto: TNumberBox;
    edtCodIntProduto: TNumberBox;
    Label1: TLabel;
    Label2: TLabel;
    GroupBox2: TGroupBox;
    edtCPProduto: TEdit;
    Label5: TLabel;
    edtCPQtde: TNumberBox;
    Label6: TLabel;
    edtCPNumero: TNumberBox;
    Label7: TLabel;
    edtCPData: TDateEdit;
    Label8: TLabel;
    btnConsProdutoEntrada: TButton;
    edtDescProdutoEntrada: TEdit;
    GroupBox3: TGroupBox;
    edtVDProduto: TEdit;
    Label9: TLabel;
    edtVDQtde: TNumberBox;
    Label10: TLabel;
    edtVDNumero: TNumberBox;
    Label11: TLabel;
    edtVDData: TDateEdit;
    Label12: TLabel;
    btnConsProdutoSaida: TButton;
    edtDescProdutoSaida: TEdit;
    procedure SairClick(Sender: TObject);
    procedure ProdutoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ComprasClick(Sender: TObject);
    procedure VendasClick(Sender: TObject);
    procedure btnCadProduto_SairClick(Sender: TObject);
    procedure btnCadProduto_GravarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure edtCodProdutoExit(Sender: TObject);
    procedure edtCPProdutoExit(Sender: TObject);
    procedure edtVDProdutoExit(Sender: TObject);
    procedure TabPrincipalChange(Sender: TObject);
    procedure edtCodProdutoEnter(Sender: TObject);
    procedure btnCadProduto_ExcluirClick(Sender: TObject);
    procedure btnMovEntrada_GravarClick(Sender: TObject);
  private
    voConexao : TFDConnection;
    procedure pcdHabilitaTabs(poTabControl: TTabItem);
    procedure pcdLimpaCamposCadProduto;
    function fncValidaData(psData: String): TDateTime;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fprincipal: TFprincipal;

implementation

{$R *.fmx}

uses uCadProduto, uDMPrincipal, uCompras;

procedure TFprincipal.ProdutoClick(Sender: TObject);
begin
pcdHabilitaTabs(TabCadProduto);
end;

procedure TFprincipal.SairClick(Sender: TObject);
begin
Close;
end;

procedure TFprincipal.TabPrincipalChange(Sender: TObject);
var
   vloCadProduto : TCadProduto;
begin
if TabCadProduto.Visible then
   begin
   vloCadProduto := TCadProduto.Create(voConexao);
   try
   vloCadProduto.pro_Empresa := 1;
   edtCodProduto.Text := vloCadProduto.fncConsUltimoProduto.ToString;
   if edtCodProduto.CanFocus then
      edtCodProduto.SetFocus;
   finally
      FreeAndNil(vloCadProduto);
      end;
   end
else if TabCadProduto.Visible then
   begin


   end
else if TabVendas.Visible then
   begin


   end;
end;

procedure TFprincipal.VendasClick(Sender: TObject);
begin
pcdHabilitaTabs(TabVendas);
end;

procedure TFprincipal.btnCadProduto_ExcluirClick(Sender: TObject);
var
  vloCadProduto : TCadProduto;
  vlsMensagem   : String;
begin
vloCadProduto := TCadProduto.Create(voConexao);
vlsMensagem   := '';
try

vloCadProduto.pro_Empresa          := 1;
vloCadProduto.pro_CodProduto       := StrtoInt(edtCodProduto.Text);
vlsMensagem                        := vloCadProduto.Delete;

if Trim(vlsMensagem) <> '' then
   ShowMessage(vlsMensagem);

finally
   FreeAndNil(vloCadProduto);
   pcdLimpaCamposCadProduto;
   end;
end;

procedure TFprincipal.btnCadProduto_GravarClick(Sender: TObject);
var
  vloCadProduto : TCadProduto;
  vlsMensagem   : String;
begin
vloCadProduto := TCadProduto.Create(voConexao);
vlsMensagem   := '';
try

vloCadProduto.pro_Empresa          := 1;
if edtCodProduto.Text <> '' then
   vloCadProduto.pro_CodProduto    := StrtoInt(edtCodProduto.Text)
else
   begin
   ShowMessage('Código do Produto inválido, Verifique!');
   edtCodProduto.SetFocus;
   Abort;
   end;

if edtCodIntProduto.Text <> '' then
   vloCadProduto.pro_CodIntProduto := StrToInt(edtCodIntProduto.Text)
else
   begin
   ShowMessage('Código Interno do Produto inválido, Verifique!');
   edtCodIntProduto.SetFocus;
   Abort;
   end;

if edtDescricaoProduto.Text <> '' then
   vloCadProduto.pro_DescricaoProduto := edtDescricaoProduto.Text
else
   begin
   ShowMessage('Descrição do Produto inválida, Verifique!');
   edtDescricaoProduto.SetFocus;
   Abort;
   end;

if edtProEstoque.Text <> '' then
   vloCadProduto.pro_Estoque       := StrToFloat(edtProEstoque.Text)
else
   begin
   ShowMessage('Estoque Inicial do Produto inválido, Verifique!');
   edtProEstoque.SetFocus;
   Abort;
   end;

vlsMensagem := vloCadProduto.Insert;

if Trim(vlsMensagem) <> '' then
   ShowMessage(vlsMensagem);

finally
   FreeAndNil(vloCadProduto);
   pcdLimpaCamposCadProduto;
   end;
end;

procedure TFprincipal.btnCadProduto_SairClick(Sender: TObject);
begin
pcdHabilitaTabs(nil);
end;

procedure TFprincipal.btnMovEntrada_GravarClick(Sender: TObject);
var
  vloCompras  : TCompras;
  vlsMensagem : String;
begin
vloCompras  := TCompras.Create(voConexao);
vlsMensagem := '';
try

vloCompras.CP_EMPRESA := 1;

if edtCPNumero.Text <> '' then
   vloCompras.CP_NUMERO := StrToInt(edtCPNumero.Text)
else
   begin
   ShowMessage('Código da Compra inválido, Verifique!');
   edtCPNumero.SetFocus;
   Abort;
   end;

if edtCPData.Text <> '' then
   vloCompras.CP_DATA := fncValidaData(edtCPData.Text)
else
   begin
   ShowMessage('Data da Compra inválida, Verifique!');
   edtCPData.SetFocus;
   Abort;
   end;

if edtCPProduto.Text <> '' then
   vloCompras.CP_PRODUTO := StrtoInt(edtCPProduto.Text)
else
   begin
   ShowMessage('Código do Produto inválido, Verifique!');
   edtCPProduto.SetFocus;
   Abort;
   end;

if edtCPQtde.Text <> '' then
   vloCompras.CP_QTDE := StrToFloat(edtCPQtde.Text)
else
   begin
   ShowMessage('Quantidade da Compra inválida, Verifique!');
   edtCPQtde.SetFocus;
   Abort;
   end;

vlsMensagem := vloCompras.Insert;

if Trim(vlsMensagem) <> '' then
   ShowMessage(vlsMensagem);

finally
   FreeAndNil(vloCompras);
   pcdLimpaCamposCadProduto;
   end;
end;

function TFprincipal.fncValidaData(psData: String): TDateTime;
begin
try
Result := StrToDate(psData);
finally
   ShowMessage('Data inválida, Verifique!');
   end;
end;

procedure TFprincipal.ComprasClick(Sender: TObject);
begin
pcdHabilitaTabs(TabCompras);
end;

procedure TFprincipal.edtCodProdutoEnter(Sender: TObject);
begin
pcdLimpaCamposCadProduto;
end;

procedure TFprincipal.edtCodProdutoExit(Sender: TObject);
var
   voQuery       : TFDQuery;
   vloCadProduto : TCadProduto;
begin
if edtCodProduto.Text <> '' then
   begin
   vloCadProduto := TCadProduto.Create(voConexao);
   try
   vloCadProduto.pro_Empresa    := 1;
   vloCadProduto.pro_CodProduto := StrToInt(edtCodProduto.Text);
   voQuery                      := vloCadProduto.fncConsultaProduto;

   if voQuery.IsEmpty then
      begin
      if StrToInt(edtCodProduto.Text) > vloCadProduto.fncConsUltimoProduto then
         begin
         ShowMessage('Não é permitido pular numeração.');
         edtCodProduto.Text := vloCadProduto.fncConsUltimoProduto.ToString;
         Abort;
         end
      else
         begin
         edtCodIntProduto.Text := edtCodProduto.Text;
         btnCadProduto_Gravar.Enabled := True;
         end;
      end
   else
      begin
      edtCodIntProduto.Text    := voQuery.FieldByName('PRO_CODINTPRODUTO').AsString;
      edtDescricaoProduto.Text := voQuery.FieldByName('PRO_DESCRICAOPRODUTO').AsString;
      edtProEstoque.Text       := voQuery.FieldByName('PRO_ESTOQUE').AsString;
      btnCadProduto_Gravar.Enabled  := True;
      btnCadProduto_Excluir.Enabled := True;
      end;

   finally
      FreeAndNil(vloCadProduto);
      FreeAndNil(voQuery);
      end;
   end;
end;

procedure TFprincipal.edtCPProdutoExit(Sender: TObject);
var
  vloCadProduto : TCadProduto;
begin
if Trim(edtCPProduto.Text) <> '' then
   begin
   vloCadProduto := TCadProduto.Create(voConexao);
   try
   vloCadProduto.pro_Empresa    := 1;
   vloCadProduto.pro_CodProduto := StrToInt(edtCPProduto.Text);
   edtDescProdutoEntrada.Text   := vloCadProduto.ConsDescricaoProduto;
   finally
      FreeAndNil(vloCadProduto);
      end;
   end;
end;

procedure TFprincipal.edtVDProdutoExit(Sender: TObject);
var
  vloCadProduto : TCadProduto;
begin
if Trim(edtVDProduto.Text) <> '' then
   begin
   vloCadProduto := TCadProduto.Create(voConexao);
   try
   vloCadProduto.pro_Empresa    := 1;
   vloCadProduto.pro_CodProduto := StrToInt(edtVDProduto.Text);
   edtDescProdutoSaida.Text     := vloCadProduto.ConsDescricaoProduto;
   finally
      FreeAndNil(vloCadProduto);
      end;
   end;
end;

procedure TFprincipal.FormKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
if Key = vkReturn then
    begin
    Key := vkTab;
    KeyDown(Key, KeyChar, Shift);
    end;
end;

procedure TFprincipal.FormShow(Sender: TObject);
begin
pcdHabilitaTabs(nil);
DMPrincipal.FDConnection1.Connected := True;
voConexao := DMPrincipal.FDConnection1;
end;

procedure TFprincipal.pcdHabilitaTabs(poTabControl: TTabItem);
begin
TabCadProduto.Visible := poTabControl = TabCadProduto;
TabCompras.Visible    := poTabControl = TabCompras;
TabVendas.Visible     := poTabControl = TabVendas;

TabPrincipal.Visible  := poTabControl <> nil;

if poTabControl <> nil then
   poTabControl.IsSelected := True;

if TabCadProduto.IsSelected then
   begin
   if edtCodProduto.CanFocus then
      edtCodProduto.SetFocus;
   end
else if TabCompras.IsSelected then
   begin

   end
else if TabVendas.IsSelected then
   begin

   end;

end;

procedure TFprincipal.pcdLimpaCamposCadProduto;
begin
edtDescricaoProduto.Text := '';
edtCodIntProduto.Text    := '';
edtProEstoque.Text       := '';
btnCadProduto_Excluir.Enabled := False;
btnCadProduto_Gravar.Enabled  := False;

TabPrincipalChange(Application);
end;

end.
