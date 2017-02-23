unit uControleCheques;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts, FMX.TabControl, FMX.ListView.Types,
  FMX.ListView, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope,
  FMX.DateTimeCtrls, FMX.EditBox, FMX.NumberBox, FMX.Edit, Data.DB, FMX.Objects,
  MultiDetailAppearanceU, FMX.ListBox, {$IF DEFINED (ANDROID)} Androidapi.Helpers, {$ENDIF}
  FMX.Ani, FGX.ProgressDialog;

type
  TFControleCheques = class(TForm)
    Layout1: TLayout;
    tbTopo: TToolBar;
    btnAdicionar: TSpeedButton;
    btnPesquisar: TSpeedButton;
    TabControl1: TTabControl;
    tabConsulta: TTabItem;
    ListView1: TListView;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    tabCadastra: TTabItem;
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
    ClearEditButton1: TClearEditButton;
    btnVoltar: TSpeedButton;
    btnDownload: TSpeedButton;
    btnExcluir: TSpeedButton;
    Rectangle2: TRectangle;
    Rectangle3: TRectangle;
    Rectangle4: TRectangle;
    fgActivityDialog: TfgActivityDialog;
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
    procedure FormVirtualKeyboardHidden(Sender: TObject;
      KeyboardVisible: Boolean; const Bounds: TRect);
    procedure FormVirtualKeyboardShown(Sender: TObject;
      KeyboardVisible: Boolean; const Bounds: TRect);
    procedure edtValorEnter(Sender: TObject);
    procedure ListView1DeleteItem(Sender: TObject; AIndex: Integer);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
    FTecladoShow : Boolean;
    procedure pcdAlternaBotoes(poTabItem: TTabItem);
  public
    { Public declarations }
  end;

var
  FControleCheques: TFControleCheques;

implementation

{$R *.fmx}
{$R *.NmXhdpiPh.fmx ANDROID}

uses udmPrincipal, uPrincipal, uComunicaServer;

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


   pcdAlternaBotoes(tabConsulta);
   TabControl1.ActiveTab := tabConsulta;
   end
else if TabControl1.ActiveTab = tabConsulta then
   begin
   dmPrincipal.FDConsulta.Append;
   pcdAlternaBotoes(tabCadastra);
   TabControl1.ActiveTab := tabCadastra;
   end;
end;

procedure TFControleCheques.btnDownloadClick(Sender: TObject);
var
   vlServico : TComunicaServer;
begin
vlServico := TComunicaServer.Create;
try
if vlServico.fncValidaConexaoServidorSemMsg then
   begin
   vlServico.vloProgresso := fgActivityDialog;
   vlServico.getListaCheques;
   end
else
   begin
   Showmessage('Não foi possível comunicar com o servidor por favor verifique. Erro: ' + vlServico.vlsMensagemErro);
   end;

finally
   FreeAndNil(vlServico);
   fgActivityDialog.Hide;
   end;
end;

procedure TFControleCheques.btnExcluirClick(Sender: TObject);
begin
if ((dmPrincipal.FDConsulta.State <> dsEdit) or
    (dmPrincipal.FDConsulta.State <> dsInsert)) then
    dmPrincipal.FDConsulta.Edit;

dmPrincipal.FDConsulta.Delete;
if dmPrincipal.FDConsulta.ApplyUpdates > 0 then
   dmPrincipal.FDConsulta.CancelUpdates;
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
if TabControl1.ActiveTab = tabCadastra then
   begin
   if ((dmPrincipal.FDConsulta.State = dsEdit) or
       (dmPrincipal.FDConsulta.State = dsInsert)) then
      dmPrincipal.FDConsulta.Cancel;

   pcdAlternaBotoes(tabConsulta);
   TabControl1.ActiveTab := tabConsulta;
   end
else
   begin
   if not Assigned(FPrincipal) then
      Application.CreateForm(TFPrincipal, FPrincipal);
   FPrincipal.Show;
   end;
end;

procedure TFControleCheques.edtNumeroChequeExit(Sender: TObject);
begin
if Trim(edtNumeroCheque.Text) <> '' then
   edtNumeroCheque.Text := FormatFloat('00000000', StrToFloat(edtNumeroCheque.Text));
end;

procedure TFControleCheques.edtValorEnter(Sender: TObject);
begin
if edtDataLancamento.Date = 0then
   edtDataLancamento.Date := Date;

if edtDataCompensacao.Date = 0 then
   edtDataCompensacao.Date := Date;
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
pcdAlternaBotoes(tabConsulta);
TabControl1.ActiveTab := tabConsulta;
if not dmPrincipal.FDConsulta.Active then
   dmPrincipal.FDConsulta.Active := True;

end;

procedure TFControleCheques.FormKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
var
   vloRect : TRect;
begin
if (Key = vkHardwareBack) then
   begin
   if (TabControl1.ActiveTab = tabCadastra) then
      FormVirtualKeyboardHidden(Sender, False, vloRect)
   else
      begin
      if not Assigned(FPrincipal) then
         Application.CreateForm(TFPrincipal, FPrincipal);
      FPrincipal.Show;
      end;
   end;
end;

procedure TFControleCheques.FormShow(Sender: TObject);
begin
recRightTopo.Width       := Trunc(recFundoTopo.Width / 2);
recLeftTopo.Width        := Trunc(recFundoTopo.Width / 2);
btnAdicionar.StyleLookup := 'addtoolbutton';
btnVoltar.Visible        := True;
end;

procedure TFControleCheques.FormVirtualKeyboardHidden(Sender: TObject;
  KeyboardVisible: Boolean; const Bounds: TRect);
begin
FTecladoShow := false;
if not KeyboardVisible then
   AnimateFloat('Padding.Top', 0, 0.1);
end;

procedure TFControleCheques.FormVirtualKeyboardShown(Sender: TObject;
  KeyboardVisible: Boolean; const Bounds: TRect);
var
     O: TFMXObject;
begin
FTecladoShow := true;
if Assigned(Focused) and (Focused.GetObject is TControl) then
   if TControl(Focused).AbsoluteRect.Bottom - Padding.Top >= (Bounds.Top - tbTopo.Height) then
      begin
           //If switching between controls, the KeyboardHidden animation will run first
           //and we'll see the form scroll up and then down.
           //Calling StopPropertyAnimation jumps the first animation to it's final value - same problem
           //Instead we need to search for the other animation and call StopAtCurrent.
      for O in Children do
          if (O is TFloatAnimation) and (TFloatAnimation(O).PropertyName = 'Padding.Top') then
             TFloatAnimation(O).StopAtCurrent;

      //AnimateFloat
      AnimateFloat('Padding.Top',Bounds.Top - tbTopo.Height - TControl(Focused).AbsoluteRect.Bottom + Padding.Top, 0.1)
      end
   else
else
   AnimateFloat('Padding.Top', 0, 0.1);
end;

procedure TFControleCheques.ListView1DeleteItem(Sender: TObject;
  AIndex: Integer);
begin
MessageDlg('Deseja realmente fechar o Controle de Cheques?',
            System.UITypes.TMsgDlgType.mtInformation,
            [System.UITypes.TMsgDlgBtn.mbYes, System.UITypes.TMsgDlgBtn.mbNo], 0,
procedure(const BotaoPressionado: TModalResult)
   begin
   case BotaoPressionado of
     mrYes:
      begin
      dmPrincipal.FDConsulta.Delete;
      end;
      end;
   end);
end;

procedure TFControleCheques.ListView1ItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
dmPrincipal.FDConsulta.Edit;
pcdAlternaBotoes(tabCadastra);
TabControl1.ActiveTab := tabCadastra;
end;

procedure TFControleCheques.pcdAlternaBotoes(poTabItem : TTabItem);
begin
if poTabItem = tabConsulta then
   begin
   btnAdicionar.Visible     := True;
   btnPesquisar.Visible     := True;
   btnVoltar.Visible        := True;
   btnDownload.Visible      := True;
   btnExcluir.Visible       := False;
   btnAdicionar.StyleLookup := 'addtoolbutton';
   end
else if poTabItem = tabCadastra then
   begin
   btnAdicionar.Visible     := True;
   btnPesquisar.Visible     := False;
   btnVoltar.Visible        := True;
   btnDownload.Visible      := False;
   btnExcluir.Visible       := True;
   btnAdicionar.StyleLookup := 'donetoolbutton';
   end;
end;

end.
