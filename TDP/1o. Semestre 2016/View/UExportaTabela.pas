unit UExportaTabela;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.CheckLst, Vcl.Buttons, FireDAc.Comp.Client,
  Vcl.ExtCtrls, System.Win.ComObj;

type
  TFExportaTabela = class(TForm)
    BitBtn1: TBitBtn;
    RadioGroup1: TRadioGroup;
    BitBtn2: TBitBtn;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    procedure GeraTabelaExcel(vlTabela: String);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FExportaTabela: TFExportaTabela;

implementation

{$R *.dfm}

uses UAtualizacao, UDMPrincipal, ULeScript;

procedure TFExportaTabela.BitBtn1Click(Sender: TObject);
begin
if RadioGroup1.ItemIndex = 0 then
   begin
   GeraTabelaExcel('PRODUTO');
   end
else if RadioGroup1.ItemIndex = 1 then
   begin
   GeraTabelaExcel('CLIENTE');
   end

end;

procedure TFExportaTabela.BitBtn2Click(Sender: TObject);
begin
Close;
end;

procedure TFExportaTabela.GeraTabelaExcel(vlTabela : String);
var
  PLANILHA : Variant;
  Coluna : Integer;
  QTabela : TFDQuery;
Begin
QTabela := TFDQuery.Create(nil);
Try
Coluna := 1;
PLANILHA := CreateOleObject('Excel.Application');
PLANILHA.Caption := 'Exportanto dados para Tabela ' + vlTabela;
PLANILHA.Visible := False;
PLANILHA.WorkBooks.add(1);

QTabela.Close;
QTabela.Connection := FLeScript.vgConexao;
QTabela.SQL.Clear;
QTabela.SQL.Add('SELECT RDB$FIELD_NAME AS CAMPOS FROM RDB$RELATION_FIELDS');
QTabela.SQL.Add('WHERE RDB$RELATION_NAME = :TABELA');
QTabela.SQL.Add('ORDER BY RDB$FIELD_POSITION ');
QTabela.ParamByName('TABELA').AsString := vlTabela;
QTabela.Open;

// PRENCHIMENTO DAS CÉLULAS COM OS VALORES DOS CAMPOS DA TABELA
While not QTabela.Eof do
   Begin
   PLANILHA.Cells[1, Coluna]:= QTabela.FieldByName('CAMPOS').AsString;
   Inc(Coluna);
   QTabela.Next;
   End;

PLANILHA.Columns.AutoFit;
PLANILHA.Visible := True;

Finally
   PLANILHA := Unassigned;
   FreeAndNil(QTabela);
   end;
End;

end.
