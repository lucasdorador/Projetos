unit uImpostos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ComCtrls, UConexaoXE8, FireDAc.Comp.Client;

type
  TFImpostos = class(TForm)
    PBotoes: TPanel;
    btnsair: TBitBtn;
    btnConfigurar: TBitBtn;
    btnImpostos: TBitBtn;
    PageControl1: TPageControl;
    btnRelatorios: TBitBtn;
    tsConfiguracao: TTabSheet;
    tsImpostos: TTabSheet;
    tsRelatorios: TTabSheet;
    procedure btnsairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConfigurarClick(Sender: TObject);
    procedure btnImpostosClick(Sender: TObject);
    procedure btnRelatoriosClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    vloConexao : TConexaoXE8;
    vgConexao :  TFDConnection;
    procedure HabilitaPaletas(vPaleta: TTabSheet);
    procedure HabilitaBotoes(vBotao: TBitBtn);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FImpostos: TFImpostos;

implementation

{$R *.dfm}

procedure TFImpostos.btnConfigurarClick(Sender: TObject);
begin

HabilitaPaletas(tsConfiguracao);
HabilitaBotoes(btnConfigurar);
end;

procedure TFImpostos.btnImpostosClick(Sender: TObject);
begin
HabilitaPaletas(tsImpostos);
HabilitaBotoes(btnImpostos);
end;

procedure TFImpostos.btnRelatoriosClick(Sender: TObject);
begin
HabilitaPaletas(tsRelatorios);
HabilitaBotoes(btnRelatorios);
end;

procedure TFImpostos.btnsairClick(Sender: TObject);
begin
Close;
end;

procedure TFImpostos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
if Assigned(vloConexao) then
   FreeAndNil(vloConexao);

end;

procedure TFImpostos.FormShow(Sender: TObject);
begin
vloConexao := TConexaoXE8.Create;
vgConexao  := vloConexao.getConnection;
tsConfiguracao.TabVisible := False;
tsImpostos.TabVisible     := False;
tsRelatorios.TabVisible   := False;
btnConfigurar.SetFocus;
end;

procedure TFImpostos.HabilitaPaletas(vPaleta: TTabSheet);
begin
tsConfiguracao.TabVisible := vPaleta = tsConfiguracao;
tsImpostos.TabVisible     := vPaleta = tsImpostos;
tsRelatorios.TabVisible   := vPaleta = tsRelatorios;
end;

procedure TFImpostos.HabilitaBotoes(vBotao: TBitBtn);
begin
btnConfigurar.Enabled := True;
btnImpostos.Enabled   := True;
btnRelatorios.Enabled := True;

if vBotao = btnConfigurar then
   vBotao.Enabled := False;

if vBotao = btnImpostos then
   vBotao.Enabled := False;

if vBotao = btnRelatorios then
   vBotao.Enabled := False;
end;


end.
