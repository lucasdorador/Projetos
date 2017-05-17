unit uDashBoard;

interface

uses
  Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.AppEvnts, Vcl.StdCtrls, IdHTTPWebBrokerBridge, Web.HTTPApp,
  IdStackWindows;

type
  TForm1 = class(TForm)
    ButtonStart: TButton;
    ButtonStop: TButton;
    Label1: TLabel;
    ApplicationEvents1: TApplicationEvents;
    Memo1: TMemo;
    GroupBox1: TGroupBox;
    EditPort: TEdit;
    MemoIP: TMemo;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
    procedure ButtonStartClick(Sender: TObject);
    procedure ButtonStopClick(Sender: TObject);
    procedure ButtonOpenBrowserClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    FServer: TIdHTTPWebBrokerBridge;
    procedure StartServer;
    function getIP: String;
    { Private declarations }
  public
     procedure pcdMensagemMemo(psMensagem: String);
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  WinApi.Windows, Winapi.ShellApi, Datasnap.DSSession;

procedure TForm1.ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
begin
  ButtonStart.Enabled := not FServer.Active;
  ButtonStop.Enabled := FServer.Active;
  EditPort.Enabled := not FServer.Active;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
ButtonStop.Click;
Sleep(500);
Application.Terminate;
end;

procedure TForm1.ButtonOpenBrowserClick(Sender: TObject);
var
  LURL: string;
begin
  StartServer;
  LURL := Format('http://localhost:%s', [EditPort.Text]);
  ShellExecute(0,
        nil,
        PChar(LURL), nil, nil, SW_SHOWNOACTIVATE);
end;

procedure TForm1.ButtonStartClick(Sender: TObject);
begin
  StartServer;
  pcdMensagemMemo('Conectado!')
end;

procedure TerminateThreads;
begin
  if TDSSessionManager.Instance <> nil then
    TDSSessionManager.Instance.TerminateAllSessions;
end;

procedure TForm1.ButtonStopClick(Sender: TObject);
begin
  TerminateThreads;
  FServer.Active := False;
  FServer.Bindings.Clear;

  pcdMensagemMemo('Desconectado!')
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FServer := TIdHTTPWebBrokerBridge.Create(Self);
  Memo1.Lines.Clear;
  MemoIP.Lines.Clear;
  MemoIP.Lines.Add(getIP);
  ButtonStart.Click;
end;

procedure TForm1.StartServer;
begin
  if not FServer.Active then
  begin
    FServer.Bindings.Clear;
    FServer.DefaultPort := StrToInt(EditPort.Text);
    FServer.Active := True;
  end;
end;

procedure TForm1.pcdMensagemMemo(psMensagem: String);
begin
Memo1.Lines.Add(FormatDateTime('cc', Now) + ' - ' + psMensagem);
end;

function TForm1.getIP: String;
var
  IdStackWin: TIdStackWindows;
  //vlResult : TStrings;
begin
try
IdStackWin := TIdStackWindows.Create;
//vlResult := TStrings.Create;
try
Result := IdStackWin.LocalAddresses.Text;
//Result := vlResult.Text;
finally
   IdStackWin.Free;
   end;
Except
  on e :exception do
     result := e.Message;
   end;
end;

end.
