unit uFindParametros;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtDlgs,
  Vcl.ExtCtrls;

type
  TFFindParametros = class(TForm)
    MPas: TMemo;
    Panel1: TPanel;
    OpenTextFileDialog1: TOpenTextFileDialog;
    Edit1: TEdit;
    btnBuscaPAS: TBitBtn;
    BitBtn3: TBitBtn;
    procedure btnBuscaPASClick(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    function fnclocalizaparametro(s: String): String;
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
   Edit1.Text := OpenTextFileDialog1.FileName;

   if FileExists(Edit1.Text) then
      begin
      MPas.Lines.Clear;
      MPas.Lines.LoadFromFile(Edit1.Text);
      end;

   end;
end;

procedure TFFindParametros.BitBtn3Click(Sender: TObject);
var
  I: Integer;
  vlsTeste : String;
  vlsResult : TStringList;
begin
vlsResult := TStringList.Create;
Application.CreateForm(TFProcessa, FProcessa);
try
FProcessa.GroupBox1.Caption := 'Validando arquivo ' + ExtractFileName(Edit1.Text) + ' ... (Linha 01 de '+MPas.Lines.Count.ToString+')';
FProcessa.Gauge1.MaxValue   := MPas.Lines.Count;
FProcessa.Gauge1.Progress   := 0;
for I := 0 to MPas.Lines.Count - 1 do
   begin
   vlsTeste := Trim(fnclocalizaparametro(MPas.Lines[i]));
   if vlsTeste <> '' then
      begin
      if vlsResult.IndexOf(vlsTeste) < 0 then
         vlsResult.Add(vlsTeste);
      end;

   FProcessa.Gauge1.Progress   := FProcessa.Gauge1.Progress + 1;
   FProcessa.GroupBox1.Caption := 'Validando arquivo ' + ExtractFileName(Edit1.Text) + ' ... (Linha '+I.ToString+' de '+MPas.Lines.Count.ToString+')';
   Application.ProcessMessages;
   end;

vlsResult.Add('Quantidade: ' + vlsResult.Count.ToString);

Application.CreateForm(TFMemoParametros, FMemoParametros);
FMemoParametros.Memo1.Lines := vlsResult;
FMemoParametros.ShowModal;

finally
   FreeAndNil(FMemoParametros);
   FreeAndNil(vlsResult);
   FreeAndNil(FProcessa);
   end;
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

end.
