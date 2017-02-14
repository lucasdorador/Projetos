unit uPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Layouts, FMX.Controls.Presentation, FMX.MultiView;

type
  TFPrincipal = class(TForm)
    MultiView1: TMultiView;
    Layout1: TLayout;
    ToolBar1: TToolBar;
    SpeedButton1: TSpeedButton;
    recTop: TRectangle;
    VertScrollBox1: TVertScrollBox;
    Rectangle2: TRectangle;
    Image1: TImage;
    Label1: TLabel;
    recButtom: TRectangle;
    procedure Label1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FPrincipal: TFPrincipal;

implementation

{$R *.fmx}
{$R *.NmXhdpiPh.fmx ANDROID}
{$R *.XLgXhdpiTb.fmx ANDROID}

uses uControleCheques;

procedure TFPrincipal.Label1Click(Sender: TObject);
begin
if not Assigned(FControleCheques) then
   Application.CreateForm(TFControleCheques, FControleCheques);
FControleCheques.Show;
end;

end.
