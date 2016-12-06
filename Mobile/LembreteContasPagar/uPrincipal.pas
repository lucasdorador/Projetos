unit uPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Controls.Presentation, FMX.MultiView, FMX.Objects;

type
  TFprincipal = class(TForm)
    MultiView1: TMultiView;
    LayoutPai: TLayout;
    ToolBar1: TToolBar;
    SpeedButton1: TSpeedButton;
    RecMenuTop: TRectangle;
    VertScrollBox1: TVertScrollBox;
    Rectangle1: TRectangle;
    Image1: TImage;
    Label1: TLabel;
    RecMenuPrincipal: TRectangle;
    Rectangle2: TRectangle;
    Image2: TImage;
    Label2: TLabel;
    Rectangle3: TRectangle;
    Circle1: TCircle;
    lblNomeUsuario: TLabel;
    lblEmailUsuario: TLabel;
    LayoutFilho: TLayout;
    procedure Label2Click(Sender: TObject);
    procedure Rectangle2Click(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Rectangle1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    FActiveForm : TForm;
    vgUsuario, vgEmail, vgFoto : String;
    procedure AbrirForm(vForm :TComponentClass);
  end;

var
  Fprincipal: TFprincipal;

implementation

{$R *.fmx}
{$R *.iPhone4in.fmx IOS}

uses uContas, uLogin;

procedure TFprincipal.AbrirForm(vForm: TComponentClass);
var
   vli : Integer;
begin
if (FActiveForm = nil) or (Assigned(FActiveForm) and
   (FActiveForm.ClassName <> vForm.ClassName)) then
   begin
   for vli := LayoutFilho.ControlsCount -1 downto 0 do
      LayoutFilho.RemoveObject(LayoutPai.Controls[vli]);

   FActiveForm.DisposeOf;
   FActiveForm := nil;

   Application.CreateForm(vForm, FActiveForm);
   LayoutPai.AddObject(TLayout(FActiveForm.FindComponent('LayoutCliente')));
   end;
MultiView1.HideMaster;
end;

procedure TFprincipal.FormShow(Sender: TObject);
begin
lblNomeUsuario.Text  := vgUsuario;
lblEmailUsuario.Text := vgEmail;
end;

procedure TFprincipal.Label1Click(Sender: TObject);
begin
AbrirForm(TFContas);
end;

procedure TFprincipal.Label2Click(Sender: TObject);
begin
Application.Terminate;
end;

procedure TFprincipal.Rectangle1Click(Sender: TObject);
begin
Label1Click(Sender);
end;

procedure TFprincipal.Rectangle2Click(Sender: TObject);
begin
Label2Click(Sender);
end;

end.
