unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ComCtrls, FireDAc.Comp.Client,Vcl.DBGrids;

type
  TFPrincipal = class(TForm)
    MainMenu1: TMainMenu;
    Cadastros1: TMenuItem;
    Lanamentos1: TMenuItem;
    ControledeCheques1: TMenuItem;
    Bancos1: TMenuItem;
    ContaCorrente1: TMenuItem;
    Sair1: TMenuItem;
    Relatrios1: TMenuItem;
    ControleBancrio1: TMenuItem;
    Cheques1: TMenuItem;
    ChequesaVencer1: TMenuItem;
    ChequesResumido1: TMenuItem;
    ChequesDetalhados1: TMenuItem;
    StatusBar1: TStatusBar;
    procedure ControledeCheques1Click(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Bancos1Click(Sender: TObject);
    procedure ContaCorrente1Click(Sender: TObject);
  private
    procedure fncCriaBanco;
    procedure OnKeyDownTabelas(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    { Private declarations }
  public
    procedure PadronizaDbGrid(Tabela: TDBGrid);
    { Public declarations }
  end;

var
  FPrincipal: TFPrincipal;

implementation

{$R *.dfm}

uses uControleCheques, uCadastros, uFuncoes, udmPrincipal, uVariaveis;

procedure TFPrincipal.Bancos1Click(Sender: TObject);
begin
Application.CreateForm(TFCadastros, FCadastros);
FCadastros.HabilitaPaletas(FCadastros.tsBancos);
FCadastros.vgoTipoTabela := tt_Banco;
FCadastros.ShowModal;
FreeAndNil(FCadastros);
end;

procedure TFPrincipal.ContaCorrente1Click(Sender: TObject);
begin
Application.CreateForm(TFCadastros, FCadastros);
FCadastros.HabilitaPaletas(FCadastros.tsConta);
FCadastros.vgoTipoTabela := tt_Conta;
FCadastros.ShowModal;
FreeAndNil(FCadastros);
end;

procedure TFPrincipal.ControledeCheques1Click(Sender: TObject);
begin
Application.CreateForm(TFControleCheques, FControleCheques);
FControleCheques.ShowModal;
FreeAndNil(FControleCheques);
end;

procedure TFPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
if MessageDlg('Deseja realmente fechar o sistema?', MtConfirmation, [mbYes, mbNo], 0) = mrNo then
   begin
   Action := caNone;
   end;
end;

procedure TFPrincipal.FormShow(Sender: TObject);
begin
vgConexao := TFDConnection.Create(Application);

if not FileExists(ExtractFilePath(Application.ExeName) + '\DFSISTEMAS.FDB') then
   begin
   fncCriaBanco;
   //Gravar INI
   GravaINIBanco(ExtractFilePath(Application.ExeName) + '\DFSISTEMAS.FDB', 'SYSDBA', 'masterkey');
   GravaFireDAcConection(ExtractFilePath(Application.ExeName) + '\DFSISTEMAS.FDB', 'SYSDBA', 'masterkey');
   pcdCriaParametrosConexaoFireDAc(ExtractFilePath(Application.ExeName) + '\DFSISTEMAS.FDB', 'SYSDBA', 'masterkey', vgConexao);
   try
   vgConexao.Connected := True;
   Except
      on E:Exception do
         begin
         MensagemSistema('Informação', 'Houve um erro para criar a conexão com a seguinte mensagem: ' + E.Message);
         Abort;
         end;
      end;
//   TTabelas.TabelasFirebird(vgConexao);
   end
else
   begin
   LerINIBanco;
   pcdCriaParametrosConexaoFireDAc(vgCaminhoBanco, vgUsuarioBanco, vgSenhaBanco, vgConexao);
   try
   vgConexao.Connected := True;
   Except
      on E:Exception do
         begin
         MensagemSistema('Informação', 'Houve um erro para criar a conexão com a seguinte mensagem: ' + E.Message);
         Abort;
         end;
      end;
   end;

Left   := 0;
Top    := 0;
Height := Screen.WorkAreaHeight;
Width  := Screen.WorkAreaWidth;

StatusBar1.Panels[2].Text := FormatDateTime('dd/mm/yyyy', Date) + ' - ' + UpperCase(FormatDateTime('dddd', Date));
end;

procedure TFPrincipal.fncCriaBanco;
begin
//Cria o componente "IBScript"
try
//Insere comandos sql para criação do Banco de Dados
Application.CreateForm(TDMPrincipal, DMPrincipal);

DMPrincipal.FBScript.Script.Add('SET SQL DIALECT 3;');
DMPrincipal.FBScript.Script.Add('SET NAMES WIN1252;');
DMPrincipal.FBScript.Script.Add('CREATE DATABASE "'+ExtractFilePath(Application.ExeName)+'\DFSISTEMAS.FDB"');
DMPrincipal.FBScript.Script.Add('USER ''SYSDBA'' PASSWORD ''masterkey''');
DMPrincipal.FBScript.Script.Add('PAGE_SIZE 16384');
DMPrincipal.FBScript.Script.add('DEFAULT CHARACTER SET WIN1252;');
//Executa o Script
DMPrincipal.FBScript.ExecuteScript;

finally
  //Ao Finalizar processo, libera componente da memória
  FreeAndNil(DMPrincipal.FBScript);
end;
end;


procedure TFPrincipal.Sair1Click(Sender: TObject);
begin
Close;
end;

procedure TFPrincipal.OnKeyDownTabelas(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if (ssCtrl in Shift) and (Key = VK_DELETE) then
    Key := 0;
end;

procedure TFPrincipal.PadronizaDbGrid(Tabela: TDBGrid);
begin
Tabela.Options := Tabela.Options - [dgEditing];
Tabela.Options := Tabela.Options - [dgColumnResize];
Tabela.Options := Tabela.Options - [dgConfirmDelete];
Tabela.Options := Tabela.Options - [dgRowSelect];
Tabela.Options := Tabela.Options - [dgTabs];

Tabela.OnKeyDown := OnKeyDownTabelas;
end;

end.

