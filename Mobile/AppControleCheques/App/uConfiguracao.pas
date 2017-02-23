unit uConfiguracao;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.Edit, FMX.Effects,
  FGX.ProgressDialog, uClassPODO, uFuncoesApp;

type
  TFConfiguracao = class(TForm)
    Layout1: TLayout;
    ToolBar1: TToolBar;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    Label1: TLabel;
    edtIPServidor: TEdit;
    Label2: TLabel;
    edtPortaServidor: TEdit;
    btnGravar: TButton;
    btnTestar: TButton;
    btnSincronizar: TButton;
    ShadowEffect1: TShadowEffect;
    ShadowEffect2: TShadowEffect;
    ShadowEffect3: TShadowEffect;
    fgActivityDialog: TfgActivityDialog;
    SpeedButton1: TSpeedButton;
    procedure btnTestarClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FConfiguracao: TFConfiguracao;

implementation

{$R *.fmx}

uses uComunicaServer, uPrincipal, ClientModuleUnit1;
{$R *.NmXhdpiPh.fmx ANDROID}

procedure TFConfiguracao.btnGravarClick(Sender: TObject);
var
   vloConfig : TConfiguracaoApp;
   vlbErro   : Boolean;
begin
vlbErro := False;
if Trim(edtIPServidor.Text) = '' then
   begin
   ShowMessage('Por favor informe o IP ou DNS do Servidor!');
   if edtIPServidor.CanFocus then
      edtIPServidor.SetFocus;
   vlbErro := True;
   end
else if Trim(edtPortaServidor.Text) = '' then
   begin
   ShowMessage('Por favor informe a porta do Servidor!');
   if edtPortaServidor.CanFocus then
      edtPortaServidor.SetFocus;
   vlbErro := True;
   end;

if not vlbErro then
   begin
   try
   vloConfig := TConfiguracaoApp.Create;
   try
   vloConfig.psEnderecoIP   := edtIPServidor.Text;
   vloConfig.psPortaConexao := edtPortaServidor.Text;

   TGravaConfiguracoesINI.pcdGravaConfigApp(vloConfig);
   TConfiguraREST.configuracaoREST(vloConfig, ClientModule1.DSRestConnection1);

   ShowMessage('Parâmetros gravados com sucesso!');

   finally
      FreeAndNil(vloConfig);
      end;

   except
      on e : exception do
         begin
         ShowMessage(E.message);
         end;
      end;
   end;
end;

procedure TFConfiguracao.btnTestarClick(Sender: TObject);
var
   vloComunica : TComunicaServer;
   vlbErro : Boolean;
begin
vlbErro := False;
if edtIPServidor.Text = '' then
   begin
   ShowMessage('Insira o IP para testar a conexão!');
   vlbErro := True;
   end;

if edtPortaServidor.Text = '' then
   begin
   ShowMessage('Insira a Porta do Servidor para testar a conexão!');
   vlbErro := True;
   end;

if not vlbErro then
   begin
   try
   fgActivityDialog.Message := 'Testanto a comunicação com o Servidor ...';
   vloComunica              := TComunicaServer.Create;
   vloComunica.vloProgresso := fgActivityDialog;
   vloComunica.fncValidaConexaoServidor;

   finally
      if Assigned(vloComunica) then
         FreeAndNil(vloComunica);
      end;
   end;
end;

procedure TFConfiguracao.FormShow(Sender: TObject);
var
  vloConfig : TConfiguracaoApp;
begin
vloConfig := TGravaConfiguracoesINI.pcdLerConfigApp;
try
if ((Trim(vloConfig.psEnderecoIP) <> '') or
    (Trim(vloConfig.psPortaConexao) <> '')) then
   begin
   edtIPServidor.Text    := vloConfig.psEnderecoIP;
   edtPortaServidor.Text := vloConfig.psPortaConexao;
   end;

finally
   FreeAndNil(vloConfig);
   end;
end;

procedure TFConfiguracao.SpeedButton1Click(Sender: TObject);
begin
if not Assigned(FPrincipal) then
   Application.CreateForm(TFPrincipal, FPrincipal);
FPrincipal.Show;
end;

end.
