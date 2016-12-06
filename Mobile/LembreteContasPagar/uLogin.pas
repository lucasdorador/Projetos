unit uLogin;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit, FMX.ListBox,
  FMX.Ani, FireDac.Comp.Client;

type
  TFLogin = class(TForm)
    LayoutCliente: TLayout;
    Rectangle1: TRectangle;
    ToolBar1: TToolBar;
    Rectangle2: TRectangle;
    Layout2: TLayout;
    Layout3: TLayout;
    edtSenha: TEdit;
    Rectangle3: TRectangle;
    Label1: TLabel;
    Rectangle4: TRectangle;
    btnAdicionarUsuario: TSpeedButton;
    Rectangle5: TRectangle;
    Layout1: TLayout;
    cbUsuario: TComboBox;
    FloatAnimation1: TFloatAnimation;
    procedure Label1Click(Sender: TObject);
    procedure Rectangle3Click(Sender: TObject);
    procedure btnAdicionarUsuarioClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormVirtualKeyboardShown(Sender: TObject;
      KeyboardVisible: Boolean; const Bounds: TRect);
    procedure FormVirtualKeyboardHidden(Sender: TObject;
      KeyboardVisible: Boolean; const Bounds: TRect);
  private

    { Private declarations }
    FTecladoShow : Boolean;
  public
    FActiveForm : TForm;
    procedure AbrirForm(vForm: TComponentClass);
    { Public declarations }
  end;

var
  FLogin: TFLogin;

implementation

{$R *.fmx}

uses uPrincipal, uDMPrincipal, uCadastraUsuario, uAtualizacao, uCRUDUsuario,
  uSplash;


procedure TFLogin.btnAdicionarUsuarioClick(Sender: TObject);
begin
AbrirForm(TFCadastraUsuario);
end;

procedure TFLogin.FormShow(Sender: TObject);
var
   vloAtualizacao : TAtualizacao;
begin
if Assigned(FSplash) then
   FreeAndNil(FSplash);

vloAtualizacao := TAtualizacao.Create;
try
DMPrincipal.FDConnection1.Connected := True;

try
vloAtualizacao.fncCarregaUsuarios(cbUsuario);
finally
   FreeAndNil(vloAtualizacao);
   end;

except
   on e : Exception do
      begin
      ShowMessage('Erro: ' + e.Message);
      end;
   end;
end;

procedure TFLogin.FormVirtualKeyboardHidden(Sender: TObject;
  KeyboardVisible: Boolean; const Bounds: TRect);
begin
FTecladoShow := false;
if not KeyboardVisible then
   AnimateFloat('Padding.Top', 0, 0.1);
end;

procedure TFLogin.FormVirtualKeyboardShown(Sender: TObject;
  KeyboardVisible: Boolean; const Bounds: TRect);
var
     O: TFMXObject;
begin
FTecladoShow := true;
if Assigned(Focused) and (Focused.GetObject is TControl) then
   if TControl(Focused).AbsoluteRect.Bottom - Padding.Top >= (Bounds.Top - ToolBar1.Height) then
      begin
           //If switching between controls, the KeyboardHidden animation will run first
           //and we'll see the form scroll up and then down.
           //Calling StopPropertyAnimation jumps the first animation to it's final value - same problem
           //Instead we need to search for the other animation and call StopAtCurrent.
      for O in Children do
          if (O is TFloatAnimation) and (TFloatAnimation(O).PropertyName = 'Padding.Top') then
             TFloatAnimation(O).StopAtCurrent;

      //AnimateFloat
      AnimateFloat('Padding.Top',Bounds.Top - ToolBar1.Height - TControl(Focused).AbsoluteRect.Bottom + Padding.Top, 0.1)
      end
   else
else
   AnimateFloat('Padding.Top', 0, 0.1);
end;

procedure TFLogin.Label1Click(Sender: TObject);
begin
Rectangle3Click(Sender);
end;

procedure TFLogin.Rectangle3Click(Sender: TObject);
var
   vloCRUD : TCRUDUsuario;
   vloMenTable : TFDMemTable;
begin
vloCRUD     := TCRUDUsuario.Create;
vloMenTable := TFDMemTable.Create(nil);
try
Application.CreateForm(TFprincipal, Fprincipal);
Fprincipal.vgUsuario := cbUsuario.Items[cbUsuario.ItemIndex];
vloCRUD.Usua_Nome    := Fprincipal.vgUsuario;
vloMenTable          := vloCRUD.BuscarDados;
Fprincipal.vgEmail   := vloMenTable.FieldByName('Usua_Email').AsString;
Fprincipal.vgFoto    := vloMenTable.FieldByName('Usua_Imagem').AsString;
Fprincipal.Show;
finally
   FreeAndNil(vloCRUD);
   end;
end;

procedure TFLogin.AbrirForm(vForm: TComponentClass);
var
   vli : Integer;
begin
if (FActiveForm = nil) or (Assigned(FActiveForm) and
   (FActiveForm.ClassName <> vForm.ClassName)) then
   begin
   for vli := LayoutCliente.ControlsCount -1 downto 0 do
      LayoutCliente.RemoveObject(LayoutCliente.Controls[vli]);

   FActiveForm.DisposeOf;
   FActiveForm := nil;

   Application.CreateForm(vForm, FActiveForm);
   LayoutCliente.AddObject(TLayout(FActiveForm.FindComponent('LayoutCliente')));
   end;
end;

end.
