unit uMemoParametros;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, System.Win.ComObj;

type
  TFMemoParametros = class(TForm)
    Panel1: TPanel;
    btnSair: TBitBtn;
    MParametros: TMemo;
    Label1: TLabel;
    btnExportar: TBitBtn;
    procedure btnSairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnExportarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    procedure pcdAtualizaTotalMemo;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMemoParametros: TFMemoParametros;

implementation

{$R *.dfm}

procedure TFMemoParametros.btnExportarClick(Sender: TObject);
var linha, coluna : integer;
    planilha : variant;
    valorcampo : string;
  I: Integer;
begin
planilha:= CreateoleObject('Excel.Application');
planilha.WorkBooks.add(1);
planilha.caption := 'Exportando dados dos Parâmetros para o Excel';
planilha.visible := True;

planilha.cells[1, 1] := 'Parâmetros';
for I := 0 to MParametros.Lines.Count - 1 do
   planilha.cells[I + 2, 1] := MParametros.Lines.Strings[I];

planilha.columns.Autofit;
end;

procedure TFMemoParametros.btnSairClick(Sender: TObject);
begin
Close;
end;

procedure TFMemoParametros.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
Case Key Of
   VK_RETURN : Perform(WM_NEXTDLGCTL, 0, 0);
   VK_F6: btnExportarClick(Sender);
   VK_ESCAPE: btnSairClick(Sender);
   End;
end;

procedure TFMemoParametros.FormShow(Sender: TObject);
begin
pcdAtualizaTotalMemo;
end;

procedure TFMemoParametros.pcdAtualizaTotalMemo;
begin
Label1.Caption := 'Total de Parâmetros Encontrados: ' + MParametros.Lines.Count.ToString();
end;

end.
