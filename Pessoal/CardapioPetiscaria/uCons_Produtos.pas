unit uCons_Produtos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls;

type
  TFCons_Produtos = class(TForm)
    GroupBox1: TGroupBox;
    edtcons_Produto: TEdit;
    DBCons_Produtos: TDBGrid;
    procedure DBCons_ProdutosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBCons_ProdutosDblClick(Sender: TObject);
    procedure edtcons_ProdutoEnter(Sender: TObject);
    procedure edtcons_ProdutoExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FCons_Produtos: TFCons_Produtos;

implementation

{$R *.dfm}

uses DMPrincipal, uCadastroCardapio;

procedure TFCons_Produtos.DBCons_ProdutosDblClick(Sender: TObject);
begin
Close;
end;

procedure TFCons_Produtos.DBCons_ProdutosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Key = VK_RETURN then
   Close;
end;

procedure TFCons_Produtos.edtcons_ProdutoEnter(Sender: TObject);
begin
DBCons_Produtos.DataSource.DataSet.Filtered := False;
end;

procedure TFCons_Produtos.edtcons_ProdutoExit(Sender: TObject);
begin
if Trim(edtcons_Produto.Text) <> '' then
   begin
   DBCons_Produtos.DataSource.DataSet.Filtered := False;
   DBCons_Produtos.DataSource.DataSet.Filter   := 'PRO_DESCRICAO LIKE ' + QuotedStr('%'+edtcons_Produto.Text+'%');
   DBCons_Produtos.DataSource.DataSet.Filtered := True;
   end
else
   begin
   DBCons_Produtos.DataSource.DataSet.Filtered := False;
   end;
end;

procedure TFCons_Produtos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
FCadastroCardapio.vgiCodProduto            := DBCons_Produtos.DataSource.DataSet.FieldByName('PRO_CODIGO').AsInteger;
FCadastroCardapio.edtDescricaoProduto.Text := DBCons_Produtos.DataSource.DataSet.FieldByName('PRO_DESCRICAO').AsString;
FCadastroCardapio.edtValorInteira.Value    := DBCons_Produtos.DataSource.DataSet.FieldByName('PRO_VALORINTEIRA').AsFloat;
FCadastroCardapio.edtValorMeia.Value       := DBCons_Produtos.DataSource.DataSet.FieldByName('PRO_VALORMEIA').AsFloat;
FCadastroCardapio.edtCodGrupo.Text         := DBCons_Produtos.DataSource.DataSet.FieldByName('PRO_GRUPO').AsString;
end;

procedure TFCons_Produtos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
case Key of
   VK_ESCAPE : Close;
   end;
end;

procedure TFCons_Produtos.FormKeyPress(Sender: TObject; var Key: Char);
begin
if Key = #13 then
   begin
   Perform(Wm_NextDlgCtl,0,0);
   Key := #0;
   end
end;

procedure TFCons_Produtos.FormShow(Sender: TObject);
begin
DMPrinc.FDCons_Produto.Open();

TFloatField(DMPrinc.FDCons_Produto.FieldByName('PRO_VALORINTEIRA')).DisplayFormat := ',0.00';
DMPrinc.FDCons_Produto.FieldByName('PRO_VALORINTEIRA').EditMask := ',0.00';

TFloatField(DMPrinc.FDCons_Produto.FieldByName('PRO_VALORMEIA')).DisplayFormat := ',0.00';
DMPrinc.FDCons_Produto.FieldByName('PRO_VALORMEIA').EditMask := ',0.00';

DMPrinc.FDCons_Produto.Refresh;

if edtcons_Produto.CanFocus then
   edtcons_Produto.SetFocus;
end;

end.
