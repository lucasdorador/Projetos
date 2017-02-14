unit uControleCheques;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts, FMX.TabControl, FMX.ListView.Types,
  FMX.ListView, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope,
  FMX.DateTimeCtrls, FMX.EditBox, FMX.NumberBox, FMX.Edit, Data.DB, FMX.Objects,
  {$IF DEFINED (ANDROID)} Androidapi.Helpers,{$ENDIF} MultiDetailAppearanceU;

type
  TFControleCheques = class(TForm)
    Layout1: TLayout;
    tbTopo: TToolBar;
    btnDownload: TSpeedButton;
    btnAdicionar: TSpeedButton;
    btnPesquisar: TSpeedButton;
    TabControl1: TTabControl;
    tabConsulta: TTabItem;
    ListView1: TListView;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    tabCadastra: TTabItem;
    btnVoltar: TSpeedButton;
    Label1: TLabel;
    recBanco: TRectangle;
    Label2: TLabel;
    recLancamento: TRectangle;
    Label3: TLabel;
    recValorCheque: TRectangle;
    Label4: TLabel;
    recNumeroCheque: TRectangle;
    Label5: TLabel;
    recContaCorrente: TRectangle;
    Label6: TLabel;
    Layout2: TLayout;
    recCompensacao: TRectangle;
    Label7: TLabel;
    recFornecedor: TRectangle;
    edtBanco: TEdit;
    edtContaCorrente: TEdit;
    edtFornecedor: TEdit;
    edtNumeroCheque: TEdit;
    edtDataLancamento: TDateEdit;
    edtDataCompensacao: TDateEdit;
    LinkControlToField8: TLinkControlToField;
    LinkControlToField9: TLinkControlToField;
    LinkControlToField10: TLinkControlToField;
    LinkControlToField12: TLinkControlToField;
    LinkControlToField13: TLinkControlToField;
    LinkControlToField14: TLinkControlToField;
    BarraRolagemVertical: TVertScrollBox;
    LinkListControlToField1: TLinkListControlToField;
    ClearEditButton1: TClearEditButton;
    ClearEditButton2: TClearEditButton;
    ClearEditButton3: TClearEditButton;
    edtValor: TEdit;
    ClearEditButton4: TClearEditButton;
    Rectangle1: TRectangle;
    LinkControlToField1: TLinkControlToField;
    procedure btnDownloadClick(Sender: TObject);
    procedure ListView1ItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure FormActivate(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure edtNumeroChequeExit(Sender: TObject);
    procedure edtValorExit(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FControleCheques: TFControleCheques;

implementation

{$R *.fmx}
{$R *.NmXhdpiPh.fmx ANDROID}
{$R *.XLgXhdpiTb.fmx ANDROID}
{$R *.SmXhdpiPh.fmx ANDROID}
{$R *.LgXhdpiPh.fmx ANDROID}
{$R *.LgXhdpiTb.fmx ANDROID}

uses udmPrincipal;

procedure TFControleCheques.btnAdicionarClick(Sender: TObject);
begin
if TabControl1.ActiveTab = tabCadastra then
   begin
   if Trim(edtBanco.Text) = '' then
      begin
      ShowMessage('O Banco deve ser preenchido');
      Exit;
      end;

   if Trim(edtContaCorrente.Text) = '' then
      begin
      ShowMessage('A Conta Corrente deve ser preenchida');
      Exit;
      end;

   if Trim(edtNumeroCheque.Text) = '' then
      begin
      ShowMessage('O N�mero do Cheque deve ser preenchido');
      Exit;
      end;

   if edtValor.Text = '' then
      begin
      ShowMessage('O Valor do Cheque deve ser maior que 0 (Zero).');
      Exit;
      end;

   if Trim(edtFornecedor.Text) = '' then
      begin
      ShowMessage('O Fornecedor deve ser preenchido');
      Exit;
      end;

   if ((dmPrincipal.FDConsulta.State = dsEdit) or
       (dmPrincipal.FDConsulta.State = dsInsert)) then
      dmPrincipal.FDConsulta.Post;

   btnDownload.Visible      := True;
   btnVoltar.Visible        := False;
   btnAdicionar.StyleLookup := 'addtoolbutton';
   btnPesquisar.Visible     := True;
   TabControl1.ActiveTab    := tabConsulta;
   end
else if TabControl1.ActiveTab = tabConsulta then
   begin
   dmPrincipal.FDConsulta.Append;
   btnDownload.Visible      := False;
   btnVoltar.Visible        := True;
   btnAdicionar.StyleLookup := 'additembutton';
   btnPesquisar.Visible     := False;
   edtDataLancamento.Date   := Date;
   edtDataCompensacao.Date  := Date;
   TabControl1.ActiveTab    := tabCadastra;
   end;
end;

procedure TFControleCheques.btnDownloadClick(Sender: TObject);
begin
ShowMessage('Download ...');
end;

procedure TFControleCheques.btnPesquisarClick(Sender: TObject);
begin
if btnPesquisar.StyleLookup = 'cleareditbutton' then
   begin
   ListView1.SearchVisible  := False;
   btnPesquisar.StyleLookup := 'searcheditbutton';
   end
else
   begin
   ListView1.SearchVisible  := True;
   btnPesquisar.StyleLookup := 'cleareditbutton';
   end;
end;

procedure TFControleCheques.btnVoltarClick(Sender: TObject);
begin
if ((dmPrincipal.FDConsulta.State = dsEdit) or
    (dmPrincipal.FDConsulta.State = dsInsert)) then
   dmPrincipal.FDConsulta.Cancel;

btnDownload.Visible      := True;
btnVoltar.Visible        := False;
btnAdicionar.StyleLookup := 'addtoolbutton';
btnPesquisar.Visible     := True;
TabControl1.ActiveTab    := tabConsulta;
end;

procedure TFControleCheques.edtNumeroChequeExit(Sender: TObject);
begin
if Trim(edtNumeroCheque.Text) <> '' then
   edtNumeroCheque.Text := FormatFloat('00000000', StrToFloat(edtNumeroCheque.Text));
end;

procedure TFControleCheques.edtValorExit(Sender: TObject);
begin
try
   if Trim(edtValor.Text) <> '' then
      edtValor.Text := FormatFloat(',0.00', StrToFloat(edtValor.Text));
Except
   ShowMessage('Houve um erro na convers�o do Valor, digite apenas n�mero no campo.');
   edtValor.SetFocus;
   end;
end;

procedure TFControleCheques.FormActivate(Sender: TObject);
begin
TabControl1.ActiveTab := tabConsulta;
if not dmPrincipal.FDConsulta.Active then
   dmPrincipal.FDConsulta.Active := True;

end;

procedure TFControleCheques.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
CanClose := False;
MessageDlg('Deseja realmente fechar o Controle de Cheques?',
            System.UITypes.TMsgDlgType.mtInformation,
            [System.UITypes.TMsgDlgBtn.mbYes, System.UITypes.TMsgDlgBtn.mbNo], 0,
procedure(const BotaoPressionado: TModalResult)
   begin
   case BotaoPressionado of
   mrYes:
      begin
      {$IF DEFINED (ANDROID)}
      SharedActivity.Finish;
      {$ENDIF}
      end;
   end;
   end);
end;

procedure TFControleCheques.FormKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
var
  Fechar : Boolean;
begin
  if Key = vkHardwareBack then
      begin
        key := 0;
        FormCloseQuery(Sender, Fechar);
      end;
end;

procedure TFControleCheques.ListView1ItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
dmPrincipal.FDConsulta.Edit;
btnDownload.Visible      := False;
btnVoltar.Visible        := True;
btnAdicionar.StyleLookup := 'additembutton';
btnPesquisar.Visible     := False;
TabControl1.ActiveTab    := tabCadastra;
end;

end.
