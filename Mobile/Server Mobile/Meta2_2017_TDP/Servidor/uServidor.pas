unit uServidor;

interface

uses
  Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.AppEvnts, Vcl.StdCtrls, IdHTTPWebBrokerBridge, Web.HTTPApp, Vcl.ComCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, WinApi.Windows,
  Winapi.ShellApi, Datasnap.DSSession, uFuncoes, uDMServer;

type
  TFServidor = class(TForm)
    ApplicationEvents1: TApplicationEvents;
    pgcPrincipal: TPageControl;
    tbInformacoes: TTabSheet;
    btnIniciar: TBitBtn;
    btnParar: TBitBtn;
    btnVisualizar: TBitBtn;
    btnConfig: TBitBtn;
    btnFechar: TBitBtn;
    tbVisualizaLog: TTabSheet;
    tbConfig: TTabSheet;
    GroupBox1: TGroupBox;
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    mLog: TMemo;
    Panel2: TPanel;
    btnVoltarLog: TBitBtn;
    Panel3: TPanel;
    btnVoltarConfig: TBitBtn;
    GroupBox2: TGroupBox;
    OpenDialog1: TOpenDialog;
    edtCaminho: TEdit;
    Label2: TLabel;
    btnLocalizar: TBitBtn;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    edtPorta: TEdit;
    btnGravarConfig: TBitBtn;
    btnTestarConexao: TBitBtn;
    btnTestarBanco: TBitBtn;
    Memo1: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
    procedure btnIniciarClick(Sender: TObject);
    procedure btnPararClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnVisualizarClick(Sender: TObject);
    procedure btnConfigClick(Sender: TObject);
    procedure btnVoltarLogClick(Sender: TObject);
    procedure btnVoltarConfigClick(Sender: TObject);
    procedure btnLocalizarClick(Sender: TObject);
    procedure btnGravarConfigClick(Sender: TObject);
    procedure btnTestarConexaoClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure btnTestarBancoClick(Sender: TObject);
  private
    FServer: TIdHTTPWebBrokerBridge;
    voConfigINI : TConfigINI;
    procedure StartServer;
    procedure HabilitaPaletas(vPaleta: TTabSheet);
    { Private declarations }
  public
    { Public declarations }
    procedure pcdMensagemLOG(psMensagem: String);
  end;

var
  FServidor: TFServidor;

implementation

{$R *.dfm}
procedure TFServidor.ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
begin
  btnIniciar.Enabled       := not FServer.Active;
  btnParar.Enabled         := FServer.Active;
  edtPorta.Enabled         := not FServer.Active;
  btnTestarConexao.Enabled := FServer.Active;
end;

procedure TFServidor.btnTestarBancoClick(Sender: TObject);
begin
if DMServer.FDConexao.Connected then
   ShowMessage('Conexão com o Banco de Dados efetuada com sucesso!')
else
   ShowMessage('Não foi possível estabelecer conexão com Banco de Dados');
end;

procedure TFServidor.btnTestarConexaoClick(Sender: TObject);
var
  LURL: string;
begin
  StartServer;
  LURL := Format('http://localhost:%s', [edtPorta.Text]);
  ShellExecute(0,
        nil,
        PChar(LURL), nil, nil, SW_SHOWNOACTIVATE);
end;

procedure TFServidor.btnConfigClick(Sender: TObject);
begin
btnParar.Click;
edtCaminho.Text := voConfigINI.psCaminhoDB;
edtPorta.Text   := voConfigINI.psPorta;

HabilitaPaletas(tbConfig);
end;

procedure TFServidor.btnFecharClick(Sender: TObject);
begin
btnParar.Click;
Close;
end;

procedure TFServidor.btnGravarConfigClick(Sender: TObject);
begin
if (edtCaminho.Text = '') then
   begin
   ShowMessage('Caminho do Banco de Dados inválido, verifique!');
   edtCaminho.SetFocus;
   Abort;
   end;

if (edtPorta.Text = '') then
   begin
   ShowMessage('Porta de conexão inválida, verifique!');
   edtPorta.SetFocus;
   Abort;
   end;

TFuncoes.GravaIni(edtCaminho.Text, edtPorta.Text);
voConfigINI := TFuncoes.LerConfigIni;
DMServer.DataModuleCreate(Sender);
TFuncoes.pcdCarregaInformacoes;

Memo1.Lines.Clear;
Memo1.Lines.Add('IP(s)');
Memo1.Lines.Add(TFuncoes.getIP);

pcdMensagemLOG('Configurações Alteradas com sucesso!');
HabilitaPaletas(tbInformacoes);
end;

procedure TFServidor.btnIniciarClick(Sender: TObject);
begin
  StartServer;
  TFuncoes.pcdCarregaInformacoes;

  Memo1.Lines.Clear;
  Memo1.Lines.Add('IP(s)');
  Memo1.Lines.Add(TFuncoes.getIP);
  pcdMensagemLOG('Serviço Iniciado');
end;

procedure TFServidor.btnLocalizarClick(Sender: TObject);
begin
if OpenDialog1.Execute then
   begin
   OpenDialog1.InitialDir := ExtractFilePath(Application.ExeName);
   edtCaminho.Text        := OpenDialog1.FileName;
   end;
end;

procedure TerminateThreads;
begin
  if TDSSessionManager.Instance <> nil then
    TDSSessionManager.Instance.TerminateAllSessions;
end;

procedure TFServidor.btnPararClick(Sender: TObject);
begin
  TerminateThreads;
  FServer.Active := False;
  FServer.Bindings.Clear;
  pcdMensagemLOG('Serviço Parado');
end;

procedure TFServidor.btnVisualizarClick(Sender: TObject);
begin
HabilitaPaletas(tbVisualizaLog);
end;

procedure TFServidor.btnVoltarConfigClick(Sender: TObject);
begin
HabilitaPaletas(tbInformacoes);
end;

procedure TFServidor.btnVoltarLogClick(Sender: TObject);
begin
HabilitaPaletas(tbInformacoes);
end;

procedure TFServidor.DBGrid1CellClick(Column: TColumn);
begin
DBGrid1.Hint     := DMServer.FDInformacoesValor.AsString;
DBGrid1.ShowHint := True;
end;

procedure TFServidor.FormCreate(Sender: TObject);
begin
  FServer := TIdHTTPWebBrokerBridge.Create(Self);
end;

procedure TFServidor.FormShow(Sender: TObject);
begin
voConfigINI := TFuncoes.LerConfigIni;

if ((voConfigINI.psCaminhoDB <> '') and (voConfigINI.psPorta <> '')) and
   (DMServer.FDConexao <> nil) then
   begin
   edtCaminho.Text := voConfigINI.psCaminhoDB;
   edtPorta.Text   := voConfigINI.psPorta;
   btnIniciar.Click;
   HabilitaPaletas(tbInformacoes);
   end
else
   HabilitaPaletas(tbConfig);
end;

procedure TFServidor.StartServer;
begin
  if not FServer.Active then
  begin
    FServer.Bindings.Clear;
    FServer.DefaultPort := StrToInt(edtPorta.Text);
    FServer.Active := True;
  end;
end;

procedure TFServidor.HabilitaPaletas(vPaleta: TTabSheet);
begin
tbConfig.TabVisible       := vPaleta = tbConfig;
tbVisualizaLog.TabVisible := vPaleta = tbVisualizaLog;
tbInformacoes.TabVisible  := vPaleta = tbInformacoes;
end;

procedure TFServidor.pcdMensagemLOG(psMensagem: String);
begin
mLog.Lines.Add(FormatDateTime('cc', Now) + ' - ' + psMensagem);
end;

end.
