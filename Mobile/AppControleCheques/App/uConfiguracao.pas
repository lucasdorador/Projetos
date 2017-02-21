unit uConfiguracao;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.Edit, FMX.Effects,
  FGX.ProgressDialog;

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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FConfiguracao: TFConfiguracao;

implementation

{$R *.fmx}

uses uComunicaServer, uPrincipal;
{$R *.NmXhdpiPh.fmx ANDROID}

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

procedure TFConfiguracao.SpeedButton1Click(Sender: TObject);
begin
if not Assigned(FPrincipal) then
   Application.CreateForm(TFPrincipal, FPrincipal);
FPrincipal.Show;
end;

end.
