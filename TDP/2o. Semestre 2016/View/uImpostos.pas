unit uImpostos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ComCtrls, Data.DB, Vcl.Mask, Vcl.Samples.Spin, Vcl.Grids,
  Vcl.DBGrids, uTDPNumberEditXE8, Vcl.CheckLst, uFuncoesFaciliteXE8,
  FireDAc.Comp.Client, UConexaoXE8, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet;

type
  TVetorString = Array of String;

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
    btnGravarConf: TBitBtn;
    btnVoltarConf: TBitBtn;
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
    StatusBar1: TStatusBar;
    FDApuracaoTrimestral: TFDMemTable;
    dsApuracaoTrimestral: TDataSource;
    PageControl2: TPageControl;
    tsApuraMensal: TTabSheet;
    GroupBox5: TGroupBox;
    Label8: TLabel;
    Label9: TLabel;
    edtMes: TSpinEdit;
    edtAnoMensal: TMaskEdit;
    btnProcessaMensal: TBitBtn;
    dbImpostosMensal: TDBGrid;
    FDApuracaoMensal: TFDMemTable;
    dsApuracaoMensal: TDataSource;
    FDApuracaoMensalImposto: TStringField;
    FDApuracaoMensalValorApurado: TFloatField;
    FDApuracaoMensalBaseCalculo: TFloatField;
    tsApuraTrimestral: TTabSheet;
    GroupBox6: TGroupBox;
    Label10: TLabel;
    Label11: TLabel;
    edtTrimestre: TSpinEdit;
    edtAnoTrimestre: TMaskEdit;
    btnProcessaTrimestral: TBitBtn;
    dbImpostosTrimestral: TDBGrid;
    FDApuracaoMensalAliquota: TFloatField;
    FDApuracaoMensalValorImposto: TFloatField;
    FDApuracaoTrimestralImposto: TStringField;
    FDApuracaoTrimestralValorApurado: TFloatField;
    FDApuracaoTrimestralBaseCalculo: TFloatField;
    FDApuracaoTrimestralReceitaFinac: TFloatField;
    FDApuracaoTrimestralBaseImposto: TFloatField;
    FDApuracaoTrimestralAdicionalIRPJ: TFloatField;
    FDApuracaoTrimestralDeducoesImposto: TFloatField;
    FDApuracaoTrimestralValorImposto: TFloatField;
    GroupBox7: TGroupBox;
    Label12: TLabel;
    edtReceitaFinanc: TDPTNumberEditXE8;
    GroupBox8: TGroupBox;
    Label13: TLabel;
    edtDeducaoIRPJ: TDPTNumberEditXE8;
    Label14: TLabel;
    edtDeducaoCSLL: TDPTNumberEditXE8;
    tsPrincipal: TTabSheet;
    btnGravarMensal: TBitBtn;
    GroupBox9: TGroupBox;
    dbTrimestral: TDBGrid;
    GroupBox10: TGroupBox;
    dbMensal: TDBGrid;
    FDMensal: TFDMemTable;
    dsMensal: TDataSource;
    dsTrimestral: TDataSource;
    FDTrimestral: TFDMemTable;
    FDMensalEmpresa: TStringField;
    FDMensalImposto: TStringField;
    FDMensalMes: TStringField;
    FDMensalAno: TStringField;
    FDMensalReceitaBruta: TFloatField;
    FDMensalReceitaAlterada: TFloatField;
    FDMensalAliqImposto: TFloatField;
    FDMensalValorImposto: TFloatField;
    PopupMensal: TPopupMenu;
    PopupTrimestral: TPopupMenu;
    ImpressoDARF1: TMenuItem;
    ImpressodoDARF1: TMenuItem;
    GroupBox11: TGroupBox;
    Label15: TLabel;
    edtConsultaMensal_Mes: TSpinEdit;
    edtConsultaMensal_Ano: TMaskEdit;
    Label16: TLabel;
    GroupBox12: TGroupBox;
    Label17: TLabel;
    Label18: TLabel;
    edtConsultaTrimestral_Trimestre: TSpinEdit;
    edtConsultaTrimestral_Ano: TMaskEdit;
    btnImposto_Voltar: TBitBtn;
    BitBtn1: TBitBtn;
    btnImpostoTri_Gravar: TBitBtn;
    btnImpostoTri_Voltar: TBitBtn;
    FDTrimestralEmpresa: TStringField;
    FDTrimestralTrimestre: TIntegerField;
    FDTrimestralAno: TStringField;
    FDTrimestralImposto: TStringField;
    FDTrimestralReceitaBruta: TFloatField;
    FDTrimestralReceitaAlterada: TFloatField;
    FDTrimestralAliqImposto: TFloatField;
    FDTrimestralPresuncao: TFloatField;
    FDTrimestralAdicionalIRPJ: TFloatField;
    FDTrimestralRetencoes: TFloatField;
    FDTrimestralValorImposto: TFloatField;
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
    procedure btnGravarConfClick(Sender: TObject);
    procedure btnProcessaMensalClick(Sender: TObject);
    procedure btnProcessaTrimestralClick(Sender: TObject);
    procedure btnRecalculaClick(Sender: TObject);
    procedure FDApuracaoMensalAfterInsert(DataSet: TDataSet);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnRecalcularTrimestreClick(Sender: TObject);
    procedure btnVoltarConfClick(Sender: TObject);
    procedure FDApuracaoTrimestralAfterInsert(DataSet: TDataSet);
    procedure btnGravarMensalClick(Sender: TObject);
    procedure dbImpostosMensalExit(Sender: TObject);
    procedure dbImpostosTrimestralExit(Sender: TObject);
    procedure FDMensalAfterInsert(DataSet: TDataSet);
    procedure FDTrimestralAfterInsert(DataSet: TDataSet);
    procedure edtConsultaMensal_AnoExit(Sender: TObject);
    procedure edtConsultaMensal_MesEnter(Sender: TObject);
    procedure edtConsultaTrimestral_AnoExit(Sender: TObject);
    procedure edtConsultaTrimestral_TrimestreEnter(Sender: TObject);
    procedure btnImpostoTri_VoltarClick(Sender: TObject);
    procedure btnImposto_VoltarClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure btnImpostoTri_GravarClick(Sender: TObject);
    procedure ImpressoDARF1Click(Sender: TObject);
    procedure ImpressodoDARF1Click(Sender: TObject);
  private
    vloConexao : TConexaoXE8;
    vgConexao :  TFDConnection;
    vgEmpresa : String;
    vloFuncoes : TFuncoesGerais;
    vgsTiposSelecionados : TVetorString;
    vgdBaseCalculo : Double;
    vgbInserir : Boolean;
    procedure HabilitaPaletas(vPaleta: TTabSheet);
    procedure HabilitaBotoes(vBotao: TBitBtn);
    procedure pcdCarregaTIPONF(psEmpresa: String);
    procedure pcdValidaValorMaximoEdit(poEdit : TDPTNumberEditXE8; piValorMaximo: Integer);
    procedure pcdCarregaDadosExistentes(psEmpresa : String);
    procedure Paletas(vPaleta: TTabSheet);
    function fncRetornaArrayTipo(psTipo: String): TVetorString;
    function fncRemoveVirgulaEspacao(psTexto: String): String;
    procedure pcdCarregaVetorTipos(psEmpresa: String);
    procedure pcdAtualizaValorBaseCalculoMensal;
    procedure pcdAtualizaValorBaseCalculoTrimestral;
    procedure pcdEditaFormatoTabelaTrimestral;
    procedure RecalculaImpostoMensal;
    procedure RecalculaImpostoTrimestral;
    procedure pcdCarregaDadosMensal;
    procedure pcdVoltar;
    procedure pcdImpressaoDARFMensal;
    procedure pcdCarregaDadosTrimestral;
    procedure pcdCarregaDadosTelaInicial;
    procedure pcdImpressaoDARFTrimestral;
    { Private declarations }
  public
    { Emissao de Guias }
    vgsReferencia, vgsVencimentos: String;
    vgdMulta, vgdJuros : Double;

  end;

var
  FImpostos: TFImpostos;

implementation

{$R *.dfm}

uses UConfiguracao, uConsultas, uProcessamento, uCRUDApuracao, uDMPrincipal,
  uVariaveisRelatorio, uRelatorios, uConstantes, uComplementos;

procedure TFImpostos.btnGravarConfClick(Sender: TObject);
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

vloConfiguracao.CONFAI_EMPRESA    := vgEmpresa;
vloConfiguracao.CONFAI_TIPOSNF    := vlsTipo;
vloConfiguracao.CONFAI_ALIQPIS    := edtAliquotaPIS.Value;
vloConfiguracao.CONFAI_ALIQCOFINS := edtAliquotaCOFINS.Value;
vloConfiguracao.CONFAI_ALIQIRPJ   := edtAliquotaIRPJ.Value;
vloConfiguracao.CONFAI_ALIQCSLL   := edtAliquotaCSLL.Value;
vloConfiguracao.CONFAI_PRESIRPJ   := edtPresuncaoIRPJ.Value;
vloConfiguracao.CONFAI_PRESCSLL   := edtPresuncaoCSLL.Value;
vloConfiguracao.pcdGravaConfiguracao;
btnImpostosClick(Sender);

finally
   FreeAndNil(vloConfiguracao);
   end;
end;

procedure TFImpostos.btnGravarMensalClick(Sender: TObject);
var
   vloCRUDMensal : TCRUDApuracaoMensal;
   FDEmpresa     : TFDQuery;
   poVariaveis   : TVariaveisRelatorioImposto;
begin
vloCRUDMensal := TCRUDApuracaoMensal.Create(vgConexao);
vloFuncoes.pcdCriaFDQueryExecucao(FDEmpresa, vgConexao);
try
FDApuracaoMensal.DisableControls;
FDApuracaoMensal.First;
while not FDApuracaoMensal.Eof do
   begin
   vloCRUDMensal.AIMES_EMPRESA         := vgEmpresa;
   vloCRUDMensal.AIMES_MES             := FormatFloat('00', edtMes.Value);
   vloCRUDMensal.AIMES_ANO             := edtAnoMensal.Text;
   vloCRUDMensal.AIMES_IMPOSTO         := FDApuracaoMensalImposto.AsString;
   vloCRUDMensal.AIMES_RECEITABRUTA    := FDApuracaoMensalValorApurado.AsFloat;
   vloCRUDMensal.AIMES_RECEITAALTERADA := FDApuracaoMensalBaseCalculo.AsFloat;
   vloCRUDMensal.AIMES_ALIQUOTAIMPOSTO := FDApuracaoMensalAliquota.AsFloat;
   vloCRUDMensal.AIMES_VALORIMPOSTO    := FDApuracaoMensalValorImposto.AsFloat;

   if not vloCRUDMensal.fncGravarApuracaoMensal then
      begin
      vloFuncoes.fncMensagemSistema('Houve um erro na gravação com a mensagem: ' + vloCRUDMensal.MensagemExcept +
                                    ', na Classe: ' + vloCRUDMensal.ClasseExcept);
      Abort;
      end;

   FDApuracaoMensal.Next;
   end;

//if vloFuncoes.fncMessageDlgDefult('Apuração gravada com sucesso, Deseja Emitir o DARF dos impostos?',
//                                  mtConfirmation, mbYesNo, 1, MB_DEFBUTTON2, True) = mrYes then
//   begin
//   FDApuracaoMensal.First;
//
//   while not FDApuracaoMensal.Eof do
//      begin
//      FDEmpresa          := TConsultas.fncConsultaDadosEmpresa(vgEmpresa, vgConexao);
//      poVariaveis.vgsPeriodoApuracao := TProcessamento.fncRetornaDataFinal(edtMes.Value, StrToInt(edtAnoMensal.Text));
//      poVariaveis.vgsCPFCNPJ	       := FDEmpresa.FieldByName('EMP_CGC').AsString;
//      poVariaveis.vgsReferencia      := '';
//      poVariaveis.vgsVencimento      := FormatDateTime('dd/mm/yyyy', StrToDate(poVariaveis.vgsPeriodoApuracao) + 10);
//      poVariaveis.vgsNomeImposto     := FDApuracaoMensalImposto.AsString;
//      if Trim(poVariaveis.vgsNomeImposto) = 'PIS' then
//         poVariaveis.vgsCodReceita   := '8109'
//      else
//         poVariaveis.vgsCodReceita   := '2172';
//
//      poVariaveis.vgsNome	           := FDEmpresa.FieldByName('EMP_DESCRICAO').AsString + #13 + FDEmpresa.FieldByName('EMP_TELEFONE').AsString;
//      poVariaveis.vgdValorPrincipal  := FDApuracaoMensalValorImposto.AsFloat;
//      poVariaveis.vgdMulta	         := 0;
//      poVariaveis.vgdJuros	         := 0;
//      poVariaveis.vgdTotal	         := poVariaveis.vgdValorPrincipal + (poVariaveis.vgdMulta + poVariaveis.vgdJuros);
//      poVariaveis.vgsCodigoBarra     := '4561237894564561237894564561237894564561237894';
//
//      if FileExists(ExtractFilePath(Application.ExeName) + 'Relatorios\GuiaImposto.fr3') then
//         begin
//         TRelatorios.pcdGeraDadosImprimirImposto(poVariaveis, DMPrincipal.FDDARF);
//         DMPrincipal.frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Relatorios\GuiaImposto.fr3');
//         DMPrincipal.frxReport1.ShowReport(True);
//         end
//      else
//         begin
//         vloFuncoes.fncMensagemSistema('O DARF não foi localizado em: ' + ExtractFilePath(Application.ExeName) + 'Relatorios\'+
//                                       ', copie o arquivo GuiaImposto.fr3 para o local indicado');
//         Abort;
//         end;
//
//      FDApuracaoMensal.Next;
//      end;
//
//   end;

finally
   FreeAndNil(vloCRUDMensal);
   FreeAndNil(FDEmpresa);
   FDApuracaoMensal.EnableControls;
   FDApuracaoMensal.First;
   pcdVoltar;
   end;
end;

procedure TFImpostos.BitBtn1Click(Sender: TObject);
begin
pcdVoltar;
end;

procedure TFImpostos.btnConfigurarClick(Sender: TObject);
begin
Paletas(tsConfiguracao);
pcdCarregaTIPONF(vgEmpresa);
pcdCarregaDadosExistentes(vgEmpresa);
chkTipoNF.SetFocus;
end;

procedure TFImpostos.btnImpostosClick(Sender: TObject);
begin
Paletas(tsImpostos);
PageControl2.ActivePage := tsApuraMensal;

if edtMes.CanFocus then
   edtMes.SetFocus;
end;

procedure TFImpostos.btnImpostoTri_GravarClick(Sender: TObject);
var
   vloCRUDTrimestral : TCRUDApuracaoTrimestral;
begin
vloCRUDTrimestral := TCRUDApuracaoTrimestral.Create(vgConexao);
try
FDApuracaoTrimestral.DisableControls;
FDApuracaoTrimestral.First;
while not FDApuracaoTrimestral.Eof do
   begin
   vloCRUDTrimestral.AITRIMES_EMPRESA         := vgEmpresa;
   vloCRUDTrimestral.AITRIMES_TRIMESTRE       := edtTrimestre.Value;
   vloCRUDTrimestral.AITRIMES_ANO             := edtAnoTrimestre.Text;
   vloCRUDTrimestral.AITRIMES_IMPOSTO         := FDApuracaoTrimestralImposto.AsString;
   vloCRUDTrimestral.AITRIMES_RECEITABRUTA    := FDApuracaoTrimestralValorApurado.AsFloat;
   vloCRUDTrimestral.AITRIMES_RECEITAALTERADA := FDApuracaoTrimestralBaseCalculo.AsFloat;

   if Trim(FDApuracaoTrimestralImposto.AsString) = 'IRPJ' then
      begin
      vloCRUDTrimestral.AITRIMES_ALIQIMPOSTO  := TConsultas.fncConsultaAliquotaIRPJ(vgEmpresa, vgConexao);
      vloCRUDTrimestral.AITRIMES_PRESIMPOSTO  := TConsultas.fncConsultaPresuncaoIRPJ(vgEmpresa, vgConexao);
      vloCRUDTrimestral.AITRIMES_ADICIONALIRPJ:= FDApuracaoTrimestralAdicionalIRPJ.AsFloat;
      vloCRUDTrimestral.AITRIMES_RETENCAOIMPOSTO := edtDeducaoIRPJ.Value;
      end
   else
      begin
      vloCRUDTrimestral.AITRIMES_ALIQIMPOSTO  := TConsultas.fncConsultaAliquotaCSLL(vgEmpresa, vgConexao);
      vloCRUDTrimestral.AITRIMES_PRESIMPOSTO  := TConsultas.fncConsultaPresuncaoCSLL(vgEmpresa, vgConexao);
      vloCRUDTrimestral.AITRIMES_ADICIONALIRPJ:= 0;
      vloCRUDTrimestral.AITRIMES_RETENCAOIMPOSTO := edtDeducaoCSLL.Value;
      end;

   vloCRUDTrimestral.AITRIMES_RECEITAFINANC   := edtReceitaFinanc.Value;
   vloCRUDTrimestral.AITRIMES_VALORIMPOSTO    := FDApuracaoTrimestralValorImposto.AsFloat;

   if not vloCRUDTrimestral.fncGravarApuracaoTrimestral then
      begin
      vloFuncoes.fncMensagemSistema('Houve um erro na gravação com a mensagem: ' + vloCRUDTrimestral.MensagemExcept +
                                    ', na Classe: ' + vloCRUDTrimestral.ClasseExcept);
      Abort;
      end;

   FDApuracaoTrimestral.Next;
   end;

finally
   FreeAndNil(vloCRUDTrimestral);
   FDApuracaoTrimestral.EnableControls;
   FDApuracaoTrimestral.First;
   pcdVoltar;
   end;
end;

procedure TFImpostos.btnImpostoTri_VoltarClick(Sender: TObject);
begin
pcdVoltar;
end;

procedure TFImpostos.btnImposto_VoltarClick(Sender: TObject);
begin
pcdVoltar;
end;

procedure TFImpostos.btnProcessaMensalClick(Sender: TObject);
var
   vlTipos : String;
   I: Integer;
begin
if (edtMes.Text = '') then
   begin
   vloFuncoes.fncMensagemSistema('O valor do Mês é inválido, verifique!');
   edtMes.SetFocus;
   Abort;
   end;

if Trim(edtAnoMensal.Text) = '' then
   begin
   vloFuncoes.fncMensagemSistema('O valor do Ano é inválido, verifique!');
   edtAnoMensal.SetFocus;
   Abort;
   end;

if not FDApuracaoMensal.Active then
   FDApuracaoMensal.Active := True;

vgbInserir := True;
vlTipos := '';

for I := Low(vgsTiposSelecionados) to High(vgsTiposSelecionados) do
   begin
   if Trim(vlTipos) = '' then
      vlTipos := QuotedStr(vgsTiposSelecionados[I])
   else
      vlTipos := vlTipos + ',' + QuotedStr(vgsTiposSelecionados[I]);
   end;

TProcessamento.vgTipoSelecionados := vlTipos;
TProcessamento.fncProcessaMes(vgEmpresa, edtMes.Value, edtAnoMensal.Text, FDApuracaoMensal, vgConexao);

TFloatField(FDApuracaoMensal.FieldByName('VALORAPURADO')).DisplayFormat := ',0.00';
FDApuracaoMensal.FieldByName('VALORAPURADO').EditMask := ',0.00';
TFloatField(FDApuracaoMensal.FieldByName('BASECALCULO')).DisplayFormat := ',0.00';
TFloatField(FDApuracaoMensal.FieldByName('VALORIMPOSTO')).DisplayFormat := ',0.00';
FDApuracaoMensal.FieldByName('VALORIMPOSTO').EditMask := ',0.00';
TFloatField(FDApuracaoMensal.FieldByName('ALIQUOTA')).DisplayFormat := ',0.00';
FDApuracaoMensal.FieldByName('ALIQUOTA').EditMask := ',0.00';

FDApuracaoMensal.First;
vgdBaseCalculo       := FDApuracaoMensalBaseCalculo.AsFloat;
vgbInserir           := False;
dbImpostosMensal.SelectedIndex := 2;
dbImpostosMensal.SetFocus;
end;

procedure TFImpostos.btnProcessaTrimestralClick(Sender: TObject);
var
   vlTipos : String;
   I: Integer;
begin
if (edtTrimestre.Text = '') then
   begin
   vloFuncoes.fncMensagemSistema('O valor do Trimestre é inválido, verifique!');
   edtTrimestre.SetFocus;
   Abort;
   end;

if Trim(edtAnoTrimestre.Text) = '' then
   begin
   vloFuncoes.fncMensagemSistema('O valor do Ano é inválido, verifique!');
   edtAnoTrimestre.SetFocus;
   Abort;
   end;

if not FDApuracaoTrimestral.Active then
   FDApuracaoTrimestral.Active := True;

vgbInserir := True;
vlTipos := '';

for I := Low(vgsTiposSelecionados) to High(vgsTiposSelecionados) do
   begin
   if Trim(vlTipos) = '' then
      vlTipos := QuotedStr(vgsTiposSelecionados[I])
   else
      vlTipos := vlTipos + ',' + QuotedStr(vgsTiposSelecionados[I]);
   end;

TProcessamento.vgbRecalcula               := False;
TProcessamento.vgTipoSelecionados         := vlTipos;
TProcessamento.vgdValorDigitadoTrimestral := 0;
TProcessamento.fncProcessaTrimestre(vgEmpresa, edtTrimestre.Value, edtAnoTrimestre.Text, FDApuracaoTrimestral, edtDeducaoCSLL.Value, edtDeducaoIRPJ.Value, edtReceitaFinanc.Value, vgConexao);
pcdEditaFormatoTabelaTrimestral;

FDApuracaoTrimestral.First;
vgdBaseCalculo := FDApuracaoTrimestralBaseCalculo.AsFloat;
vgbInserir     := False;
dbImpostosTrimestral.SelectedIndex := 2;
dbImpostosTrimestral.SetFocus;
end;

procedure TFImpostos.btnRecalculaClick(Sender: TObject);
begin
RecalculaImpostoMensal;
end;

procedure TFImpostos.btnRecalcularTrimestreClick(Sender: TObject);
var
   Recno, I : integer;
begin
try
Recno := FDApuracaoTrimestral.RecNo;
FDApuracaoTrimestral.DisableControls;
FDApuracaoTrimestral.First;
pcdAtualizaValorBaseCalculoTrimestral;

if FDApuracaoTrimestral.FieldByName('VALORAPURADO').AsFloat <> FDApuracaoTrimestral.FieldByName('BASECALCULO').AsFloat then
   begin
   vgbInserir := True;
   TProcessamento.vgTipoSelecionados         := '';
   TProcessamento.vgdValorDigitadoTrimestral := FDApuracaoTrimestral.FieldByName('BaseCalculo').AsFloat;
   TProcessamento.fncProcessaTrimestre(vgEmpresa, edtTrimestre.Value, edtAnoTrimestre.Text, FDApuracaoTrimestral, edtDeducaoCSLL.Value, edtDeducaoIRPJ.Value, edtReceitaFinanc.Value, vgConexao);
   pcdEditaFormatoTabelaTrimestral;

   FDApuracaoTrimestral.First;
   vgdBaseCalculo := FDApuracaoMensalBaseCalculo.AsFloat;
   vgbInserir     := False;
   dbImpostosTrimestral.SelectedIndex := 2;
   dbImpostosTrimestral.SetFocus;
   end;

FDApuracaoTrimestral.RecNo := Recno;
finally
   FDApuracaoTrimestral.EnableControls;
   end;
end;

procedure TFImpostos.btnRelatoriosClick(Sender: TObject);
begin
Paletas(tsRelatorios);
end;

procedure TFImpostos.btnsairClick(Sender: TObject);
begin
Close;
end;

procedure TFImpostos.btnVoltarConfClick(Sender: TObject);
begin
pcdVoltar;
end;

procedure TFImpostos.dbImpostosMensalExit(Sender: TObject);
begin
RecalculaImpostoMensal;
end;

procedure TFImpostos.dbImpostosTrimestralExit(Sender: TObject);
begin
RecalculaImpostoTrimestral;
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

procedure TFImpostos.edtConsultaMensal_AnoExit(Sender: TObject);
begin
if ((Trim(edtConsultaMensal_Mes.Text) <> '') and
    (Trim(edtConsultaMensal_Ano.Text) <> '')) then
   begin
   FDMensal.Filtered := False;
   FDMensal.Filter   := 'Mes = ' + QuotedStr(FormatFloat('00', edtConsultaMensal_Mes.Value)) + ' and ' +
                        'Ano = ' + QuotedStr(edtConsultaMensal_Ano.Text);
   FDMensal.Filtered := True;
   end;
end;

procedure TFImpostos.edtConsultaMensal_MesEnter(Sender: TObject);
begin
FDMensal.Filtered := False;
edtConsultaMensal_Ano.Clear;
end;

procedure TFImpostos.edtConsultaTrimestral_AnoExit(Sender: TObject);
begin
if ((Trim(edtConsultaTrimestral_Trimestre.Text) <> '') and
    (Trim(edtConsultaTrimestral_Ano.Text) <> '')) then
   begin
   FDTrimestral.Filtered := False;
   FDTrimestral.Filter   := 'Trimestre = ' + QuotedStr(FormatFloat('0', edtConsultaTrimestral_Trimestre.Value)) + ' and ' +
                            'Ano = ' + QuotedStr(edtConsultaTrimestral_Ano.Text);
   FDTrimestral.Filtered := True;
   end;
end;

procedure TFImpostos.edtConsultaTrimestral_TrimestreEnter(Sender: TObject);
begin
FDTrimestral.Filtered := False;
edtConsultaTrimestral_Ano.Clear;
end;

procedure TFImpostos.edtPresuncaoCSLLExit(Sender: TObject);
begin
pcdValidaValorMaximoEdit(edtPresuncaoCSLL, 100);
end;

procedure TFImpostos.edtPresuncaoIRPJExit(Sender: TObject);
begin
pcdValidaValorMaximoEdit(edtPresuncaoIRPJ, 100);
end;

procedure TFImpostos.FDApuracaoMensalAfterInsert(DataSet: TDataSet);
begin
if not vgbInserir then
   begin
   DataSet.Cancel;
   abort;
   end;
end;

procedure TFImpostos.FDApuracaoTrimestralAfterInsert(DataSet: TDataSet);
begin
if not vgbInserir then
   begin
   DataSet.Cancel;
   abort;
   end;
end;

procedure TFImpostos.FDMensalAfterInsert(DataSet: TDataSet);
begin
if not vgbInserir then
   begin
   DataSet.Cancel;
   abort;
   end;
end;

procedure TFImpostos.FDTrimestralAfterInsert(DataSet: TDataSet);
begin
if not vgbInserir then
   begin
   DataSet.Cancel;
   abort;
   end;
end;

procedure TFImpostos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
if Assigned(vloConexao) then
   FreeAndNil(vloConexao);

if Assigned(vloFuncoes) then
   FreeAndNil(vloFuncoes);
end;

procedure TFImpostos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if ((Key = VK_F2) and (PageControl1.ActivePage = tsConfiguracao)) then
   btnGravarConfClick(Sender);
if ((Key = VK_F3) and (PageControl1.ActivePage = tsPrincipal) and (btnConfigurar.Enabled)) then
   btnConfigurarClick(Sender)
else if ((Key = VK_F3) and (PageControl1.ActivePage = tsImpostos)) then
   PageControl2.ActivePage := tsApuraMensal;
if ((Key = VK_F4) and (PageControl1.ActivePage = tsPrincipal) and (btnImpostos.Enabled)) then
   btnImpostosClick(Sender)
else if ((Key = VK_F4) and (PageControl1.ActivePage = tsImpostos)) then
   PageControl2.ActivePage := tsApuraTrimestral;
if ((Key = VK_F5) and (btnRelatorios.Enabled)) then
   btnRelatoriosClick(Sender);
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
   if (PageControl1.ActivePage = tsConfiguracao) and (btnVoltarConf.Enabled) then
      begin
      btnVoltarConfClick(Sender);
      end
   else if PageControl1.ActivePage <> tsPrincipal then
      begin
      pcdVoltar;
      end
   else
      btnSairClick(Sender);
   end;
end;

procedure TFImpostos.FormShow(Sender: TObject);
begin
vloConexao := TConexaoXE8.Create;
vgConexao  := vloConexao.getConnection;
vloFuncoes := TFuncoesGerais.Create(vgConexao);
vgEmpresa  := '01';
vloFuncoes.pcdPadronizaDbGrid(dbMensal);
vloFuncoes.pcdPadronizaDbGrid(dbTrimestral);
pcdCarregaVetorTipos(vgEmpresa);
pcdCarregaDadosTelaInicial;
StatusBar1.Panels[0].Text := 'Empresa: ' + vgEmpresa + ' - ' + TConsultas.fncConsultaDescricaoEmpresa(vgEmpresa, vgConexao);
Paletas(tsPrincipal);
edtConsultaMensal_Mes.SetFocus;
end;

procedure TFImpostos.HabilitaPaletas(vPaleta: TTabSheet);
begin
tsConfiguracao.TabVisible := vPaleta = tsConfiguracao;
tsImpostos.TabVisible     := vPaleta = tsImpostos;
tsRelatorios.TabVisible   := vPaleta = tsRelatorios;
tsPrincipal.TabVisible    := vPaleta = tsPrincipal;
end;

procedure TFImpostos.ImpressoDARF1Click(Sender: TObject);
begin
pcdImpressaoDARFMensal;
end;

procedure TFImpostos.ImpressodoDARF1Click(Sender: TObject);
begin
//Apuração Trimestral
end;

procedure TFImpostos.Paletas(vPaleta: TTabSheet);
begin
if vPaleta = tsConfiguracao then
   HabilitaBotoes(btnConfigurar)
else if vPaleta = tsImpostos then
   HabilitaBotoes(btnImpostos)
else if vPaleta = tsRelatorios then
   HabilitaBotoes(btnRelatorios)
else if vPaleta = tsPrincipal then
   begin
   btnConfigurar.Enabled := True;
   btnImpostos.Enabled   := True;
   btnRelatorios.Enabled := True;
   end;

HabilitaPaletas(vPaleta);
end;

procedure TFImpostos.pcdCarregaVetorTipos(psEmpresa: String);
var
   vloConfiguracao : TConfiguracao;
   FDConfig : TFDQuery;
   vlsTipo : String;
   I: Integer;
begin
vloConfiguracao := TConfiguracao.Create(vgConexao);
vloFuncoes.pcdCriaFDQueryExecucao(FDConfig, vgConexao);
try
FDConfig := vloConfiguracao.fncCarregaDadosExistentes(vgEmpresa);

if not FDConfig.IsEmpty then
   begin
   vgsTiposSelecionados     := fncRetornaArrayTipo(FDConfig.FieldByName('CONFAI_TIPOSNF').AsString);
   end;
finally
   FreeAndNil(FDConfig);
   FreeAndNil(vloConfiguracao);
   end;
end;

procedure TFImpostos.pcdCarregaDadosExistentes(psEmpresa: String);
var
   vloConfiguracao : TConfiguracao;
   FDConfig : TFDQuery;
   vlsTipo : String;
   I: Integer;
begin
vloConfiguracao := TConfiguracao.Create(vgConexao);
vloFuncoes.pcdCriaFDQueryExecucao(FDConfig, vgConexao);
try
FDConfig := vloConfiguracao.fncCarregaDadosExistentes(vgEmpresa);

if not FDConfig.IsEmpty then
   begin
   if vgsTiposSelecionados = nil then
      vgsTiposSelecionados     := fncRetornaArrayTipo(FDConfig.FieldByName('CONFAI_TIPOSNF').AsString);

   for I := Low(vgsTiposSelecionados) to High(vgsTiposSelecionados) do
      begin
      chkTipoNF.Checked[chkTipoNF.Items.IndexOf(vgsTiposSelecionados[I])] := True;
      end;

   edtAliquotaPIS.Value    := FDConfig.FieldByName('CONFAI_ALIQPIS').AsFloat;
   edtAliquotaCOFINS.Value := FDConfig.FieldByName('CONFAI_ALIQCOFINS').AsFloat;
   edtAliquotaCSLL.Value   := FDConfig.FieldByName('CONFAI_ALIQCSLL').AsFloat;
   edtAliquotaIRPJ.Value   := FDConfig.FieldByName('CONFAI_ALIQIRPJ').AsFloat;
   edtPresuncaoCSLL.Value  := FDConfig.FieldByName('CONFAI_PRESCSLL').AsFloat;
   edtPresuncaoIRPJ.Value  := FDConfig.FieldByName('CONFAI_PRESIRPJ').AsFloat;
   end
else
   begin
   edtAliquotaPIS.Value    := 0;
   edtAliquotaCOFINS.Value := 0;
   edtAliquotaCSLL.Value   := 0;
   edtAliquotaIRPJ.Value   := 0;
   edtPresuncaoCSLL.Value  := 0;
   edtPresuncaoIRPJ.Value  := 0;
   end;


finally
   FreeAndNil(FDConfig);
   FreeAndNil(vloConfiguracao);
   end;
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
   vloFuncoes.fncMensagemSistema('Valor máximo permito é de '+IntToStr(piValorMaximo)+', verifique!');
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

function TFImpostos.fncRetornaArrayTipo(psTipo : String) : TVetorString;
var
   vloArray : TVetorString;
   vlTexto  : String;
   vlTestes : Double;
   vli      : Integer;
begin
if Trim(psTipo) <> '' then
   begin
   vlTexto  := fncRemoveVirgulaEspacao(psTipo);
   vlTestes := Length(vlTexto)/2;
   SetLength(vloArray, Trunc(Length(vlTexto)/2));

   for vli := Low(vloArray) to High(vloArray) do
      begin
      vloArray[vli] := Copy(vlTexto, (vli * 2) + 1, 2);
      end;
   end;

Result := vloArray;
end;

function TFImpostos.fncRemoveVirgulaEspacao(psTexto: String) : String;
var
  vli: Integer;
  vlTexto : String;
begin
for vli := 1 to Length(psTexto) do
   begin
   if ((Copy(psTexto, vli, 1) <> ',') AND
       (Copy(psTexto, vli, 1) <> '')) then
      vlTexto := Trim(vlTexto) + Copy(psTexto, vli, 1);
   end;

Result := vlTexto;
end;

procedure TFImpostos.pcdAtualizaValorBaseCalculoMensal;
var
   vldValorAtual: Double;
   vliValorAlterar : Integer;
begin
FDApuracaoMensal.First;
vldValorAtual := 0;

while not FDApuracaoMensal.Eof do
   begin
   if FDApuracaoMensal.FieldByName('BaseCalculo').AsFloat = vgdBaseCalculo then
      vliValorAlterar := FDApuracaoMensal.RecNo
   else
      vldValorAtual      := FDApuracaoMensal.FieldByName('BaseCalculo').AsFloat;

   FDApuracaoMensal.Next;
   end;

if vldValorAtual <> 0 then
   begin
   FDApuracaoMensal.RecNo := vliValorAlterar;
   FDApuracaoMensal.Edit;
   FDApuracaoMensal.FieldByName('BaseCalculo').AsFloat := vldValorAtual;
   FDApuracaoMensal.Post;

   vgdBaseCalculo := vldValorAtual;
   end;
end;

procedure TFImpostos.pcdAtualizaValorBaseCalculoTrimestral;
var
   vldValorAtual: Double;
   vliValorAlterar : Integer;
begin
FDApuracaoTrimestral.First;
vldValorAtual := 0;

while not FDApuracaoTrimestral.Eof do
   begin
   if FDApuracaoTrimestral.FieldByName('BaseCalculo').AsFloat = vgdBaseCalculo then
      vliValorAlterar := FDApuracaoTrimestral.RecNo
   else
      vldValorAtual      := FDApuracaoTrimestral.FieldByName('BaseCalculo').AsFloat;

   FDApuracaoTrimestral.Next;
   end;

if vldValorAtual <> 0 then
   begin
   FDApuracaoTrimestral.RecNo := vliValorAlterar;
   FDApuracaoTrimestral.Edit;
   FDApuracaoTrimestral.FieldByName('BaseCalculo').AsFloat := vldValorAtual;
   FDApuracaoTrimestral.Post;

   vgdBaseCalculo := vldValorAtual;
   end;
end;

procedure TFImpostos.pcdEditaFormatoTabelaTrimestral;
begin
TFloatField(FDApuracaoTrimestral.FieldByName('ReceitaFinac')).DisplayFormat := ',0.00';
FDApuracaoTrimestral.FieldByName('ReceitaFinac').EditMask := ',0.00';
TFloatField(FDApuracaoTrimestral.FieldByName('BaseCalculo')).DisplayFormat := ',0.00';
TFloatField(FDApuracaoTrimestral.FieldByName('AdicionalIRPJ')).DisplayFormat := ',0.00';
FDApuracaoTrimestral.FieldByName('AdicionalIRPJ').EditMask := ',0.00';
TFloatField(FDApuracaoTrimestral.FieldByName('DeducoesImposto')).DisplayFormat := ',0.00';
FDApuracaoTrimestral.FieldByName('DeducoesImposto').EditMask := ',0.00';
TFloatField(FDApuracaoTrimestral.FieldByName('ValorImposto')).DisplayFormat := ',0.00';
FDApuracaoTrimestral.FieldByName('ValorImposto').EditMask := ',0.00';
TFloatField(FDApuracaoTrimestral.FieldByName('BaseImposto')).DisplayFormat := ',0.00';
FDApuracaoTrimestral.FieldByName('BaseImposto').EditMask := ',0.00';
TFloatField(FDApuracaoTrimestral.FieldByName('ValorApurado')).DisplayFormat := ',0.00';
FDApuracaoTrimestral.FieldByName('ValorApurado').EditMask := ',0.00';
end;

procedure TFImpostos.RecalculaImpostoMensal;
var
   Recno : integer;
begin
try
Recno := FDApuracaoMensal.RecNo;
FDApuracaoMensal.DisableControls;
pcdAtualizaValorBaseCalculoMensal;
FDApuracaoMensal.First;
while not FDApuracaoMensal.Eof do
   begin
   if FDApuracaoMensal.FieldByName('VALORAPURADO').AsFloat <> FDApuracaoMensal.FieldByName('BASECALCULO').AsFloat then
      begin
      FDApuracaoMensal.Edit;
      FDApuracaoMensal.FieldByName('VALORIMPOSTO').AsFloat := FDApuracaoMensal.FieldByName('BASECALCULO').AsFloat *
                                                             (FDApuracaoMensal.FieldByName('ALIQUOTA').AsFloat / 100);
      FDApuracaoMensal.Post;
      end;
   FDApuracaoMensal.Next;
   end;
FDApuracaoMensal.RecNo := Recno;
finally
   FDApuracaoMensal.EnableControls;
   end;
end;

procedure TFImpostos.RecalculaImpostoTrimestral;
var
   Recno, I : integer;
begin
try
Recno := FDApuracaoTrimestral.RecNo;
FDApuracaoTrimestral.DisableControls;
FDApuracaoTrimestral.First;
pcdAtualizaValorBaseCalculoTrimestral;

if FDApuracaoTrimestral.FieldByName('VALORAPURADO').AsFloat <> FDApuracaoTrimestral.FieldByName('BASECALCULO').AsFloat then
   begin
   vgbInserir := True;
   TProcessamento.vgbRecalcula               := True;
   TProcessamento.vgTipoSelecionados         := '';
   TProcessamento.vgdValorDigitadoTrimestral := FDApuracaoTrimestral.FieldByName('BaseCalculo').AsFloat;
   TProcessamento.fncProcessaTrimestre(vgEmpresa, edtTrimestre.Value, edtAnoTrimestre.Text, FDApuracaoTrimestral, edtDeducaoCSLL.Value, edtDeducaoIRPJ.Value, edtReceitaFinanc.Value, vgConexao);
   pcdEditaFormatoTabelaTrimestral;

   FDApuracaoTrimestral.First;
   vgdBaseCalculo := FDApuracaoMensalBaseCalculo.AsFloat;
   vgbInserir     := False;
   dbImpostosTrimestral.SelectedIndex := 2;
   dbImpostosTrimestral.SetFocus;
   end;

FDApuracaoTrimestral.RecNo := Recno;
finally
   FDApuracaoTrimestral.EnableControls;
   end;
end;

procedure TFImpostos.pcdCarregaDadosMensal;
var
   FDConsMensal : TFDQuery;
begin
vloFuncoes.pcdCriaFDQueryExecucao(FDConsMensal, vgConexao);
try
FDConsMensal := TConsultas.fncConsultaDadosApuracaoMensal(vgEmpresa, vgConexao);
vgbInserir   := True;
if not FDMensal.Active then
   FDMensal.Active := True;

FDMensal.EmptyDataSet;
FDConsMensal.First;
while not FDConsMensal.Eof do
   begin
   FDMensal.Append;
   FDMensalEmpresa.AsString        := FDConsMensal.FieldByName('AIMES_EMPRESA').AsString;
   FDMensalImposto.AsString        := FDConsMensal.FieldByName('AIMES_IMPOSTO').AsString;
   FDMensalMes.AsString            := FDConsMensal.FieldByName('AIMES_MES').AsString;
   FDMensalAno.AsString            := FDConsMensal.FieldByName('AIMES_ANO').AsString;
   FDMensalReceitaBruta.AsFloat    := FDConsMensal.FieldByName('AIMES_RECEITABRUTA').AsFloat;
   FDMensalReceitaAlterada.AsFloat := FDConsMensal.FieldByName('AIMES_RECEITAALTERADA').AsFloat;
   FDMensalAliqImposto.AsFloat     := FDConsMensal.FieldByName('AIMES_ALIQUOTAIMPOSTO').AsFloat;
   FDMensalValorImposto.AsFloat    := FDConsMensal.FieldByName('AIMES_VALORIMPOSTO').AsFloat;
   FDMensal.Post;

   FDConsMensal.Next;
   end;

TFloatField(FDMensal.FieldByName('RECEITABRUTA')).DisplayFormat := ',0.00';
FDMensal.FieldByName('RECEITABRUTA').EditMask := ',0.00';

TFloatField(FDMensal.FieldByName('RECEITAALTERADA')).DisplayFormat := ',0.00';
FDMensal.FieldByName('RECEITAALTERADA').EditMask := ',0.00';

TFloatField(FDMensal.FieldByName('ALIQIMPOSTO')).DisplayFormat := ',0.00';
FDMensal.FieldByName('ALIQIMPOSTO').EditMask := ',0.00';

TFloatField(FDMensal.FieldByName('VALORIMPOSTO')).DisplayFormat := ',0.00';
FDMensal.FieldByName('VALORIMPOSTO').EditMask := ',0.00';

finally
   FreeAndNil(FDConsMensal);
   vgbInserir   := False;
   end;
end;

procedure TFImpostos.pcdCarregaDadosTrimestral;
var
   FDConsTrimestral : TFDQuery;
begin
vloFuncoes.pcdCriaFDQueryExecucao(FDConsTrimestral, vgConexao);
try
FDConsTrimestral := TConsultas.fncConsultaDadosApuracaoTrimestral(vgEmpresa, vgConexao);
vgbInserir       := True;
if not FDTrimestral.Active then
   FDTrimestral.Active := True;

FDTrimestral.EmptyDataSet;
FDConsTrimestral.First;
while not FDConsTrimestral.Eof do
   begin
   FDTrimestral.Append;
   FDTrimestralEmpresa.AsString        := FDConsTrimestral.FieldByName('AITRIMES_EMPRESA').AsString;
   FDTrimestralImposto.AsString        := FDConsTrimestral.FieldByName('AITRIMES_IMPOSTO').AsString;
   FDTrimestralTrimestre.AsString      := FDConsTrimestral.FieldByName('AITRIMES_TRIMESTRE').AsString;
   FDTrimestralAno.AsString            := FDConsTrimestral.FieldByName('AITRIMES_ANO').AsString;
   FDTrimestralReceitaBruta.AsFloat    := FDConsTrimestral.FieldByName('AITRIMES_RECEITABRUTA').AsFloat;
   FDTrimestralReceitaAlterada.AsFloat := FDConsTrimestral.FieldByName('AITRIMES_RECEITAALTERADA').AsFloat;
   FDTrimestralAliqImposto.AsFloat     := FDConsTrimestral.FieldByName('AITRIMES_ALIQIMPOSTO').AsFloat;
   FDTrimestralValorImposto.AsFloat    := FDConsTrimestral.FieldByName('AITRIMES_VALORIMPOSTO').AsFloat;

   if FDConsTrimestral.FieldByName('AITRIMES_IMPOSTO').AsString = 'IRPJ' then
      begin
      FDTrimestralRetencoes.AsFloat := FDConsTrimestral.FieldByName('AITRIMES_RETENCAOIMPOSTO').AsFloat;
      FDTrimestralAdicionalIRPJ.AsFloat:= FDConsTrimestral.FieldByName('AITRIMES_ADICIONALIRPJ').AsFloat;
      end
   else
      begin
      FDTrimestralRetencoes.AsFloat := FDConsTrimestral.FieldByName('AITRIMES_RETENCAOIMPOSTO').AsFloat;
      FDTrimestralAdicionalIRPJ.AsFloat:= 0;
      end;

   FDTrimestral.Post;
   FDConsTrimestral.Next;
   end;

TFloatField(FDTrimestral.FieldByName('RECEITABRUTA')).DisplayFormat := ',0.00';
FDTrimestral.FieldByName('RECEITABRUTA').EditMask := ',0.00';

TFloatField(FDTrimestral.FieldByName('RECEITAALTERADA')).DisplayFormat := ',0.00';
FDTrimestral.FieldByName('RECEITAALTERADA').EditMask := ',0.00';

TFloatField(FDTrimestral.FieldByName('ALIQIMPOSTO')).DisplayFormat := ',0.00';
FDTrimestral.FieldByName('ALIQIMPOSTO').EditMask := ',0.00';

TFloatField(FDTrimestral.FieldByName('VALORIMPOSTO')).DisplayFormat := ',0.00';
FDTrimestral.FieldByName('VALORIMPOSTO').EditMask := ',0.00';

TFloatField(FDTrimestral.FieldByName('RETENCOES')).DisplayFormat := ',0.00';
FDTrimestral.FieldByName('RETENCOES').EditMask := ',0.00';

TFloatField(FDTrimestral.FieldByName('ADICIONALIRPJ')).DisplayFormat := ',0.00';
FDTrimestral.FieldByName('ADICIONALIRPJ').EditMask := ',0.00';

finally
   FreeAndNil(FDConsTrimestral);
   vgbInserir   := False;
   end;
end;

procedure TFImpostos.pcdVoltar;
begin
Paletas(tsPrincipal);
pcdCarregaDadosTelaInicial;
end;

procedure TFImpostos.pcdImpressaoDARFMensal;
var
   FDEmpresa         : TFDQuery;
   poVariaveis       : TVariaveisRelatorioImposto;
begin
vloFuncoes.pcdCriaFDQueryExecucao(FDEmpresa, vgConexao);
try
if FDMensalValorImposto.AsFloat > ValorMinimoPagamentoDARFMensal then
   begin
   FDEmpresa                      := TConsultas.fncConsultaDadosEmpresa(vgEmpresa, vgConexao);
   poVariaveis.vgsPeriodoApuracao := TProcessamento.fncRetornaDataFinal(FDMensalMes.AsInteger, StrToInt(FDMensalAno.AsString));
   poVariaveis.vgsCPFCNPJ	        := FDEmpresa.FieldByName('EMP_CGC').AsString;
   poVariaveis.vgsNomeImposto     := FDMensalImposto.AsString;
   poVariaveis.vgsDomicioTrib     := FDEmpresa.FieldByName('EMP_CIDADE').AsString;

   if Trim(poVariaveis.vgsNomeImposto) = 'PIS' then
      poVariaveis.vgsCodReceita   := '8109'
   else
      poVariaveis.vgsCodReceita   := '2172';

   poVariaveis.vgsNome	          := FDEmpresa.FieldByName('EMP_DESCRICAO').AsString + #13 + FDEmpresa.FieldByName('EMP_TELEFONE').AsString;
   poVariaveis.vgdValorPrincipal  := FDMensalValorImposto.AsFloat;
   poVariaveis.vgsCodigoBarra     := '4561237894564561237894564561237894564561237894';

   try
   Application.CreateForm(TFComplementos, FComplementos);
   FComplementos.ShowModal;
   finally
      FreeAndNil(FComplementos);
      end;

   poVariaveis.vgsReferencia      := vgsReferencia;
   poVariaveis.vgsVencimento      := FormatDateTime('dd/mm/yyyy', StrToDate(vgsVencimentos));
   poVariaveis.vgdMulta	          := vgdMulta;
   poVariaveis.vgdJuros	          := vgdJuros;
   poVariaveis.vgdTotal	          := poVariaveis.vgdValorPrincipal + (poVariaveis.vgdMulta + poVariaveis.vgdJuros);

   if FileExists(ExtractFilePath(Application.ExeName) + 'Relatorios\GuiaImposto.fr3') then
      begin
      TRelatorios.pcdGeraDadosImprimirImposto(poVariaveis, DMPrincipal.FDDARF);
      DMPrincipal.frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Relatorios\GuiaImposto.fr3');
      DMPrincipal.frxReport1.ShowReport(True);
      end
   else
      begin
      vloFuncoes.fncMensagemSistema('O DARF não foi localizado em: ' + ExtractFilePath(Application.ExeName) + 'Relatorios\'+
                                    ', copie o arquivo GuiaImposto.fr3 para o local indicado');
      Abort;
      end;
   end
else
   begin
   vloFuncoes.fncMensagemSistema('O valor mínimo para arrecadação do DARF é de R$:' + FormatFloat(',0.00', ValorMinimoPagamentoDARFMensal) + '.' + #13 +
                                 'Acumule o valor na apuração do mês seguinte');
   end;

finally
   FreeAndNil(FDEmpresa);
   end;
end;

procedure TFImpostos.pcdImpressaoDARFTrimestral;
var
   FDEmpresa         : TFDQuery;
   poVariaveis       : TVariaveisRelatorioImposto;
begin
vloFuncoes.pcdCriaFDQueryExecucao(FDEmpresa, vgConexao);
try
if FDMensalValorImposto.AsFloat > ValorMinimoPagamentoDARFTrimestral then
   begin
   FDEmpresa                      := TConsultas.fncConsultaDadosEmpresa(vgEmpresa, vgConexao);
//   TProcessamento.pcdApuraMesTrimestre(FDTrimestralTrimestre.AsInteger, FDTrimestralAno.AsString, vgConexao);
   poVariaveis.vgsPeriodoApuracao := TProcessamento.fncRetornaDataFinal(FDMensalMes.AsInteger, StrToInt(FDMensalAno.AsString));
   poVariaveis.vgsCPFCNPJ	        := FDEmpresa.FieldByName('EMP_CGC').AsString;
   poVariaveis.vgsNomeImposto     := FDMensalImposto.AsString;
   poVariaveis.vgsDomicioTrib     := FDEmpresa.FieldByName('EMP_CIDADE').AsString;

   if Trim(poVariaveis.vgsNomeImposto) = 'PIS' then
      poVariaveis.vgsCodReceita   := '8109'
   else
      poVariaveis.vgsCodReceita   := '2172';

   poVariaveis.vgsNome	          := FDEmpresa.FieldByName('EMP_DESCRICAO').AsString + #13 + FDEmpresa.FieldByName('EMP_TELEFONE').AsString;
   poVariaveis.vgdValorPrincipal  := FDMensalValorImposto.AsFloat;
   poVariaveis.vgsCodigoBarra     := '4561237894564561237894564561237894564561237894';

   try
   Application.CreateForm(TFComplementos, FComplementos);
   FComplementos.ShowModal;
   finally
      FreeAndNil(FComplementos);
      end;

   poVariaveis.vgsReferencia      := vgsReferencia;
   poVariaveis.vgsVencimento      := FormatDateTime('dd/mm/yyyy', StrToDate(vgsVencimentos));
   poVariaveis.vgdMulta	          := vgdMulta;
   poVariaveis.vgdJuros	          := vgdJuros;
   poVariaveis.vgdTotal	          := poVariaveis.vgdValorPrincipal + (poVariaveis.vgdMulta + poVariaveis.vgdJuros);

   if FileExists(ExtractFilePath(Application.ExeName) + 'Relatorios\GuiaImposto.fr3') then
      begin
      TRelatorios.pcdGeraDadosImprimirImposto(poVariaveis, DMPrincipal.FDDARF);
      DMPrincipal.frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Relatorios\GuiaImposto.fr3');
      DMPrincipal.frxReport1.ShowReport(True);
      end
   else
      begin
      vloFuncoes.fncMensagemSistema('O DARF não foi localizado em: ' + ExtractFilePath(Application.ExeName) + 'Relatorios\'+
                                    ', copie o arquivo GuiaImposto.fr3 para o local indicado');
      Abort;
      end;
   end
else
   begin
   vloFuncoes.fncMensagemSistema('O valor mínimo para arrecadação do DARF é de R$:' + FormatFloat(',0.00', ValorMinimoPagamentoDARFTrimestral) + '.' + #13 +
                                 'Acumule o valor na apuração do mês seguinte');
   end;

finally
   FreeAndNil(FDEmpresa);
   end;
end;

procedure TFImpostos.pcdCarregaDadosTelaInicial;
begin
pcdCarregaDadosMensal;
pcdCarregaDadosTrimestral;
end;

end.

