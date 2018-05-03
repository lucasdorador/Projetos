unit UExportaTabela;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.CheckLst, Vcl.Buttons, FireDAc.Comp.Client,
  Vcl.ExtCtrls, System.Win.ComObj, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, Vcl.Samples.Gauges;

type
  TFExportaTabela = class(TForm)
    GroupBox1: TGroupBox;
    CheckListBox1: TCheckListBox;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    FDConsultas: TFDQuery;
    Panel2: TPanel;
    Gauge2: TGauge;
    lbl2: TLabel;
    lbl1: TLabel;
    Gauge1: TGauge;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    PLANILHA : Variant;
    procedure GeraTabelaExcel(vlTabela: String);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FExportaTabela: TFExportaTabela;

implementation

{$R *.dfm}

uses UAtualizacao, UDMPrincipal, ULeScript, UImportaExcel;

procedure TFExportaTabela.BitBtn1Click(Sender: TObject);
var
  I, vliCont: Integer;
  vlbTabelaSelecionada : Boolean;
begin
vlbTabelaSelecionada := False;
PLANILHA := CreateOleObject('Excel.Application');
PLANILHA.Caption := 'Exportanto dados para Tabelas';
PLANILHA.WorkBooks.add;
PLANILHA.Visible := False;
vliCont          := 0;
Panel2.Visible   := True;
lbl1.Caption     := 'Gerando coluna das tabelas ... ';
Gauge1.MaxValue  := CheckListBox1.Items.Count - 1;
try
for I := CheckListBox1.Items.Count - 1 downto 0 do
   begin
   if CheckListBox1.Checked[I] then
      begin
      if vliCont > 0 then
         PLANILHA.Workbooks[1].Sheets.Add;

      vlbTabelaSelecionada := True;
      GeraTabelaExcel(CheckListBox1.Items.Strings[I]);
      Gauge1.Progress := Gauge1.Progress + 1;
      Application.ProcessMessages;
      Inc(vliCont);
      end;
   end;

if vlbTabelaSelecionada then
   PLANILHA.Visible := True
else
   ShowMessage('Nenhuma tabela selecionada!');
finally
   PLANILHA := Unassigned;
   Panel2.Visible   := False;
   end;
end;

procedure TFExportaTabela.BitBtn2Click(Sender: TObject);
begin
Close;
end;

procedure TFExportaTabela.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if (ssCtrl in Shift) and ((Key = Ord('T')) or (Key = Ord('t'))) then
   begin
   if CheckListBox1.Checked[0] then
      CheckListBox1.CheckAll(cbUnchecked)
   else
      CheckListBox1.CheckAll(cbChecked)
   end;
end;

procedure TFExportaTabela.FormShow(Sender: TObject);
var
  I : Integer;
begin
FDConsultas.Close;
FDConsultas.Connection := FLeScript.vgConexao;
try
FDConsultas.SQL.Clear;
FDConsultas.SQL.Add('SELECT RDB$RELATION_NAME FROM RDB$RELATIONS WHERE RDB$VIEW_BLR IS NULL AND (RDB$SYSTEM_FLAG = 0 OR RDB$SYSTEM_FLAG IS NULL) ORDER BY RDB$RELATION_NAME');
FDConsultas.Open;
FDConsultas.First;
CheckListBox1.Items.Clear;
FImportaExcel.gbProgressBar.Visible := True;
FImportaExcel.Gauge1.Progress       := 0;
FImportaExcel.gbProgressBar.Caption := 'Carregando tabelas ... 1 de ' + IntToStr(FDConsultas.RecordCount);
FImportaExcel.Gauge1.MaxValue       := FDConsultas.RecordCount;
I := 1;
Application.ProcessMessages;
while not FDConsultas.Eof do
   begin
   CheckListBox1.Items.Add(FDConsultas.FieldByName('RDB$RELATION_NAME').AsString);
   FDConsultas.Next;
   FImportaExcel.Gauge1.Progress       := FImportaExcel.Gauge1.Progress + 1;
   FImportaExcel.gbProgressBar.Caption := 'Carregando tabelas ... '+IntToStr(I)+' de ' + IntToStr(FDConsultas.RecordCount - 1);
   Application.ProcessMessages;
   Inc(I);
   end;

finally
   FImportaExcel.gbProgressBar.Visible := False;
   end;
end;

procedure TFExportaTabela.GeraTabelaExcel(vlTabela : String);
var
  Coluna : Integer;
Begin
Coluna := 1;
PLANILHA.WorkBooks[1].WorkSheets[1].Name := vlTabela;

FDConsultas.Close;
FDConsultas.SQL.Clear;
FDConsultas.SQL.Add('SELECT RDB$FIELD_NAME AS CAMPOS FROM RDB$RELATION_FIELDS');
FDConsultas.SQL.Add('WHERE RDB$RELATION_NAME = :TABELA');
FDConsultas.SQL.Add('ORDER BY RDB$FIELD_POSITION ');
FDConsultas.ParamByName('TABELA').AsString := vlTabela;
FDConsultas.Open;

lbl2.Caption     := 'Gerando coluna da tabela ' + vlTabela;
Gauge2.MaxValue  := FDConsultas.RecordCount;

// PRENCHIMENTO DAS CÉLULAS COM OS VALORES DOS CAMPOS DA TABELA
While not FDConsultas.Eof do
   Begin
   PLANILHA.Cells[1, Coluna]:= FDConsultas.FieldByName('CAMPOS').AsString;
   Gauge2.Progress := Gauge2.Progress + 1;
   Inc(Coluna);
   FDConsultas.Next;
   End;

PLANILHA.Columns.AutoFit;
End;

end.
