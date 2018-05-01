unit UImportaExcel;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ComObj, Vcl.StdCtrls, Vcl.Buttons, FireDac.Comp.Client,
  Vcl.Grids, Vcl.ExtCtrls, Vcl.Samples.Gauges;

type
  TFImportaExcel = class(TForm)
    OpenDialog1: TOpenDialog;
    StringGrid1: TStringGrid;
    ScrollBox1: TScrollBox;
    btnImportarExcel: TBitBtn;
    BitBtn1: TBitBtn;
    btnGerarScript: TBitBtn;
    GroupBox1: TGroupBox;
    rgTipos: TRadioGroup;
    btnExportarTabela: TBitBtn;
    PNomeTabela: TPanel;
    BitBtn2: TBitBtn;
    gbProgressBar: TGroupBox;
    Gauge1: TGauge;
    procedure btnImportarExcelClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure StringGrid1DblClick(Sender: TObject);
    procedure StringGrid1Exit(Sender: TObject);
    procedure btnGerarScriptClick(Sender: TObject);
    procedure btnExportarTabelaClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
    function XlsToStringGrid(XStringGrid: TStringGrid; xFileXLS: string): Boolean;
    function NomeTabela(Campo: String): String;
    procedure ConfiguraColunas(vloStringGrid: TStringGrid);
    function fncRetornaTipoCampo(Campo: String): String;

  public
    { Public declarations }
    vlsPrimeiroCampo, vlsNomeTabela : String;
    procedure ExcluirDadosTabela(Tabela: String);
  end;

var
  FImportaExcel: TFImportaExcel;

implementation

{$R *.dfm}

uses ULeScript, UExportaTabela, UDMPrincipal;

{ TForm1 }

procedure TFImportaExcel.BitBtn1Click(Sender: TObject);
begin
Close;
end;

procedure TFImportaExcel.BitBtn2Click(Sender: TObject);
begin
ConfiguraColunas(StringGrid1);
StringGrid1.Refresh;
ShowMessage('Tabela Configurada com sucesso!');
end;

procedure TFImportaExcel.btnExportarTabelaClick(Sender: TObject);
begin
Application.CreateForm(TFExportaTabela, FExportaTabela);
FExportaTabela.ShowModal;
FreeAndNil(FExportaTabela);
end;

procedure TFImportaExcel.btnGerarScriptClick(Sender: TObject);
var
   vlsDadosComando, vlsStringComando : String;
   I: Integer;
   vlLinhas: Integer;
   vlColunas: Integer;
   vlsStringListComando : TStringList;
begin
try
vlsStringListComando := TStringList.Create;
ExcluirDadosTabela(vlsNomeTabela);

for vlLinhas := 0 to StringGrid1.RowCount -1 do
   begin
   vlsDadosComando := '';
   for vlColunas := 0 to StringGrid1.Rows[vlLinhas].Count - 1 do
      begin
      if vlLinhas = 0 then
         begin
         if Trim(vlsDadosComando) = '' then
            vlsDadosComando := Trim(StringGrid1.Rows[vlLinhas].Strings[vlColunas])
         else
            vlsDadosComando := vlsDadosComando + ', ' + Trim(StringGrid1.Rows[vlLinhas].Strings[vlColunas]);
         end
      else
         begin
         if Trim(vlsDadosComando) = '' then
            vlsDadosComando := QuotedStr(Trim(StringGrid1.Rows[vlLinhas].Strings[vlColunas]))
         else
            vlsDadosComando := vlsDadosComando + ',' + QuotedStr(Trim(StringGrid1.Rows[vlLinhas].Strings[vlColunas]));
         end;
      end;

   if vlLinhas = 0 then
      begin
      if rgTipos.ItemIndex = 0 then
         begin
         vlsStringComando := 'INSERT INTO '+FLeScript.vlsTabela+' ('+vlsDadosComando+') VALUES';
         end
      else if rgTipos.ItemIndex = 1 then
         begin
         ShowMessage('Delete');
         end
      else if rgTipos.ItemIndex = 2 then
         begin
         ShowMessage('Update');
         end
      else if rgTipos.ItemIndex = 3 then
         begin
         ShowMessage('Create');
         end;
      end
   else
      begin
      if rgTipos.ItemIndex = 0 then
         begin
         if Trim(vlsDadosComando) <> '' then
            begin
            vlsStringListComando.Add(vlsStringComando + ' ('+vlsDadosComando+');');
            end;
         end
      else if rgTipos.ItemIndex = 1 then
         begin
         ShowMessage('Delete');
         end
      else if rgTipos.ItemIndex = 2 then
         begin
         ShowMessage('Update');
         end
      else if rgTipos.ItemIndex = 3 then
         begin
         ShowMessage('Create');
         end;
      end;
   end;

FLeScript.MScript.Lines.Clear;
FLeScript.MScript.Lines.AddStrings(vlsStringListComando);
FLeScript.MScript.Hint     := 'Importado pelo Excel!';
FLeScript.MScript.ShowHint := True;
FLeScript.MScript.ReadOnly := True;
FLeScript.MScript.Enabled      := True;
FLeScript.MScript.SetFocus;
FLeScript.btnSalva.Enabled     := True;
FLeScript.btnLocaliza.Enabled  := True;
FLeScript.btnImprime.Enabled   := True;
FLeScript.btnExecuta.Enabled   := True;
if FLeScript.MScript.Lines.Count > 0 then
   begin
   FLeScript.MScript.Height        := 409;
   FLeScript.btnEditar.Visible     := True;
   FLeScript.btnGravarAlt.Visible  := True;
   FLeScript.btnEditar.Enabled     := True;
   FLeScript.btnGravarAlt.Enabled  := False;
   FLeScript.lblQtdeLinhas.Caption := '';
   FLeScript.lblQtdeLinhas.Caption := IntToStr(FLeScript.MScript.Lines.Count);
   end;
Close;
Application.ProcessMessages;

finally
   FreeAndNil(vlsStringListComando);
   end;
end;

procedure TFImportaExcel.btnImportarExcelClick(Sender: TObject);
begin
OpenDialog1.Title  := 'Carregando arquivo de Excel';
OpenDialog1.Filter := 'Arquivos de Excel|*.xlsx|Arquivos de Excel 97-2003|*.xls';

try
OpenDialog1.InitialDir := ExtractFilePath(Application.ExeName);
except
   on e : exception do
      begin
      ShowMessage('Erro com a mensagem: ' + e.Message);
      end;
   end;

if OpenDialog1.Execute then
   Begin
   try
   StringGrid1.RowCount := 0;
   XlsToStringGrid(StringGrid1,OpenDialog1.FileName)
   except
      StringGrid1.RowCount := 0;
      XlsToStringGrid(StringGrid1,OpenDialog1.FileName)
      end;
   end;

FLeScript.vlsTabela  := '';
FLeScript.vlsTabela  := NomeTabela(vlsPrimeiroCampo);
StringGrid1.Hint     := OpenDialog1.FileName;
StringGrid1.ShowHint := True;
ConfiguraColunas(StringGrid1);
end;

procedure TFImportaExcel.FormShow(Sender: TObject);
begin
StringGrid1.RowCount := 0;
StringGrid1.ColCount := 0;
PNomeTabela.Visible  := False;
end;

procedure TFImportaExcel.StringGrid1DblClick(Sender: TObject);
begin
StringGrid1.Options := StringGrid1.Options + [goEditing];
end;

procedure TFImportaExcel.StringGrid1Exit(Sender: TObject);
begin
StringGrid1.Options := StringGrid1.Options - [goEditing];
end;

Function TFImportaExcel.XlsToStringGrid(xStringGrid: TStringGrid; xFileXLS: string): Boolean;
const
   xlCellTypeLastCell = $0000000B;
var
   XLSAplicacao, AbaXLS: OLEVariant;
   RangeMatrix: Variant;
   x, y, k, r, vliTamanhoColuna: Integer;
begin
   Result := False;
   // Cria Excel- OLE Object
   XLSAplicacao := CreateOleObject('Excel.Application');
   try
   // Esconde Excel
      XLSAplicacao.Visible := False;
      // Abre o Workbook
      XLSAplicacao.Workbooks.Open(xFileXLS);
      AbaXLS := XLSAplicacao.Workbooks[ExtractFileName(xFileXLS)].WorkSheets[1];
      AbaXLS.Cells.SpecialCells(xlCellTypeLastCell, EmptyParam).Activate;
      // Pegar o número da última linha
      x := XLSAplicacao.ActiveCell.Row;
      // Pegar o número da última coluna
      y := XLSAplicacao.ActiveCell.Column;
      // Seta xStringGrid linha e coluna
      XStringGrid.RowCount := x;
      XStringGrid.ColCount := y;
      // Associaca a variant WorkSheet com a variant do Delphi
      RangeMatrix := XLSAplicacao.Range['A1', XLSAplicacao.Cells.Item[x, y]].Value;
      // Cria o loop para listar os registros no TStringGrid
      k := 1;
      vlsPrimeiroCampo := '';
      vlsPrimeiroCampo := RangeMatrix[1, 2];
      repeat
         for r := 1 to y do
            XStringGrid.Cells[(r - 1), (k - 1)] := RangeMatrix[k, r];
         Inc(k, 1);
      until k > x;

      for r := 1 to y do
         begin
         vliTamanhoColuna := Length(RangeMatrix[1, r]) * 8;
         StringGrid1.ColWidths[r - 1] := vliTamanhoColuna;
         end;

      RangeMatrix := Unassigned;
      finally
            // Fecha o Microsoft Excel
            if not VarIsEmpty(XLSAplicacao) then
            begin
                  XLSAplicacao.Quit;
                  XLSAplicacao := Unassigned;
                  AbaXLS := Unassigned;
                  Result := True;
            end;
      end;
end;

function TFImportaExcel.NomeTabela(Campo : String) : String;
var
   QTabela : TFDQuery;
begin
QTabela := TFDQuery.Create(nil);
try
QTabela.Close;
QTabela.Connection := FLeScript.vgConexao;
QTabela.SQL.Clear;
QTabela.SQL.Add('SELECT RDB$RELATION_NAME AS TABELA FROM RDB$RELATION_FIELDS');
QTabela.SQL.Add('WHERE RDB$FIELD_NAME = :CAMPO');
QTabela.SQL.Add('ORDER BY RDB$FIELD_POSITION');
QTabela.ParamByName('CAMPO').AsString := Campo;
QTabela.Open;

if not QTabela.IsEmpty then
   begin
   Result := QTabela.FieldByName('TABELA').AsString;
   PNomeTabela.Caption  := '   TABELA: ' + UpperCase(QTabela.FieldByName('TABELA').AsString);
   PNomeTabela.Visible  := True;
   vlsNomeTabela        := UpperCase(QTabela.FieldByName('TABELA').AsString);
   end
else
   ShowMessage('Campo: ' + Campo + ' não contem em nenhuma tabela!');

finally
   FreeAndNil(QTabela);
   end;
end;

procedure TFImportaExcel.ConfiguraColunas(vloStringGrid : TStringGrid);
var
  I, vlI: Integer;
  vlsTipoCampos, vlsString : String;
begin
try
gbProgressBar.Visible := True;
Gauge1.Progress       := 0;
gbProgressBar.Caption := 'Corrigindo linha 1 de ' + IntToStr(vloStringGrid.RowCount - 1);
Gauge1.MaxValue       := vloStringGrid.RowCount - 1;
Application.ProcessMessages;

for I := 1 to vloStringGrid.RowCount do //Qtde Linhas
   begin
   for vlI := 0 to vloStringGrid.ColCount do //Qtde Colunas
      begin
      if Trim(vloStringGrid.Cells[1, I]) <> '' then
         begin
         vlsTipoCampos := fncRetornaTipoCampo(vloStringGrid.Cells[vlI, 0]);

         if vloStringGrid.Cells[vlI, I] = '30/12/1899' then //Corrigi a data para 01/01/1900
            begin
            vloStringGrid.Cells[vlI, I] := '01/01/1900';
            end;

         if vlsTipoCampos = 'BOOLEAN' then  //Corrigi campos booleanos
            begin
            vlsString := vloStringGrid.Cells[vlI, 0];
            vlsString := vloStringGrid.Cells[vlI, I];

            if Trim(vloStringGrid.Cells[vlI, I]) = '' then
               vloStringGrid.Cells[vlI, I] := 'False';
            end;

         if vlsTipoCampos = 'DOUBLE' then  //Corrigi campos booleanos
            begin
            vlsString := vloStringGrid.Cells[vlI, 0];
            vlsString := vloStringGrid.Cells[vlI, I];

            if vlsString = '' then
               ShowMessage('Fodeo');

            vloStringGrid.Cells[vlI, I] := StringReplace(vloStringGrid.Cells[vlI, I], ',','.',[rfReplaceAll, rfIgnoreCase])
            end;

         if (vlsTipoCampos = 'DATE') and (Trim(vloStringGrid.Cells[vlI, I]) = '') then  //Corrigi campos booleanos
            begin
            vlsString := vloStringGrid.Cells[vlI, I];
            vloStringGrid.Cells[vlI, I] := '01/01/1900';
            end;
         end
      else
         begin
         Exit;
         end;
      end;
   Gauge1.Progress       := Gauge1.Progress + 1;
   gbProgressBar.Caption := 'Corrigindo linha '+IntToStr(I)+' de ' + IntToStr(vloStringGrid.RowCount - 1);
   Application.ProcessMessages;
   end;
finally
   gbProgressBar.Visible := False;
   end;
end;

function TFImportaExcel.fncRetornaTipoCampo(Campo : String) : String;
var
   QTabela : TFDQuery;
begin
QTabela := TFDQuery.Create(nil);
try
QTabela.Close;
QTabela.Connection := FLeScript.vgConexao;
QTabela.SQL.Clear;
QTabela.SQL.Add('SELECT');
QTabela.SQL.Add('R.RDB$FIELD_SOURCE AS "DOMÍNIO",');
QTabela.SQL.Add('F.RDB$FIELD_LENGTH AS TAMANHO,');
QTabela.SQL.Add('CASE F.RDB$FIELD_TYPE');
QTabela.SQL.Add('    WHEN 261 THEN ''BLOB''');
QTabela.SQL.Add('    WHEN 14 THEN  ''CHAR''');
QTabela.SQL.Add('    WHEN 40 THEN  ''CSTRING''');
QTabela.SQL.Add('    WHEN 11 THEN  ''D_FLOAT''');
QTabela.SQL.Add('    WHEN 27 THEN  ''DOUBLE''');
QTabela.SQL.Add('    WHEN 10 THEN  ''FLOAT''');
QTabela.SQL.Add('    WHEN 16 THEN  ''INT64''');
QTabela.SQL.Add('    WHEN 8 THEN   ''INTEGER''');
QTabela.SQL.Add('    WHEN 9 THEN   ''QUAD''');
QTabela.SQL.Add('    WHEN 7 THEN   ''SMALLINT''');
QTabela.SQL.Add('    WHEN 12 THEN  ''DATE''');
QTabela.SQL.Add('    WHEN 13 THEN  ''TIME''');
QTabela.SQL.Add('    WHEN 35 THEN  ''TIMESTAMP''');
QTabela.SQL.Add('    WHEN 37 THEN  ''VARCHAR''');
QTabela.SQL.Add('    ELSE ''UNKNOWN''');
QTabela.SQL.Add('END AS TIPO');
QTabela.SQL.Add('FROM RDB$RELATION_FIELDS R');
QTabela.SQL.Add('LEFT JOIN RDB$FIELDS F ON R.RDB$FIELD_SOURCE = F.RDB$FIELD_NAME');
QTabela.SQL.Add('WHERE R.RDB$RELATION_NAME= :TABELA AND R.RDB$FIELD_NAME =:CAMPO');
QTabela.SQL.Add('ORDER BY R.RDB$FIELD_POSITION;');
QTabela.ParamByName('TABELA').AsString := vlsNomeTabela;
QTabela.ParamByName('CAMPO').AsString  := Campo;
QTabela.Open;

if ((QTabela.FieldByName('TIPO').AsString = 'VARCHAR') AND
    (QTabela.FieldByName('TAMANHO').AsInteger = 5) AND
    (QTabela.FieldByName('DOMÍNIO').AsString = 'BOLEANO')) then
   Result := 'BOOLEAN'
else
   Result := QTabela.FieldByName('TIPO').AsString;

finally
   FreeAndNil(QTabela);
   end;
end;

procedure TFImportaExcel.ExcluirDadosTabela(Tabela : String);
var
   QTabela : TFDQuery;
begin
QTabela := TFDQuery.Create(nil);
try
if MessageDlg('Deseja apagar os dados da tabela: ' +Tabela+ ' antes da importação?',
                  MtConfirmation, [mbYes, mbNo], 0) = MrYes then
   begin
   QTabela.Close;
   QTabela.Connection := FLeScript.vgConexao;
   QTabela.SQL.Clear;
   QTabela.SQL.Add('DELETE FROM ' + Tabela);
   QTabela.ExecSQL;
   end;

finally
   FreeAndNil(QTabela);
   end;
end;

end.
