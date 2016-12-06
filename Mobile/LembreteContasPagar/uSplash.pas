unit uSplash;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.Effects, FMX.Filter.Effects, FMX.Ani;

type
  TFSplash = class(TForm)
    Image1: TImage;
    TransitionEffect1: TRotateCrumpleTransitionEffect;
    Layout1: TLayout;
    FloatAnimation1: TFloatAnimation;
    Timer1: TTimer;
    procedure FloatAnimation1Finish(Sender: TObject);
    procedure FloatAnimation1Process(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FSplash: TFSplash;

implementation

{$R *.fmx}

uses uLogin;

procedure TFSplash.FloatAnimation1Finish(Sender: TObject);
begin
FLogin.Show;
Timer1.Enabled := False;
end;

procedure TFSplash.FloatAnimation1Process(Sender: TObject);
var
   ScreenShot : TBitmap;
begin
if not Assigned(FLogin) then
   Application.CreateForm(TFLogin, FLogin);

ScreenShot := TBitmap.Create;
ScreenShot := FLogin.LayoutCliente.MakeScreenshot;
TransitionEffect1.Target.Assign(ScreenShot);
ScreenShot.Free;
end;

procedure TFSplash.FormShow(Sender: TObject);
begin
Timer1.Enabled := False;
Sleep(1000);
Timer1.Enabled := True;
end;

procedure TFSplash.Timer1Timer(Sender: TObject);
begin
TransitionEffect1.Enabled := False;
TransitionEffect1.RandomSeed := Random;

TransitionEffect1.Parent := FSplash;

TransitionEffect1.Enabled := True;
FloatAnimation1.Enabled := True;
FloatAnimation1.Start;
end;

initialization
   Randomize;

end.
