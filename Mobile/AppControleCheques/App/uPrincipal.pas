unit uPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Layouts, FMX.Controls.Presentation,
  {$IF DEFINED (ANDROID)} Androidapi.Helpers, {$ENDIF} FMX.MultiView,
  FMX.Effects, System.ImageList, FMX.ImgList, FGX.ProgressDialog;

type
  TFPrincipal = class(TForm)
    MultiView1: TMultiView;
    Layout1: TLayout;
    ToolBar1: TToolBar;
    SpeedButton1: TSpeedButton;
    recTop: TRectangle;
    VertScrollBox1: TVertScrollBox;
    recSair: TRectangle;
    Image1: TImage;
    Label1: TLabel;
    recButtom: TRectangle;
    recCheques: TRectangle;
    Image2: TImage;
    Label2: TLabel;
    recConfiguracao: TRectangle;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    ShadowEffect1: TShadowEffect;
    ShadowEffect2: TShadowEffect;
    ShadowEffect3: TShadowEffect;
    Label3: TLabel;
    Image3: TImage;
    fgActivityDialog: TfgActivityDialog;
    procedure Label1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure Label2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Label3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FPrincipal: TFPrincipal;

implementation

{$R *.fmx}

uses uControleCheques, uConfiguracao, uClassPODO, uFuncoesApp,
  ClientModuleUnit1, uComunicaServer;

procedure TFPrincipal.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
CanClose := False;
{$IF DEFINED (ANDROID)}
MessageDlg('Deseja realmente fechar o Controle de Cheques?',
            System.UITypes.TMsgDlgType.mtInformation,
            [System.UITypes.TMsgDlgBtn.mbYes, System.UITypes.TMsgDlgBtn.mbNo], 0,
procedure(const BotaoPressionado: TModalResult)
   begin
   case BotaoPressionado of
   mrYes:
      begin
      SharedActivity.Finish;
      end;
      end;
   end);
{$ENDIF}

{$IF DEFINED (MSWINDOWS)}
if MessageDlg('Deseja realmente fechar o Controle de Cheques?',
              System.UITypes.TMsgDlgType.mtInformation,
             [System.UITypes.TMsgDlgBtn.mbYes, System.UITypes.TMsgDlgBtn.mbNo], 0) = mrYes then
   begin
   Close;
   CanClose := True;
   end;
{$ENDIF}
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

procedure TFPrincipal.FormShow(Sender: TObject);
var
   vlConfigApp : TConfiguracaoApp;
   vlServico : TComunicaServer;
begin
MultiView1.HideMaster;
MultiView1.Width := FPrincipal.Width - 50;
vlConfigApp := TGravaConfiguracoesINI.pcdLerConfigApp;
try
if (Trim(vlConfigApp.psEnderecoIP) <> '') and
   (Trim(vlConfigApp.psPortaConexao) <> '') then
   begin
   TConfiguraREST.configuracaoREST(vlConfigApp, ClientModule1.DSRestConnection1);

   vlServico := TComunicaServer.Create;
   fgActivityDialog.Show;
   fgActivityDialog.Message := 'Aguarde estabelecendo conexão ...';
   try
   if not vlServico.fncValidaConexaoServidorSemMsg then
      begin
      Showmessage('Não foi possível comunicar com o servidor por favor verifique. Erro: ' + vlServico.vlsMensagemErro);
      end;

   finally
      FreeAndNil(vlServico);
      fgActivityDialog.Hide;
      end;
   end
else
   begin
   FConfiguracao.Show;
   end;

finally
   FreeAndNil(vlConfigApp);
   end;
end;

procedure TFPrincipal.Label1Click(Sender: TObject);
var
  Fechar : Boolean;
begin
FormCloseQuery(Sender, Fechar);
end;

procedure TFPrincipal.Label2Click(Sender: TObject);
begin
if not Assigned(FControleCheques) then
   Application.CreateForm(TFControleCheques, FControleCheques);
FControleCheques.Show;
end;

procedure TFPrincipal.Label3Click(Sender: TObject);
begin
if not Assigned(FConfiguracao) then
   Application.CreateForm(TFConfiguracao, FConfiguracao);

FConfiguracao.Show;
end;

end.
