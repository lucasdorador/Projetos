unit uImpostos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ComCtrls, UConexaoXE8, FireDAc.Comp.Client, Vcl.CheckLst,
  UFuncoesFaciliteXE8, uTDPNumberEditXE8;

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
    chkTipoNF: TCheckListBox;
    Label1: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    edtPresuncaoCSLL: TDPTNumberEditXE8;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    edtAliquotaPIS: TDPTNumberEditXE8;
    GroupBox3: TGroupBox;
    Label4: TLabel;
    edtAliquotaCOFINS: TDPTNumberEditXE8;
    Label5: TLabel;
    edtAliquotaCSLL: TDPTNumberEditXE8;
    GroupBox4: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    edtPresuncaoIRPJ: TDPTNumberEditXE8;
    edtAliquotaIRPJ: TDPTNumberEditXE8;
    procedure btnsairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConfigurarClick(Sender: TObject);
    procedure btnImpostosClick(Sender: TObject);
    procedure btnRelatoriosClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtAliquotaPISExit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure edtAliquotaCOFINSExit(Sender: TObject);
    procedure edtPresuncaoIRPJExit(Sender: TObject);
    procedure edtAliquotaIRPJExit(Sender: TObject);
    procedure edtPresuncaoCSLLExit(Sender: TObject);
    procedure edtAliquotaCSLLExit(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    vloConexao : TConexaoXE8;
    vgConexao :  TFDConnection;
    vloFuncoes : TFuncoesGerais;
    procedure HabilitaPaletas(vPaleta: TTabSheet);
    procedure HabilitaBotoes(vBotao: TBitBtn);
    procedure pcdCarregaTIPONF(psEmpresa: String);
    procedure pcdValidaValorMaximoEdit(poEdit : TDPTNumberEditXE8; piValorMaximo: Integer);
    procedure Paletas(vPaleta: TTabSheet);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FImpostos: TFImpostos;

implementation

{$R *.dfm}

uses UConfiguracao;

procedure TFImpostos.BitBtn1Click(Sender: TObject);
var
   vloConfiguracao : TConfiguracao;
   I: Integer;
   vlsTipo : String;
begin
vloConfiguracao := TConfiguracao.Create(vgConexao);
try
for I := 0 to chkTipoNF.Items.Count - 1 do
   begin
   if chkTipoNF.Checked[I] then
      begin
      if Trim(vlsTipo) = '' then
         vlsTipo := chkTipoNF.Items.Strings[I] + ', '
      else
         vlsTipo := vlsTipo + chkTipoNF.Items.Strings[I] + ', ';
      end;
   end;

if Trim(vlsTipo) <> '' then
   vlsTipo := Copy(vlsTipo, 1, Length(vlsTipo) - 2);

vloConfiguracao.CONFAI_EMPRESA    := '01';
vloConfiguracao.CONFAI_TIPOSNF    := vlsTipo;
vloConfiguracao.CONFAI_ALIQPIS    := edtAliquotaPIS.Value;
vloConfiguracao.CONFAI_ALIQCOFINS := edtAliquotaCOFINS.Value;
vloConfiguracao.CONFAI_ALIQIRPJ   := edtAliquotaIRPJ.Value;
vloConfiguracao.CONFAI_ALIQCSLL   := edtAliquotaCSLL.Value;
vloConfiguracao.CONFAI_PRESIRPJ   := edtPresuncaoIRPJ.Value;
vloConfiguracao.CONFAI_PRESCSLL   := edtPresuncaoCSLL.Value;
vloConfiguracao.pcdGravaConfiguracao;
Paletas(tsImpostos);

finally
   FreeAndNil(vloConfiguracao);
   end;
end;

procedure TFImpostos.btnConfigurarClick(Sender: TObject);
begin
Paletas(tsConfiguracao);
//HabilitaPaletas(tsConfiguracao);
//HabilitaBotoes(btnConfigurar);
pcdCarregaTIPONF('01');
chkTipoNF.SetFocus;
end;

procedure TFImpostos.btnImpostosClick(Sender: TObject);
begin
Paletas(tsImpostos);
//HabilitaPaletas(tsImpostos);
//HabilitaBotoes(btnImpostos);
end;

procedure TFImpostos.btnRelatoriosClick(Sender: TObject);
begin
Paletas(tsRelatorios);
//HabilitaPaletas(tsRelatorios);
//HabilitaBotoes(btnRelatorios);
end;

procedure TFImpostos.btnsairClick(Sender: TObject);
begin
Close;
end;

procedure TFImpostos.edtAliquotaCOFINSExit(Sender: TObject);
begin
pcdValidaValorMaximoEdit(edtAliquotaCOFINS, 100);
end;

procedure TFImpostos.edtAliquotaCSLLExit(Sender: TObject);
begin
pcdValidaValorMaximoEdit(edtAliquotaCSLL, 100);
end;

procedure TFImpostos.edtAliquotaIRPJExit(Sender: TObject);
begin
pcdValidaValorMaximoEdit(edtAliquotaIRPJ, 100);
end;

procedure TFImpostos.edtAliquotaPISExit(Sender: TObject);
begin
pcdValidaValorMaximoEdit(edtAliquotaPIS, 100);
end;

procedure TFImpostos.edtPresuncaoCSLLExit(Sender: TObject);
begin
pcdValidaValorMaximoEdit(edtPresuncaoCSLL, 100);
end;

procedure TFImpostos.edtPresuncaoIRPJExit(Sender: TObject);
begin
pcdValidaValorMaximoEdit(edtPresuncaoIRPJ, 100);
end;

procedure TFImpostos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
if Assigned(vloConexao) then
   FreeAndNil(vloConexao);

if Assigned(vloFuncoes) then
   FreeAndNil(vloFuncoes);
end;

procedure TFImpostos.FormKeyPress(Sender: TObject; var Key: Char);
begin
if Key = #13 then
   begin
   Perform(Wm_NextDlgCtl,0,0);
   Key := #0;
   end
else if Key = #27 then {ESC}
   begin
//   if (pgcPrincipal.ActivePage = tsAbreCaixa) and (btnAbre_Sair.Visible) then
//      begin
//      btnSairClick(Sender);
//      end
//   else if pgcPrincipal.ActivePage <> tsDados then
//      begin
//      vgbFecharTela := True;
//      HabilitaPaletas(tsDados);
//      Abort;
//      end
//   else
      btnSairClick(Sender);
   end;
end;

procedure TFImpostos.FormShow(Sender: TObject);
begin
vloConexao := TConexaoXE8.Create;
vgConexao  := vloConexao.getConnection;
vloFuncoes := TFuncoesGerais.Create(vgConexao);
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

procedure TFImpostos.Paletas(vPaleta: TTabSheet);
begin
if vPaleta = tsConfiguracao then
   HabilitaBotoes(btnConfigurar)
else if vPaleta = tsImpostos then
   HabilitaBotoes(btnImpostos)
else if vPaleta = tsRelatorios then
   HabilitaBotoes(btnRelatorios);

HabilitaPaletas(vPaleta);
end;

procedure TFImpostos.pcdCarregaTIPONF(psEmpresa: String);
var
   vloConfiguracao : TConfiguracao;
   FDNfiscal : TFDQuery;
begin
vloConfiguracao := TConfiguracao.Create(vgConexao);
vloFuncoes.pcdCriaFDQueryExecucao(FDNfiscal, vgConexao);
try
FDNfiscal := vloConfiguracao.fncRetornaTipoNF(psEmpresa);

FDNfiscal.First;
chkTipoNF.Items.Clear;
while not FDNfiscal.Eof do
   begin
   chkTipoNF.Items.Add(FDNfiscal.FieldByName('NF_TIPO').AsString);
   FDNfiscal.Next;
   end;

chkTipoNF.Columns := Trunc(FDNfiscal.RecordCount / 4);

finally
   FreeAndNil(vloConfiguracao);
   end;
end;

procedure TFImpostos.pcdValidaValorMaximoEdit(poEdit: TDPTNumberEditXE8;
  piValorMaximo: Integer);
begin
if poEdit.Value > piValorMaximo then
   begin
   vloFuncoes.fncMensagemSistema('Valor m�ximo permito � de '+IntToStr(piValorMaximo)+', verifique!');
   poEdit.Value := 0;
   poEdit.SetFocus;
   end;
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

