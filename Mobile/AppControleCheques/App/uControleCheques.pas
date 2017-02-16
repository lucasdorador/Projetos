unit uControleCheques;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts, FMX.TabControl, FMX.ListView.Types,
  FMX.ListView, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope,
  FMX.DateTimeCtrls, FMX.EditBox, FMX.NumberBox, FMX.Edit, Data.DB, FMX.Objects,
  MultiDetailAppearanceU, FMX.ListBox;

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
    BarraRolagemVertical: TVertScrollBox;
    LinkListControlToField1: TLinkListControlToField;
    Rectangle1: TRectangle;
    recFundoTopo: TRectangle;
    recRightTopo: TRectangle;
    recLeftTopo: TRectangle;
    Label1: TLabel;
    edtBanco: TComboBox;
    Label2: TLabel;
    edtContaCorrente: TComboBox;
    Label3: TLabel;
    recNumeroCheque: TRectangle;
    edtNumeroCheque: TEdit;
    ClearEditButton3: TClearEditButton;
    Label4: TLabel;
    recValorCheque: TRectangle;
    edtValor: TEdit;
    ClearEditButton4: TClearEditButton;
    Label5: TLabel;
    recLancamento: TRectangle;
    edtDataLancamento: TDateEdit;
    Label6: TLabel;
    recCompensacao: TRectangle;
    edtDataCompensacao: TDateEdit;
    Label7: TLabel;
    recFornecedor: TRectangle;
    edtFornecedor: TEdit;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    LinkControlToField5: TLinkControlToField;
    LinkPropertyToFieldDate: TLinkPropertyToField;
    LinkPropertyToFieldDate2: TLinkPropertyToField;
    LinkFillControlToField1: TLinkFillControlToField;
    LinkFillControlToField2: TLinkFillControlToField;
    procedure btnDownloadClick(Sender: TObject);
    procedure ListView1ItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure FormActivate(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure edtNumeroChequeExit(Sender: TObject);
    procedure edtValorExit(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
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

uses udmPrincipal, uPrincipal;

procedure TFControleCheques.btnAdicionarClick(Sender: TObject);
begin
if TabControl1.ActiveTab = tabCadastra then
   begin
   if Trim(edtBanco.Selected.Text) = '' then
      begin
      ShowMessage('O Banco deve ser preenchido');
      Exit;
      end;

   if Trim(edtContaCorrente.Selected.Text) = '' then
      begin
      ShowMessage('A Conta Corrente deve ser preenchida');
      Exit;
      end;

   if Trim(edtNumeroCheque.Text) = '' then
      begin
      ShowMessage('O Número do Cheque deve ser preenchido');
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
   ShowMessage('Houve um erro na conversão do Valor, digite apenas número no campo.');
   edtValor.SetFocus;
   end;
end;

procedure TFControleCheques.FormActivate(Sender: TObject);
begin
TabControl1.ActiveTab := tabConsulta;
if not dmPrincipal.FDConsulta.Active then
   dmPrincipal.FDConsulta.Active := True;

end;

procedure TFControleCheques.FormKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
if Key = vkHardwareBack then
   begin
   if not Assigned(FPrincipal) then
      Application.CreateForm(TFPrincipal, FPrincipal);
   FPrincipal.Show;
   end;
end;

procedure TFControleCheques.FormShow(Sender: TObject);
begin
recRightTopo.Width := Trunc(recFundoTopo.Width / 2);
recLeftTopo.Width  := Trunc(recFundoTopo.Width / 2);
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
