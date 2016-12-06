unit UPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.MultiView,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.Objects, System.IOUtils;

type
  TFPrincipal = class(TForm)
    Layout1: TLayout;
    ToolBar1: TToolBar;
    MultiView1: TMultiView;
    btnMenu: TSpeedButton;
    RecTopMultiView: TRectangle;
    Rectangle2: TRectangle;
    Rectangle3: TRectangle;
    Layout2: TLayout;
    RecNovoTreino: TRectangle;
    ImgNovoTreino: TImage;
    lblNovoTreino: TLabel;
    RecLogout: TRectangle;
    ImgLogout: TImage;
    lblLogout: TLabel;
    RecConfiguracao: TRectangle;
    ImgConfiguracao: TImage;
    lblConfiguracao: TLabel;
    VertScrollBox1: TVertScrollBox;
    procedure RecNovoTreinoClick(Sender: TObject);
    procedure ImgNovoTreinoClick(Sender: TObject);
    procedure lblNovoTreinoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure CriarRetangulo(CaptionLabel: String);
  end;

var
  FPrincipal: TFPrincipal;

implementation

{$R *.fmx}

uses UCadastroTreino;
{$R *.NmXhdpiPh.fmx ANDROID}
{$R *.Surface.fmx MSWINDOWS}

procedure TFPrincipal.ImgNovoTreinoClick(Sender: TObject);
begin
lblNovoTreinoClick(Sender);
end;

procedure TFPrincipal.lblNovoTreinoClick(Sender: TObject);
begin
if not Assigned(FCadastroTreino) then
   Application.CreateForm(TFCadastroTreino, FCadastroTreino);
FCadastroTreino.Show;
end;

procedure TFPrincipal.RecNovoTreinoClick(Sender: TObject);
begin
lblNovoTreinoClick(Sender);
end;

procedure TFPrincipal.CriarRetangulo(CaptionLabel: String);
var
   Retangulos : TRectangle;
   Labels     : TLabel;
   Imagem     : TImage;
begin
Retangulos := TRectangle.Create(nil);
Retangulos.Parent         := VertScrollBox1;
Retangulos.Name           := 'Retangulo1';
Retangulos.Align          := TAlignLayout.Top;
Retangulos.Margins.Right  := 5;
Retangulos.Margins.Left   := 5;
Retangulos.Margins.Bottom := 5;
Retangulos.Margins.Top    := 5;
Retangulos.Height         := 80;
Retangulos.Fill.Color     := $FF6F7E75;//TAlphaColors.Blue;

Imagem := TImage.Create(nil);
Imagem.Parent         := Retangulos;
Imagem.Name           := 'Imagem1';
Imagem.Align          := TAlignLayout.Left;
Imagem.Margins.Right  := 5;
Imagem.Margins.Left   := 10;
Imagem.Margins.Bottom := 10;
Imagem.Margins.Top    := 10;
Imagem.MultiResBitmap[0].Bitmap.LoadFromFile(TPath.Combine(TPath.GetSharedDocumentsPath,'Imagem.png'));
Imagem.MultiResBitmap[0].Scale := 1;
Imagem.Width          := 70;
Imagem.Height         := 60;
Imagem.WrapMode       := TImageWrapMode.Stretch;
Imagem.MarginWrapMode := TImageWrapMode.Stretch;

Labels := TLabel.Create(nil);
Labels.Parent         := Retangulos;
Labels.Name           := 'Label1';
Labels.Align          := TAlignLayout.Client;
Labels.Margins.Right  := 5;
Labels.Margins.Left   := 5;
Labels.Margins.Bottom := 10;
Labels.Margins.Top    := 10;
Labels.Text           := 'TREINO DA SEGUNDA';

MultiView1.HideMaster;
end;

end.
