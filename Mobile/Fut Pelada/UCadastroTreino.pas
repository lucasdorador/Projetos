unit UCadastroTreino;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit, FMX.ListBox,
  System.ImageList, FMX.ImgList, FMX.MediaLibrary.Actions, System.Actions,
  FMX.ActnList, FMX.StdActns;

type
  TFCadastroTreino = class(TForm)
    Layout1: TLayout;
    ToolBar1: TToolBar;
    Rectangle2: TRectangle;
    spGravar: TSpeedButton;
    spCancelar: TSpeedButton;
    spVoltar: TSpeedButton;
    Rectangle1: TRectangle;
    LayDescricao: TLayout;
    LayLocal: TLayout;
    LayModalidade: TLayout;
    LayEquipe: TLayout;
    LayImagem: TLayout;
    edtLocal: TEdit;
    edtDescricao: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    cbModalidade: TComboBox;
    Label3: TLabel;
    Label4: TLabel;
    edtQtdeJogador: TEdit;
    Image1: TImage;
    btnImagem: TButton;
    lstPopUp: TListBox;
    ListBoxGroupHeader1: TListBoxGroupHeader;
    ListBoxItem1: TListBoxItem;
    ListBoxItem2: TListBoxItem;
    Line1: TLine;
    Line2: TLine;
    ImageList1: TImageList;
    ActionList1: TActionList;
    actSelFotoDaBiblioteca: TTakePhotoFromLibraryAction;
    actSelFotoDaCamera: TTakePhotoFromCameraAction;
    ListBoxItem3: TListBoxItem;
    Line3: TLine;
    procedure cbModalidadeChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnImagemClick(Sender: TObject);
    procedure Line2Click(Sender: TObject);
    procedure Line3Click(Sender: TObject);
    procedure ListBoxItem3Click(Sender: TObject);
    procedure actSelFotoDaBibliotecaDidFinishTaking(Image: TBitmap);
    procedure actSelFotoDaCameraDidFinishTaking(Image: TBitmap);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FCadastroTreino: TFCadastroTreino;

implementation

{$R *.fmx}
{$R *.NmXhdpiPh.fmx ANDROID}
{$R *.XLgXhdpiTb.fmx ANDROID}
{$R *.iPhone55in.fmx IOS}
{$R *.SmXhdpiPh.fmx ANDROID}

procedure TFCadastroTreino.actSelFotoDaBibliotecaDidFinishTaking(
  Image: TBitmap);
begin
Image1.Bitmap.Assign(Image);
end;

procedure TFCadastroTreino.actSelFotoDaCameraDidFinishTaking(Image: TBitmap);
begin
Image1.Bitmap.Assign(Image);
end;

procedure TFCadastroTreino.btnImagemClick(Sender: TObject);
begin
lstPopUp.Visible := True;
lstPopUp.BringToFront;
end;

procedure TFCadastroTreino.cbModalidadeChange(Sender: TObject);
begin
if cbModalidade.ItemIndex = 0 then
   edtQtdeJogador.Text := '11'
else if cbModalidade.ItemIndex = 1 then
   edtQtdeJogador.Text := '8'
else if cbModalidade.ItemIndex = 2 then
   edtQtdeJogador.Text := '5'
else if cbModalidade.ItemIndex = 3 then
   edtQtdeJogador.Text := '5'
else if cbModalidade.ItemIndex = 4 then
   edtQtdeJogador.Text := '7'
else
   edtQtdeJogador.Text := '';
end;

procedure TFCadastroTreino.FormShow(Sender: TObject);
begin
if cbModalidade.Items.Count < 1 then
   begin
   cbModalidade.Items.Add('Futebol');
   cbModalidade.Items.Add('Futebol Society');
   cbModalidade.Items.Add('Futsal');
   cbModalidade.Items.Add('Basqeute');
   cbModalidade.Items.Add('Handebol');
   end;
end;

procedure TFCadastroTreino.Line2Click(Sender: TObject);
begin
lstPopUp.Visible := False;
actSelFotoDaCamera.ExecuteTarget(Sender);
end;

procedure TFCadastroTreino.Line3Click(Sender: TObject);
begin
lstPopUp.Visible := False;
actSelFotoDaBiblioteca.ExecuteTarget(Sender);
end;

procedure TFCadastroTreino.ListBoxItem3Click(Sender: TObject);
begin
lstPopUp.Visible := False;
end;

end.
