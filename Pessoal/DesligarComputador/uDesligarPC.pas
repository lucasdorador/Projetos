unit uDesligarPC;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Mask, IniFiles, Vcl.AppEvnts, Vcl.Menus;

type
  TFDesligarPC = class(TForm)
    Panel1: TPanel;
    btnIniciar: TBitBtn;
    btnParar: TBitBtn;
    btnSair: TBitBtn;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    edtHora: TMaskEdit;
    TimerDesligar: TTimer;
    TrayIcon1: TTrayIcon;
    ApplicationEvents1: TApplicationEvents;
    PopupMenu1: TPopupMenu;
    Abrir1: TMenuItem;
    Minimizar1: TMenuItem;
    Fechar1: TMenuItem;
    procedure btnSairClick(Sender: TObject);
    procedure edtHoraExit(Sender: TObject);
    procedure TimerDesligarTimer(Sender: TObject);
    procedure btnIniciarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnPararClick(Sender: TObject);
    procedure Abrir1Click(Sender: TObject);
    procedure Minimizar1Click(Sender: TObject);
    procedure Fechar1Click(Sender: TObject);
    procedure ApplicationEvents1Minimize(Sender: TObject);
    procedure TrayIcon1DblClick(Sender: TObject);
  private
    { Private declarations }
    vlsHoraConfigurada : String;
    procedure maximizar;
    procedure minimizar;
  public
    { Public declarations }
  end;

var
  FDesligarPC: TFDesligarPC;

implementation

{$R *.dfm}

procedure TFDesligarPC.Abrir1Click(Sender: TObject);
begin
maximizar;
end;

procedure TFDesligarPC.ApplicationEvents1Minimize(Sender: TObject);
begin
minimizar;
end;

procedure TFDesligarPC.btnIniciarClick(Sender: TObject);
var
   vloIni : TIniFile;
begin
vloIni := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'Config.Ini');
try
edtHoraExit(Sender);
if (Trim(edtHora.Text) <> '') or
   (edtHora.Text <> ' : ') then
   vloIni.WriteString('Config', 'Hora Desligamento', edtHora.Text)
else
   ShowMessage('Configure uma hora por favor.');
finally
   FreeAndNil(vloIni);
   end;

vlsHoraConfigurada    := edtHora.Text;
TimerDesligar.Enabled := True;
minimizar;
end;

procedure TFDesligarPC.btnPararClick(Sender: TObject);
begin
TimerDesligar.Enabled := False;
end;

procedure TFDesligarPC.btnSairClick(Sender: TObject);
begin
Close;
end;

procedure TFDesligarPC.edtHoraExit(Sender: TObject);
begin
try
if not btnSair.Focused then
   StrToTime(edtHora.Text);
except
   ShowMessage('Hora inválida, verifique!');
   if edtHora.CanFocus then
      edtHora.SetFocus;

   Abort;
   end;
end;

procedure TFDesligarPC.Fechar1Click(Sender: TObject);
begin
btnSair.Click;
end;

procedure TFDesligarPC.FormShow(Sender: TObject);
var
  vloIni: TIniFile;
begin
if FileExists(ExtractFilePath(Application.ExeName) + 'Config.Ini') then
   begin
   vloIni := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'Config.Ini');
   try
   vlsHoraConfigurada := vloIni.ReadString('Config', 'Hora Desligamento', '18:20');
   edtHora.Text       := vlsHoraConfigurada;
   finally
      FreeAndNil(vloIni);
      end;
   end
else
   begin
   edtHora.Text := '18:20';
   end;

TimerDesligar.Interval := 60000;
end;

procedure TFDesligarPC.TimerDesligarTimer(Sender: TObject);
begin
if FormatDateTime('HH:MM', StrToTime(vlsHoraConfigurada)) <=
   FormatDateTime('HH:MM', Now) then
   begin
   TimerDesligar.Enabled := False;
   WinExec('cmd /c shutdown -s -t 60',SW_NORMAL);
   end;
end;

procedure TFDesligarPC.TrayIcon1DblClick(Sender: TObject);
begin
maximizar;
end;

procedure TFDesligarPC.maximizar;
begin
FDesligarPC.Show;
FDesligarPC.WindowState := wsNormal;
Application.BringToFront();
Abrir1.Visible          := False;
Minimizar1.Visible      := True;
Fechar1.Visible         := True;
end;

procedure TFDesligarPC.minimizar;
begin
FDesligarPC.Hide;
FDesligarPC.WindowState := wsMinimized;
TrayIcon1.Animate       := True;
TrayIcon1.ShowBalloonHint;
Abrir1.Visible          := True;
Minimizar1.Visible      := False;
Fechar1.Visible         := True;
end;

procedure TFDesligarPC.Minimizar1Click(Sender: TObject);
begin
minimizar;
end;

end.
