unit uPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.ListView.Types, FMX.ListView, FMX.StdCtrls, FMX.Controls.Presentation,
  FMX.TabControl, FMX.Edit, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components,
  Data.Bind.DBScope, Data.DB;

type
  TFPrincipal = class(TForm)
    tabPrincipal: TTabControl;
    tabListagem: TTabItem;
    tabCadastro: TTabItem;
    ToolBar1: TToolBar;
    btnDownload: TSpeedButton;
    btnUpload: TSpeedButton;
    btnIncluir: TSpeedButton;
    lsvProdutos: TListView;
    ToolBar2: TToolBar;
    btnVoltar: TSpeedButton;
    btnExcluir: TSpeedButton;
    btnSalvar: TSpeedButton;
    lblCodigo: TLabel;
    edtCodigo: TEdit;
    lblNome: TLabel;
    edtNome: TEdit;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    procedure lsvProdutosItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FPrincipal: TFPrincipal;

implementation

{$R *.fmx}

uses udmAcessoDados;

procedure TFPrincipal.btnExcluirClick(Sender: TObject);
begin
dmAcessoDados.qryProdutos.Delete;
tabPrincipal.ActiveTab := tabListagem;
end;

procedure TFPrincipal.btnIncluirClick(Sender: TObject);
begin
dmAcessoDados.qryProdutos.Append;
tabPrincipal.ActiveTab := tabCadastro;
end;

procedure TFPrincipal.btnSalvarClick(Sender: TObject);
begin
if Trim(edtCodigo.Text) = '' then
   begin
   ShowMessage('O código deve ser preenchido');
   Exit;
   end;

if Trim(edtNome.Text) = '' then
   begin
   ShowMessage('O nome deve ser preenchido');
   Exit;
   end;

if dmAcessoDados.qryProdutos.State = dsEdit then
   dmAcessoDados.qryProdutos.Post;

tabPrincipal.ActiveTab := tabListagem;
end;

procedure TFPrincipal.btnVoltarClick(Sender: TObject);
begin
if dmAcessoDados.qryProdutos.State = dsEdit then
   dmAcessoDados.qryProdutos.Cancel;

tabPrincipal.ActiveTab := tabListagem;
end;

procedure TFPrincipal.FormActivate(Sender: TObject);
begin
tabPrincipal.ActiveTab := tabListagem;
end;

procedure TFPrincipal.lsvProdutosItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
dmAcessoDados.qryProdutos.Edit;
tabPrincipal.ActiveTab := tabCadastro;
end;

end.
