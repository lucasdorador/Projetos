unit uPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Layouts, FMX.Controls.Presentation,
  {$IF DEFINED (ANDROID)} Androidapi.Helpers, {$ENDIF} FMX.MultiView;

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
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
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

procedure TFPrincipal.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
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

      {$IF DEFINED (MSWINDOWS)}
      Close;
      {$ENDIF}
      end;
   end;
   end);
end;

procedure TFPrincipal.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFPrincipal.Label1Click(Sender: TObject);
begin
if not Assigned(FControleCheques) then
   Application.CreateForm(TFControleCheques, FControleCheques);
FControleCheques.Show;
end;

end.
