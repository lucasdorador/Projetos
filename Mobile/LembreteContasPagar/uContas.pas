unit uContas;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls, FMX.TabControl, FMX.Edit,
  FMX.DateTimeCtrls, FMX.EditBox, FMX.NumberBox, FMX.Ani;

type
  TFContas = class(TForm)
    TabControl1: TTabControl;
    TabContasReceber: TTabItem;
    TabContasPagar: TTabItem;
    LayoutCliente: TLayout;
    Label1: TLabel;
    GridLayout: TGridPanelLayout;
    Rectangle1: TRectangle;
    Label2: TLabel;
    RecDescricaoContaRecebe: TRectangle;
    edtDescricaoContasRec: TEdit;
    GridPanelLayout1: TGridPanelLayout;
    Rectangle2: TRectangle;
    Label3: TLabel;
    Rectangle4: TRectangle;
    edtDataVencimentoRec: TDateEdit;
    Rectangle3: TRectangle;
    Label6: TLabel;
    Rectangle5: TRectangle;
    edtValorContaRec: TNumberBox;
    Label4: TLabel;
    GridPanelLayout2: TGridPanelLayout;
    Rectangle6: TRectangle;
    Label5: TLabel;
    Rectangle7: TRectangle;
    edtDataAgendamento: TDateEdit;
    Rectangle8: TRectangle;
    Label7: TLabel;
    Rectangle9: TRectangle;
    edtHoraAgendamento: TTimeEdit;
    Button1: TButton;
    ToolBar1: TToolBar;
    Rectangle10: TRectangle;
    Rectangle11: TRectangle;
    btnAdicionarUsuario: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormVirtualKeyboardShown(Sender: TObject;
      KeyboardVisible: Boolean; const Bounds: TRect);
    procedure FormVirtualKeyboardHidden(Sender: TObject;
      KeyboardVisible: Boolean; const Bounds: TRect);
  private
    { Private declarations }
    FTecladoShow : Boolean;
  public
    { Public declarations }
  end;

var
  FContas: TFContas;

implementation

{$R *.fmx}
{$R *.NmXhdpiPh.fmx ANDROID}

uses uPrincipal;


procedure TFContas.Button1Click(Sender: TObject);
begin
ShowMessage('Conta: ' + edtDescricaoContasRec.Text + ' gravada com sucesso!');
ShowMessage('Usuário: ' + Fprincipal.vgUsuario);
Fprincipal.AbrirForm(TFprincipal);
end;

procedure TFContas.FormShow(Sender: TObject);
begin
TabControl1.ActiveTab := TabContasReceber;
edtDescricaoContasRec.SetFocus;
end;

procedure TFContas.FormVirtualKeyboardHidden(Sender: TObject;
  KeyboardVisible: Boolean; const Bounds: TRect);
begin
FTecladoShow := false;
if not KeyboardVisible then
   AnimateFloat('Padding.Top', 0, 0.1);
end;

procedure TFContas.FormVirtualKeyboardShown(Sender: TObject;
  KeyboardVisible: Boolean; const Bounds: TRect);
var
     O: TFMXObject;
begin
FTecladoShow := true;
if Assigned(Focused) and (Focused.GetObject is TControl) then
   if TControl(Focused).AbsoluteRect.Bottom - Padding.Top >= (Bounds.Top) then
      begin
           //If switching between controls, the KeyboardHidden animation will run first
           //and we'll see the form scroll up and then down.
           //Calling StopPropertyAnimation jumps the first animation to it's final value - same problem
           //Instead we need to search for the other animation and call StopAtCurrent.
      for O in Children do
          if (O is TFloatAnimation) and (TFloatAnimation(O).PropertyName = 'Padding.Top') then
             TFloatAnimation(O).StopAtCurrent;

      //AnimateFloat
      AnimateFloat('Padding.Top',Bounds.Top - TControl(Focused).AbsoluteRect.Bottom + Padding.Top, 0.1)
      end
   else
else
   AnimateFloat('Padding.Top', 0, 0.1);
end;

end.
