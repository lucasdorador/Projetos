unit uMenuInicial;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.ListView.Types, FMX.ListView, FMX.Controls.Presentation, FMX.StdCtrls,
  udmPrincipal, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope,
  uConstantes, FMX.ListView.Appearances, FMX.ListView.Adapters.Base;

type
  TFMenuInicial = class(TForm)
    ToolBar1: TToolBar;
    ListView1: TListView;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    btnInserir: TButton;
    btnExecutar: TButton;
    btnDeletar: TButton;
    btnEditar: TButton;
    procedure FormShow(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure ListView1ItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExecutarClick(Sender: TObject);
    procedure btnDeletarClick(Sender: TObject);
  private
    ItemClicado : TListViewItem;
    vgSKeyProduto : String;
    procedure pcdGeraJSONItens;
    procedure pcdGravarJSON(poStringList: TStringList);
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

procedure TFMenuInicial.btnDeletarClick(Sender: TObject);
begin
if dmPrincipal.FDConsultaProduto.IsEmpty then
   begin
   ShowMessage('Não é possível excluir, pois não há itens lançados!');
   end
else
   begin
   MessageDlg('Deseja excluir o item ' + dmPrincipal.FDConsultaProdutoDESCRICAO.AsString + ' ?',
      System.UITypes.TMsgDlgType.mtInformation,
      [System.UITypes.TMsgDlgBtn.mbYes, System.UITypes.TMsgDlgBtn.mbNo], 0,
      procedure(const BotaoPressionado: TModalResult)
         begin
            case BotaoPressionado of
            mrYes:
               begin
                  begin
                  dmPrincipal.FDConsultas.Close;
                  dmPrincipal.FDConsultas.SQL.Add('DELETE FROM PRODUTOS WHERE KEY_EMPRESA = :KEY_EMPRESA AND KEY_PRODUTO = :KEY_PRODUTO');
                  dmPrincipal.FDConsultas.ParamByName('KEY_EMPRESA').AsString := dmPrincipal.FDConsultaProdutoKEY_EMPRESA.AsString;
                  dmPrincipal.FDConsultas.ParamByName('KEY_PRODUTO').AsString := dmPrincipal.FDConsultaProdutoKEY_PRODUTO.AsString;
                  dmPrincipal.FDConsultas.ExecSQL;

                  setAtualizarLista;
                  end;
               end;
         end;
      end);
   end;
end;

procedure TFMenuInicial.btnEditarClick(Sender: TObject);
begin
if dmPrincipal.FDConsultaProduto.IsEmpty then
   begin
   ShowMessage('Não é possível editar, pois não há itens lançados!');
   end
else
   begin
   if not Assigned(FPrincipal) then
      Application.CreateForm(TFPrincipal, FPrincipal);

   FPrincipal.setTelaInicial(True, constkey_empresa, vgSKeyProduto);
   FPrincipal.Show;
   end;
end;

procedure TFMenuInicial.btnExecutarClick(Sender: TObject);
begin
if dmPrincipal.FDConsultaProduto.IsEmpty then
   begin
   ShowMessage('Não é possível gerar o arquivo, pois não há itens lançados!');
   end
else
   begin
   pcdGeraJSONItens;
   end;
end;

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
ItemClicado   := AItem;
vgSKeyProduto := ListView1.Items[AItem.Index-1].Text;
end;

procedure TFMenuInicial.setAtualizarLista;
var
   vliRecNo : Integer;
begin
vliRecNo := dmPrincipal.FDConsultaProduto.RecNo;
dmPrincipal.FDConsultaProduto.Close;
dmPrincipal.FDConsultaProduto.Open();
dmPrincipal.FDConsultaProduto.RecNo := vliRecNo;
end;

procedure TFMenuInicial.pcdGeraJSONItens();
var
   vlOStringList : TStringList;
   vlSEspacoInicialProduto,
   vlsEspacoCamposProduto,
   virgulaFinal : String;
   vlICount : Integer;
begin
vlSEspacoInicialProduto := '      ';
vlsEspacoCamposProduto  := '        ';
virgulaFinal            := ',';
vlICount                := 1;
vlOStringList           := TStringList.Create;
try
vlOStringList.Add('{');
vlOStringList.Add('  "cardapio_itens" : {');
vlOStringList.Add('    "-LNIt3Xv5j-bLDcr6p4E" : {');

dmPrincipal.FDConsultaProduto.First;

while not dmPrincipal.FDConsultaProduto.Eof do
   begin
   if vlICount = dmPrincipal.FDConsultaProduto.RecordCount then
      virgulaFinal := '';

   vlOStringList.Add(vlSEspacoInicialProduto + '"' + dmPrincipal.FDConsultaProdutoKEY_PRODUTO.AsString+'" : {');
   vlOStringList.Add(vlsEspacoCamposProduto + '"complemento" : "'+dmPrincipal.FDConsultaProdutoCOMPLEMENTOS.AsString+'",');
   vlOStringList.Add(vlsEspacoCamposProduto + '"descricao" : "'+dmPrincipal.FDConsultaProdutoDESCRICAO.AsString+'",');
   vlOStringList.Add(vlsEspacoCamposProduto + '"grupo" : "'+dmPrincipal.FDConsultaProdutoGRUPO.AsString+'",');
   vlOStringList.Add(vlsEspacoCamposProduto + '"key_empresa" : "'+dmPrincipal.FDConsultaProdutoKEY_EMPRESA.AsString+'",');
   vlOStringList.Add(vlsEspacoCamposProduto + '"key_produto" : "'+dmPrincipal.FDConsultaProdutoKEY_PRODUTO.AsString+'",');
   vlOStringList.Add(vlsEspacoCamposProduto + '"valor_inteira" : "'+dmPrincipal.FDConsultaProdutoVALOR_INTEIRA.AsString+'",');
   vlOStringList.Add(vlsEspacoCamposProduto + '"valor_meia" : "'+dmPrincipal.FDConsultaProdutoVALOR_MEIA.AsString+'"');
   vlOStringList.Add(vlSEspacoInicialProduto+'}'+virgulaFinal);
   Inc(vlICount);

   dmPrincipal.FDConsultaProduto.Next;
   end;

vlOStringList.Add('    }');
vlOStringList.Add('  }');
vlOStringList.Add('}');
pcdGravarJSON(vlOStringList);

finally
   FreeAndNil(vlOStringList);
   end;
end;

procedure TFMenuInicial.pcdGravarJSON(poStringList: TStringList);
begin

if not DirectoryExists(System.SysUtils.GetCurrentDir+'\JSON_Itens') then
   ForceDirectories(System.SysUtils.GetCurrentDir+'\JSON_Itens');

poStringList.SaveToFile(System.SysUtils.GetCurrentDir + '\JSON_Itens\cardapio_itens_'+FormatDateTime('ddmmYYYY', Now)+'.json');
end;



end.
