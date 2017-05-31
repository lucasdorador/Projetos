unit uFindParametros;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtDlgs,
  Vcl.ExtCtrls, uTDPNumberEditXE8, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.VCLUI.Wait, FireDAC.Comp.UI, uConexaoXE8;

type
  TFFindParametros = class(TForm)
    MPas: TMemo;
    Panel1: TPanel;
    OpenTextFileDialog1: TOpenTextFileDialog;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    BitBtn2: TBitBtn;
    edtCaminho: TEdit;
    chkUtilizaCodigoForm: TCheckBox;
    edtCodigoForm: TDPTNumberEditXE8;
    BitBtn1: TBitBtn;
    FDQuery1: TFDQuery;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    procedure btnBuscaPASClick(Sender: TObject);
    procedure btnExecutaClick(Sender: TObject);
    procedure chkUtilizaCodigoFormClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCaminhoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    vloConexao : TConexaoXE8;
    vgConexao  : TFDConnection;
    function fnclocalizaparametro(s: String): String;
    function pcdValidaParametrosnaPARAMGMODULOS(poStringList: TStringList; psCodigoForm: String): TStringList;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FFindParametros: TFFindParametros;

implementation

{$R *.dfm}

uses uProcessa, uMemoParametros;

procedure TFFindParametros.btnBuscaPASClick(Sender: TObject);
begin
if OpenTextFileDialog1.Execute() then
   begin
   edtCaminho.Text := OpenTextFileDialog1.FileName;

   if FileExists(edtCaminho.Text) then
      begin
      MPas.Lines.Clear;
      MPas.Lines.LoadFromFile(edtCaminho.Text);
      end;

   end;
end;

procedure TFFindParametros.btnExecutaClick(Sender: TObject);
var
  I: Integer;
  vlsTeste : String;
  vlsResult, vlsAuxiliar : TStringList;
begin
vlsResult   := TStringList.Create;
vlsAuxiliar := TStringList.Create;
Application.CreateForm(TFProcessa, FProcessa);
try
FProcessa.GroupBox1.Caption := 'Validando arquivo ' + ExtractFileName(edtCaminho.Text) + ' ... (Linha 01 de '+MPas.Lines.Count.ToString+')';
FProcessa.Gauge1.MaxValue   := MPas.Lines.Count;
FProcessa.Gauge1.Progress   := 0;
FProcessa.Show;
for I := 0 to MPas.Lines.Count - 1 do
   begin
   vlsTeste := Trim(fnclocalizaparametro(MPas.Lines[i]));
   if vlsTeste <> '' then
      begin
      if vlsResult.IndexOf(vlsTeste) < 0 then
         vlsResult.Add(vlsTeste);
      end;

   FProcessa.Gauge1.Progress   := FProcessa.Gauge1.Progress + 1;
   FProcessa.GroupBox1.Caption := 'Validando arquivo ' + ExtractFileName(edtCaminho.Text) + ' ... (Linha '+I.ToString+' de '+MPas.Lines.Count.ToString+')';
   Application.ProcessMessages;
   end;

FProcessa.Close;

if chkUtilizaCodigoForm.Checked then
   begin
   vlsAuxiliar := pcdValidaParametrosnaPARAMGMODULOS(vlsResult, FormatFloat('0000', edtCodigoForm.Value));
   end;

Application.CreateForm(TFMemoParametros, FMemoParametros);

if vlsAuxiliar.Count > 0 then
   FMemoParametros.MParametros.Lines := vlsAuxiliar
else
   FMemoParametros.MParametros.Lines := vlsResult;

FMemoParametros.ShowModal;

finally
   FreeAndNil(FMemoParametros);
   FreeAndNil(vlsResult);
   FreeAndNil(FProcessa);
   end;
end;

procedure TFFindParametros.chkUtilizaCodigoFormClick(Sender: TObject);
begin
GroupBox1.Enabled := chkUtilizaCodigoForm.Checked;
if edtCodigoForm.CanFocus then
   edtCodigoForm.SetFocus;
end;

procedure TFFindParametros.edtCaminhoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Key = VK_F2 then
   btnBuscaPASClick(Sender);
end;

function TFFindParametros.fnclocalizaparametro(s: String): String;
var
   vlResult : String;
   vli: Integer;
begin
vlResult := '';
try
vli := Pos('4.18.', s);

if vli <> 0 then
   vlResult := Copy(s, vli, 8);

finally
   Result := vlResult;
   end;
end;

procedure TFFindParametros.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
Case Key Of
   VK_RETURN : Perform(WM_NEXTDLGCTL, 0, 0);
   VK_F6: btnExecutaClick(Sender);
   VK_ESCAPE: Close;
   End;
end;

procedure TFFindParametros.FormShow(Sender: TObject);
begin
vloConexao := TConexaoXE8.Create('FACILITE');
vgConexao  := vloConexao.getConnection;

chkUtilizaCodigoFormClick(Sender);
if edtCaminho.CanFocus then
   edtCaminho.SetFocus;
end;

function TFFindParametros.pcdValidaParametrosnaPARAMGMODULOS(poStringList: TStringList; psCodigoForm: String): TStringList;
var
   I : Integer;
   vlStringList : TStringList;
begin
vlStringList := TStringList.Create;

FDQuery1.Connection := vgConexao;

if not FDQuery1.Active then
   FDQuery1.Active := True;

try

for I := 0 to poStringList.Count - 1 do
   begin
   if Length(poStringList.Strings[I]) <= 10 then
      begin
      FDQuery1.Close;
      FDQuery1.SQL.Clear;
      FDQuery1.SQL.Add('SELECT * FROM PARAMGMODULOS WHERE PARGM_PARAMETRO = :PARAMETRO AND PARGM_MODULO = :MODULO');
      FDQuery1.ParamByName('PARAMETRO').AsString := poStringList.Strings[I];
      FDQuery1.ParamByName('MODULO').AsString    := psCodigoForm;
      FDQuery1.Open();

      if FDQuery1.IsEmpty then
         vlStringList.Add(poStringList.Strings[I]);
      end;
   end;

finally
   Result := vlStringList;
   end;
end;

end.
