unit uCadastraUsuario;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.Edit, FMX.ListBox,
  FMX.MediaLibrary.Actions, System.Actions, FMX.ActnList, FMX.StdActns,
  System.ImageList, FMX.ImgList, FMX.Ani, System.IOUtils;

type
  TFCadastraUsuario = class(TForm)
    LayoutCliente: TLayout;
    ToolBar1: TToolBar;
    Rectangle1: TRectangle;
    SpeedButton1: TSpeedButton;
    Rectangle2: TRectangle;
    GridPanelLayout1: TGridPanelLayout;
    Rectangle3: TRectangle;
    Image1: TImage;
    Rectangle4: TRectangle;
    Label1: TLabel;
    Rectangle5: TRectangle;
    Label2: TLabel;
    Rectangle6: TRectangle;
    Label3: TLabel;
    Rectangle7: TRectangle;
    SpeedButton2: TSpeedButton;
    Rectangle8: TRectangle;
    edtUsuario: TEdit;
    edtSenha: TEdit;
    edtEmail: TEdit;
    lstPopup: TListBox;
    ActionList1: TActionList;
    actSelFotoDaBiblioteca: TTakePhotoFromLibraryAction;
    actSelFotoDaCamera: TTakePhotoFromCameraAction;
    lsItemCamera: TListBoxItem;
    lstitemBiblioteca: TListBoxItem;
    ListBoxItem3: TListBoxItem;
    lstitemCancelar: TListBoxItem;
    ImageList1: TImageList;
    procedure SpeedButton1Click(Sender: TObject);
    procedure actSelFotoDaBibliotecaDidFinishTaking(Image: TBitmap);
    procedure actSelFotoDaCameraDidFinishTaking(Image: TBitmap);
    procedure lsItemCameraClick(Sender: TObject);
    procedure lstitemBibliotecaClick(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure lstitemCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormVirtualKeyboardShown(Sender: TObject;
      KeyboardVisible: Boolean; const Bounds: TRect);
    procedure FormVirtualKeyboardHidden(Sender: TObject;
      KeyboardVisible: Boolean; const Bounds: TRect);
    procedure SpeedButton2Click(Sender: TObject);
  private
    { Private declarations }
    FTecladoShow : Boolean;
    procedure HidePopup;
    procedure ShowPopup;
  public
    { Public declarations }
  end;

var
  FCadastraUsuario: TFCadastraUsuario;

implementation

{$R *.fmx}
{$R *.NmXhdpiPh.fmx ANDROID}

uses uLogin, uCRUDUsuario, uDMPrincipal;


procedure TFCadastraUsuario.actSelFotoDaBibliotecaDidFinishTaking(
  Image: TBitmap);
begin
Image1.Bitmap.Assign(Image);
end;

procedure TFCadastraUsuario.actSelFotoDaCameraDidFinishTaking(Image: TBitmap);
begin
Image1.Bitmap.Assign(Image);
end;

procedure TFCadastraUsuario.FormCreate(Sender: TObject);
begin
lstPopUp.Visible := False;
end;

procedure TFCadastraUsuario.FormVirtualKeyboardHidden(Sender: TObject;
  KeyboardVisible: Boolean; const Bounds: TRect);
begin
FTecladoShow := false;
if not KeyboardVisible then
   AnimateFloat('Padding.Top', 0, 0.1);
end;

procedure TFCadastraUsuario.FormVirtualKeyboardShown(Sender: TObject;
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

procedure TFCadastraUsuario.lsItemCameraClick(Sender: TObject);
begin
HidePopup;
actSelFotoDaCamera.ExecuteTarget(Sender);
end;

procedure TFCadastraUsuario.lstitemBibliotecaClick(Sender: TObject);
begin
HidePopup;
actSelFotoDaBiblioteca.ExecuteTarget(Sender);
end;

procedure TFCadastraUsuario.lstitemCancelarClick(Sender: TObject);
begin
HidePopup;
end;

procedure TFCadastraUsuario.SpeedButton1Click(Sender: TObject);
begin
FLogin.AbrirForm(TFLogin);
end;

procedure TFCadastraUsuario.SpeedButton2Click(Sender: TObject);
var
   vloCRUDUsuaio : TCRUDUsuario;
begin
vloCRUDUsuaio := TCRUDUsuario.Create;
try
vloCRUDUsuaio.Usua_Nome   := edtUsuario.Text;
vloCRUDUsuaio.Usua_Email  := edtEmail.Text;
vloCRUDUsuaio.Usua_Imagem := '';
vloCRUDUsuaio.Usua_Senha  := edtSenha.Text;
if not vloCRUDUsuaio.GravarDados then
   ShowMessage('Houve um erro para Grava o Usuário.')
else
   begin
   edtUsuario.Text := '';
   edtEmail.Text   := '';
   edtSenha.Text   := '';
   ShowMessage('Usuário Salvo com sucesso!');
   FLogin.AbrirForm(TFLogin);
   end;
finally
   FreeAndNil(vloCRUDUsuaio);
   end;
end;

procedure TFCadastraUsuario.HidePopup;
begin
  lstPopUp.AnimateFloat('position.y', lstPopUp.Height * -1);
  lstPopUp.Visible := False;
end;

procedure TFCadastraUsuario.Image1Click(Sender: TObject);
begin
ShowPopup;
end;

procedure TFCadastraUsuario.ShowPopup;
begin
  lstPopUp.Visible := True;
  lstPopUp.AnimateFloat('position.y', lstPopup.Width - 70);
  lstPopUp.BringToFront;
end;

end.
