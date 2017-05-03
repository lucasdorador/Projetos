unit uFindParametros;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtDlgs,
  Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Panel1: TPanel;
    OpenTextFileDialog1: TOpenTextFileDialog;
    Edit1: TEdit;
    BitBtn1: TBitBtn;
    BitBtn3: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    function fnclocalizaparametro(s: String): String;
    function fncRemoveRepitidos(psValue: TStringList): TStringList;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
if OpenTextFileDialog1.Execute() then
   begin
   Edit1.Text := OpenTextFileDialog1.FileName;

   if FileExists(Edit1.Text) then
      begin
      Memo1.Lines.Clear;
      Memo1.Lines.LoadFromFile(Edit1.Text);
      end;

   end;
end;

procedure TForm1.BitBtn3Click(Sender: TObject);
var
  I: Integer;
  vlsTeste : String;
  vlsResult : TStringList;
begin
vlsResult := TStringList.Create;
try

for I := 0 to Memo1.Lines.Count - 1 do
   begin
   vlsTeste := Trim(fnclocalizaparametro(Memo1.Lines[i]));
   if vlsTeste <> '' then
      begin
      if vlsResult.IndexOf(vlsTeste) < 0 then
         vlsResult.Add(vlsTeste);
      end;
   end;

vlsResult.Add('Quantidade: ' + vlsResult.Count.ToString);
ShowMessage(vlsResult.Text);

finally
   vlsResult.Free;
   end;
end;

function TForm1.fncRemoveRepitidos(psValue: TStringList): TStringList;
var
  I: Integer;
begin
psValue.Sort;
for I := psValue.count - 1 downto 1 do
   begin
   if psValue[I-1] = psValue[I] then
      psValue.Delete(I);
   end;
end;

function TForm1.fnclocalizaparametro(s: String): String;
var
   vlResult : String;
   I, vli: Integer;
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
