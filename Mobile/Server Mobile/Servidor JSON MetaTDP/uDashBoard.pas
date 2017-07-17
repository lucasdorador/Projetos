unit uDashBoard;

interface

uses
  Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.AppEvnts, Vcl.StdCtrls, IdHTTPWebBrokerBridge, Web.HTTPApp,
  IdStackWindows, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Buttons, Vcl.Imaging.pngimage,
  Vcl.Menus;

type
  TFDashBoard = class(TForm)
    ApplicationEvents1: TApplicationEvents;
    TrayIcon1: TTrayIcon;
    PageControl1: TPageControl;
    tbConfiguracao: TTabSheet;
    tbLog: TTabSheet;
    Memo1: TMemo;
    GroupBox1: TGroupBox;
    EditPort: TEdit;
    MemoIP: TMemo;
    Panel1: TPanel;
    btnIniciar: TBitBtn;
    btnParar: TBitBtn;
    btnLog: TBitBtn;
    btnSair: TBitBtn;
    btnLog_Voltar: TBitBtn;
    Image1: TImage;
    popLog: TPopupMenu;
    GravarLog1: TMenuItem;
    PopupMenu1: TPopupMenu;
    Abrir1: TMenuItem;
    Fechar1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
    procedure ButtonStartClick(Sender: TObject);
    procedure ButtonStopClick(Sender: TObject);
    procedure ButtonOpenBrowserClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ApplicationEvents1Minimize(Sender: TObject);
    procedure TrayIcon1DblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnLogClick(Sender: TObject);
    procedure btnLog_VoltarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GravarLog1Click(Sender: TObject);
    procedure Abrir1Click(Sender: TObject);
    procedure Fechar1Click(Sender: TObject);
  private
    FServer: TIdHTTPWebBrokerBridge;
    procedure StartServer;
    function getIP: String;
    procedure abrirTela;
    procedure minimizaTela;
    procedure HabilitaPaletas(vPaleta: TTabSheet);
    { Private declarations }
  public
     procedure pcdMensagemMemo(psMensagem: String);
    { Public declarations }
  end;

var
  FDashBoard: TFDashBoard;

implementation

{$R *.dfm}

uses
  WinApi.Windows, Winapi.ShellApi, Datasnap.DSSession;

procedure TFDashBoard.ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
begin
  btnIniciar.Enabled := not FServer.Active;
  btnParar.Enabled   := FServer.Active;
  EditPort.Enabled   := not FServer.Active;
  MemoIP.Enabled     := not FServer.Active;
end;

procedure TFDashBoard.ApplicationEvents1Minimize(Sender: TObject);
begin
minimizaTela;
end;

procedure TFDashBoard.btnLog_VoltarClick(Sender: TObject);
begin
HabilitaPaletas(tbConfiguracao);
end;

procedure TFDashBoard.btnLogClick(Sender: TObject);
begin
HabilitaPaletas(tbLog);
end;

procedure TFDashBoard.Button1Click(Sender: TObject);
begin
btnParar.Click;
Sleep(500);
Application.Terminate;
end;

procedure TFDashBoard.ButtonOpenBrowserClick(Sender: TObject);
var
  LURL: string;
begin
  StartServer;
  LURL := Format('http://localhost:%s', [EditPort.Text]);
  ShellExecute(0,
        nil,
        PChar(LURL), nil, nil, SW_SHOWNOACTIVATE);
end;

procedure TFDashBoard.ButtonStartClick(Sender: TObject);
begin
  StartServer;
  pcdMensagemMemo('Conectado!')
end;

procedure TerminateThreads;
begin
  if TDSSessionManager.Instance <> nil then
    TDSSessionManager.Instance.TerminateAllSessions;
end;

procedure TFDashBoard.ButtonStopClick(Sender: TObject);
begin
  TerminateThreads;
  FServer.Active := False;
  FServer.Bindings.Clear;

  pcdMensagemMemo('Desconectado!')
end;

procedure TFDashBoard.Fechar1Click(Sender: TObject);
begin
Close;
end;

procedure TFDashBoard.FormCreate(Sender: TObject);
begin
  FServer := TIdHTTPWebBrokerBridge.Create(Self);
  Memo1.Lines.Clear;
  MemoIP.Lines.Clear;
  MemoIP.Lines.Add(getIP);
  btnIniciar.Click;
end;

procedure TFDashBoard.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
case Key  of
   VK_F3 : btnIniciar.Click;
   VK_F4 : btnParar.Click;
   VK_F5 : btnLog.Click;
   end;

if ((Key = VK_ESCAPE) and (PageControl1.ActivePage = tbConfiguracao)) then
   btnSair.Click
else if ((Key = VK_ESCAPE) and (PageControl1.ActivePage = tbLog)) then
   btnLog_Voltar.Click;
end;

procedure TFDashBoard.FormShow(Sender: TObject);
begin
HabilitaPaletas(tbConfiguracao);
end;

procedure TFDashBoard.StartServer;
begin
  if not FServer.Active then
  begin
    FServer.Bindings.Clear;
    FServer.DefaultPort := StrToInt(EditPort.Text);
    FServer.Active := True;
  end;
end;

procedure TFDashBoard.TrayIcon1DblClick(Sender: TObject);
begin
abrirTela;
end;

procedure TFDashBoard.pcdMensagemMemo(psMensagem: String);
begin
Memo1.Lines.Add(FormatDateTime('cc', Now) + ' - ' + psMensagem);
end;

function TFDashBoard.getIP: String;
var
  IdStackWin: TIdStackWindows;
begin
try
IdStackWin := TIdStackWindows.Create;
try
Result := IdStackWin.LocalAddresses.Text;
finally
   IdStackWin.Free;
   end;
Except
  on e :exception do
     result := e.Message;
   end;
end;

procedure TFDashBoard.GravarLog1Click(Sender: TObject);
var
   vlStringList : TStringList;
begin
vlStringList := TStringList.Create;

try
vlStringList.AddStrings(Memo1.Lines);

if not DirectoryExists(ExtractFilePath(Application.ExeName) + 'LogTesteJSON') then
   ForceDirectories(ExtractFilePath(Application.ExeName) + 'LogTesteJSON');

vlStringList.SaveToFile(ExtractFilePath(Application.ExeName) + 'LogTesteJSON\log'+FormatDateTime('ddmmyyyy', Now)+'_'+FormatDateTime('hhmmss', Now)+'.txt');

ShowMessage('Arquivo gravado com sucesso em: ' + ExtractFilePath(Application.ExeName) + 'LogTesteJSON\log'+FormatDateTime('ddmmyyyy', Now)+'_'+FormatDateTime('hhmmss', Now)+'.txt');

finally
   FreeAndNil(vlStringList);
   end;
end;

procedure TFDashBoard.Abrir1Click(Sender: TObject);
begin
abrirTela;
end;

procedure TFDashBoard.abrirTela;
begin
TrayIcon1.Visible := False;
Self.Show();
WindowState := wsNormal;
Application.BringToFront();
end;

procedure TFDashBoard.minimizaTela;
begin
Self.Hide();
TrayIcon1.Visible := True;
TrayIcon1.Animate := True;
TrayIcon1.ShowBalloonHint;
end;

procedure TFDashBoard.HabilitaPaletas(vPaleta: TTabSheet);
begin
tbConfiguracao.TabVisible := vPaleta = tbConfiguracao;
tbLog.TabVisible          := vPaleta = tbLog;
end;

end.
