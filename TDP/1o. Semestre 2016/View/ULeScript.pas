unit ULeScript;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, FireDAC.Comp.Client, Printers,
  Vcl.ComCtrls, Vcl.Samples.Gauges, FireDAC.DApt, Vcl.Menus, UConexaoXE8, FireDAC.Comp.Script,
  FireDAC.UI.Intf, FireDAC.Stan.Async, FireDAC.Comp.ScriptCommands,
  FireDAC.Stan.Util, FireDAC.Stan.Intf;

type
  TFLeScript = class(TForm)
    MScript: TMemo;
    OpenDialog1: TOpenDialog;
    FindDialog1: TFindDialog;
    ScrollBox1: TScrollBox;
    btnCarrega: TBitBtn;
    btnSalva: TBitBtn;
    btnLocaliza: TBitBtn;
    btnImprime: TBitBtn;
    btnExecuta: TBitBtn;
    BitBtn1: TBitBtn;
    btnEditar: TBitBtn;
    btnGravarAlt: TBitBtn;
    SaveDialog1: TSaveDialog;
    PrintDialog1: TPrintDialog;
    PageSetupDialog1: TPageSetupDialog;
    gbProgressBar: TGroupBox;
    Gauge1: TGauge;
    Label1: TLabel;
    lblQtdeLinhas: TLabel;
    btnNovo: TBitBtn;
    btnImportar: TBitBtn;
    PopupMenu1: TPopupMenu;
    Editar1: TMenuItem;
    FDScript: TFDScript;
    procedure FormShow(Sender: TObject);
    procedure btnCarregaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FindDialog1Find(Sender: TObject);
    procedure btnLocalizaClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnGravarAltClick(Sender: TObject);
    procedure btnSalvaClick(Sender: TObject);
    procedure btnImprimeClick(Sender: TObject);
    procedure btnExecutaClick(Sender: TObject);
    procedure MScriptChange(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnImportarClick(Sender: TObject);
    procedure Editar1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure CarregaScript;
    procedure ImpressaoTexto;
    procedure SetRichEditMargins(const mLeft, mRight, mTop, mBottom: extended;
      const re: TRichEdit);
    { Private declarations }
  public
    { Public declarations }
    vlStringList : TStringList;
    FSelPos : Integer;
    vlsTabela : String;
    vgConexao : TFDConnection;
  end;

  function fncExecutaBPL(vEmpresa, vUsuario : String): String; stdcall;

var
  FLeScript: TFLeScript;
  vgEmpresa, vgUsuario : String;

implementation

{$R *.dfm}

uses UDMPrincipal, UImportaExcel;

function fncExecutaBPL(vEmpresa, vUsuario: String): String; stdcall;
begin
FLeScript := TFLeScript.Create(nil);

Try
   vgEmpresa := vEmpresa;
   vgUsuario := vUsuario;
   FLeScript.ShowModal;

   Result:='';
Finally
   FreeAndNil(FLeScript);
   end;
end;

exports fncExecutaBPL;

procedure TFLeScript.BitBtn1Click(Sender: TObject);
begin
Close;
end;

procedure TFLeScript.btnCarregaClick(Sender: TObject);
begin
MScript.Lines.Clear;
CarregaScript;
MScript.Enabled      := True;
MScript.SetFocus;
btnSalva.Enabled     := True;
btnLocaliza.Enabled  := True;
btnImprime.Enabled   := True;
btnExecuta.Enabled   := True;
if MScript.Lines.Count > 0 then
   begin
   MScript.Height        := 409;
   btnEditar.Visible     := True;
   btnGravarAlt.Visible  := True;
   btnEditar.Enabled     := True;
   btnGravarAlt.Enabled  := False;
   lblQtdeLinhas.Caption := '';
   lblQtdeLinhas.Caption := IntToStr(MScript.Lines.Count);
   end;
end;

procedure TFLeScript.btnEditarClick(Sender: TObject);
begin
MScript.ReadOnly     := False;
MScript.SetFocus;
btnEditar.Enabled    := False;
btnGravarAlt.Enabled := True;
end;

procedure TFLeScript.btnExecutaClick(Sender: TObject);
var
   I: Integer;
   vldTempoInicial, vldTempoFinal : TDateTime;
   vlsScript, Vls : String;
   vlsStringListScript : TStringList;
   arq: TextFile;
   vlsMensagemErro : String;
begin
Try
vlsStringListScript := TStringList.Create;
FLeScript.vgConexao.StartTransaction;
FDScript.Connection := FLeScript.vgConexao;
vldTempoInicial := Now;
vlsScript := '';
Gauge1.Progress       := 0;
gbProgressBar.Caption := 'Imprimindo linha ... de ' + FormatFloat('000',MScript.Lines.Count);
Gauge1.MaxValue       := MScript.Lines.Count;

for I := 0 to MScript.Lines.Count - 1 do
   begin
   Vls := Copy(MScript.Lines.Strings[I], Length(MScript.Lines.Strings[I]), 1);
   if Copy(MScript.Lines.Strings[I], Length(MScript.Lines.Strings[I]), 1) <> ';'  then
      begin
      vlsScript := vlsScript + MScript.Lines.Strings[I];
      end
   else
      begin
      if Trim(vlsScript) <> '' then
         begin
         vlsScript := vlsScript + MScript.Lines.Strings[I];
         vlsStringListScript.Add(vlsScript);
         vlsScript := '';
         end
      else
         vlsStringListScript.Add(MScript.Lines.Strings[I]);
      end;

   Gauge1.Progress := Gauge1.Progress + 1;
   end;

AssignFile(arq, 'C:\Script.txt');
Rewrite(arq);
Writeln(arq, vlsStringListScript.Text);
CloseFile(arq);


FDScript.ExecuteScript(vlsStringListScript);
vldTempoFinal := Now;
if FDScript.Finished then
   begin
   if FDScript.TotalErrors > 0 then
      ShowMessage('Houve Erros na execução do Script!')
   else
      begin
      ShowMessage('Script executado com sucesso.'#13'Total de Linhas executadas: '+IntToStr(vlsStringListScript.Count)+#13'Total de Tempo: ' +FormatDateTime('tt', vldTempoFinal - vldTempoInicial));

      if MessageDlg('Deseja salvar o Script?',
                        MtConfirmation, [mbYes, mbNo], 0) = MrYes then
            begin
            btnSalvaClick(Sender);
            end;
      MScript.Lines.Clear;
      MScript.Height := 455;
      btnEditar.Visible    := False;
      btnGravarAlt.Visible := False;
      btnNovo.SetFocus;
      end;
   end;

finally
   gbProgressBar.Visible := False;

   FreeAndNil(vlsStringListScript);
   if FDScript.TotalErrors > 0 then
      FLeScript.vgConexao.Rollback
   else
      FLeScript.vgConexao.Commit;

   btnNovo.SetFocus;
   btnSalva.Enabled     := False;
   btnLocaliza.Enabled  := False;
   btnImprime.Enabled   := False;
   btnExecuta.Enabled   := False;
   MScript.Enabled      := False;
   MScript.Height       := 455;
   btnEditar.Visible    := False;
   btnGravarAlt.Visible := False;
   end;
end;

procedure TFLeScript.btnGravarAltClick(Sender: TObject);
begin
MScript.ReadOnly     := True;
btnExecuta.SetFocus;
btnEditar.Enabled    := True;
btnGravarAlt.Enabled := False;
end;

procedure TFLeScript.btnImportarClick(Sender: TObject);
begin
Application.CreateForm(TFImportaExcel, FImportaExcel);
FImportaExcel.ShowModal;
FreeAndNil(FImportaExcel);
end;

procedure TFLeScript.btnImprimeClick(Sender: TObject);
begin
ImpressaoTexto;
end;

procedure TFLeScript.FindDialog1Find(Sender: TObject);
var
  S : string;
  startpos : integer;
  Texto : String;
begin
Texto := UpperCase(FindDialog1.FindText);

if FSelPos = 0 then
  FindDialog1.Options := FindDialog1.Options - [frFindNext];

 { Figure out where to start the search and get the corresponding
   text from the memo. }
if frfindNext in FindDialog1.Options then
begin
  { This is a find next, start after the end of the last found word. }
  StartPos := FSelPos + Length(Texto);
  S := Copy(MScript.Lines.Text, StartPos, MaxInt);
end
else
begin
  { This is a find first, start at the, well, start. }
  S := MScript.Lines.Text;
  StartPos := 1;
end;
{ Perform a global case-sensitive search for FindText in S }
FSelPos := Pos(Texto, S);
if FSelPos > 0 then
begin
   { Found something, correct position for the location of the start
     of search. }
  FSelPos := FSelPos + StartPos - 1;
  MScript.SelStart := FSelPos - 1;
  MScript.SelLength := Length(Texto);
  MScript.SetFocus;
end
else
begin
{ No joy, show a message. }
if frfindNext in FindDialog1.Options then
  S := Concat('Não existe mais ocorrências de "', Texto,
    '" no Script.')
else
  S := Concat('Não foi localizado "', Texto, '" no Script.');
MessageDlg(S, mtError, [mbOK], 0);
end;
end;

procedure TFLeScript.FormClose(Sender: TObject; var Action: TCloseAction);
begin
if Assigned(vlStringList) then
   FreeAndNil(vlStringList);

if Assigned(DMPrincipal) then
   FreeAndNil(DMPrincipal);
end;

procedure TFLeScript.FormCreate(Sender: TObject);
var
   vloConexaoXE8 : TConexaoXE8;
begin
vloConexaoXE8 := TConexaoXE8.Create;
try
vgConexao := vloConexaoXE8.getConnection;

if not Assigned(DMPrincipal) then
   Application.CreateForm(TDMPrincipal, DMPrincipal);
finally
   FreeAndNil(vloConexaoXE8);
   end;
end;

procedure TFLeScript.FormShow(Sender: TObject);
begin
btnNovo.SetFocus;
btnSalva.Enabled     := False;
btnLocaliza.Enabled  := False;
btnImprime.Enabled   := False;
btnExecuta.Enabled   := False;
MScript.Enabled      := False;
vlStringList         := TStringList.Create;
MScript.Height       := 455;
btnEditar.Visible    := False;
btnGravarAlt.Visible := False;
end;

procedure TFLeScript.ImpressaoTexto;
var
   RichText : TRichEdit;
   I: Integer;
   MEsq, MDir, MSup, MInf : Double;
begin
RichText := TRichEdit.Create(Self);
try
RichText.Parent       := Self;
RichText.Visible      := False;
gbProgressBar.Visible := True;
Gauge1.Progress       := 0;
gbProgressBar.Caption := 'Imprimindo linha ... de ' + FormatFloat('000',MScript.Lines.Count);
Gauge1.MaxValue       := MScript.Lines.Count;
Application.ProcessMessages;

for I := 0 to MScript.Lines.Count -1 do
   begin
   RichText.Lines.Add(MScript.Lines.Strings[I]);
   Gauge1.Progress       := Gauge1.Progress + 1;
   gbProgressBar.Caption := 'Imprimindo linha '+FormatFloat('000', I + 1)+' de ' + FormatFloat('000',MScript.Lines.Count);
   Application.ProcessMessages;
   end;

if not PrintDialog1.Execute then
   Exit;

Printer.Orientation := poPortrait; // vertical
MEsq := (PageSetupDialog1.MarginLeft / 7)/1000;
MDir := (PageSetupDialog1.MarginRight / 7)/1000;
MSup := (PageSetupDialog1.MarginTop  / 8)/1000;
MInf := (PageSetupDialog1.MarginBottom / 8)/1000;

SetRichEditMargins(MEsq, MDir, MSup, MInf, RichText);
RichText.Print('\');


finally
   FreeAndNil(RichText);
   gbProgressBar.Visible := False;
   end;
end;

procedure TFLeScript.MScriptChange(Sender: TObject);
begin
if MScript.Lines.Count > 0 then
   begin
   MScript.Height        := 409;
   btnEditar.Visible     := True;
   btnGravarAlt.Visible  := True;
   btnEditar.Enabled     := True;
   btnGravarAlt.Enabled  := False;
   lblQtdeLinhas.Caption := '';
   lblQtdeLinhas.Caption := IntToStr(MScript.Lines.Count);
   end;
end;

procedure TFLeScript.btnLocalizaClick(Sender: TObject);
begin
FSelPos := 0;
FindDialog1.Execute();
end;

procedure TFLeScript.btnNovoClick(Sender: TObject);
begin
MScript.Enabled := True;
MScript.Lines.Clear;
MScript.ReadOnly := False;
MScript.SetFocus;
btnSalva.Enabled     := True;
btnLocaliza.Enabled  := True;
btnImprime.Enabled   := True;
btnExecuta.Enabled   := True;
end;

procedure TFLeScript.btnSalvaClick(Sender: TObject);
begin
SaveDialog1.Title       := 'Carregando Script';
SaveDialog1.Filter      := 'Arquivo SQL (.sql)|*.sql|Arquivo Texto (.txt)|*.txt';
SaveDialog1.DefaultExt  := 'sql';
SaveDialog1.FilterIndex := 0;
SaveDialog1.InitialDir  := ExtractFilePath(Application.ExeName);
SaveDialog1.FileName    := ExtractFileName(OpenDialog1.FileName);

if SaveDialog1.Execute then
   begin
   MScript.Lines.SaveToFile(SaveDialog1.FileName);
   ShowMessage('Arquivo grava com sucesso em: '+SaveDialog1.FileName);
   end;
end;

procedure TFLeScript.CarregaScript;
begin
OpenDialog1.Title  := 'Carregando Script';
OpenDialog1.Filter := 'Arquivo SQL|*.sql';

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
   vlStringList.Clear;
   vlStringList.LoadFromFile(OpenDialog1.FileName);
   end;

MScript.Lines.AddStrings(vlStringList);
MScript.Hint := OpenDialog1.FileName;
MScript.ShowHint := True;
MScript.ReadOnly := True;
end;

procedure TFLeScript.Editar1Click(Sender: TObject);
begin
btnEditarClick(Sender);
end;

procedure TFLeScript.SetRichEditMargins(
   const mLeft, mRight,
         mTop, mBottom: extended;
   const re : TRichEdit);
var
   ppiX, ppiY : integer;
   spaceLeft, spaceTop : integer;
   r : TRect;
begin
   // pixels por polegadas
   ppiX := GetDeviceCaps(Printer.Handle, LOGPIXELSX);
   ppiY := GetDeviceCaps(Printer.Handle, LOGPIXELSY);

   // não imprimir margens
   spaceLeft := GetDeviceCaps(Printer.Handle, PHYSICALOFFSETX);
   spaceTop := GetDeviceCaps(Printer.Handle, PHYSICALOFFSETY);

   //calcular as margens
   R.Left := Round(ppiX * mLeft) - spaceLeft;
   R.Right := Printer.PageWidth - Round(ppiX * mRight) - spaceLeft;
   R.Top := Round(ppiY * mTop) - spaceTop;
   R.Bottom := Printer.PageHeight - Round(ppiY * mBottom) - spaceTop;

   // setar as margens
   re.PageRect := r;
end;

end.
