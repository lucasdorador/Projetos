unit uComplementos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uTDPNumberEditXE8,
  Vcl.Mask, Vcl.Buttons;

type
  TFComplementos = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    edtReferencia: TEdit;
    Label2: TLabel;
    edtVencimento: TMaskEdit;
    Label3: TLabel;
    edtMulta: TDPTNumberEditXE8;
    Label4: TLabel;
    edtJuros: TDPTNumberEditXE8;
    btnOK: TBitBtn;
    procedure btnOKClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FComplementos: TFComplementos;

implementation

{$R *.dfm}

uses uImpostos;

procedure TFComplementos.btnOKClick(Sender: TObject);
begin
FImpostos.vgsReferencia  := edtReferencia.Text;
FImpostos.vgsVencimentos := edtVencimento.Text;
FImpostos.vgdMulta       := edtMulta.Value;
FImpostos.vgdJuros       := edtJuros.Value;

Close;
end;

procedure TFComplementos.FormKeyPress(Sender: TObject; var Key: Char);
begin
if Key = #13 then
   begin
   Perform(Wm_NextDlgCtl,0,0);
   Key := #0;
   end
else if Key = #27 then {ESC}
   begin
   btnOKClick(Sender);
   end;
end;

procedure TFComplementos.FormShow(Sender: TObject);
begin
edtVencimento.Text := FormatDateTime('dd/mm/yyyy', Date);
end;

end.
