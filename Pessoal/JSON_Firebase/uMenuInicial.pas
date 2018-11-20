unit uMenuInicial;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.ListView.Types, FMX.ListView, FMX.Controls.Presentation, FMX.StdCtrls,
  udmPrincipal, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope,
  uConstantes;

type
  TFMenuInicial = class(TForm)
    ToolBar1: TToolBar;
    ListView1: TListView;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    btnInserir: TButton;
    btnDeletar: TButton;
    procedure FormShow(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure ListView1ItemClick(const Sender: TObject;
      const AItem: TListViewItem);
  private
    ItemClicado : TListViewItem;
    { Private declarations }
  public
    procedure setAtualizarLista();
    { Public declarations }
  end;

var
  FMenuInicial: TFMenuInicial;

implementation

uses
   uPrincipal;

{$R *.fmx}

procedure TFMenuInicial.btnInserirClick(Sender: TObject);
begin
if not Assigned(FPrincipal) then
   Application.CreateForm(TFPrincipal, FPrincipal);

FPrincipal.setTelaInicial(False, constkey_empresa, '');
FPrincipal.Show;
end;

procedure TFMenuInicial.FormShow(Sender: TObject);
begin
setAtualizarLista;
end;

procedure TFMenuInicial.ListView1ItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
ItemClicado := AItem;
end;

procedure TFMenuInicial.setAtualizarLista;
begin
dmPrincipal.FDConsultaProduto.Close;
dmPrincipal.FDConsultaProduto.Open();
end;

end.
