unit uCalculaDespesa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask,
  uTDPNumberEditXE8, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.Buttons;

type
  TFCalculaDespesa = class(TForm)
    gbAnoBase: TGroupBox;
    Label1: TLabel;
    edtAno: TMaskEdit;
    gbDespesas: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    edtDescricao: TEdit;
    edtValor: TDPTNumberEditXE8;
    dbgDespesas: TDBGrid;
    pTotal: TPanel;
    Label4: TLabel;
    btnGravar: TBitBtn;
    btnExcluir: TBitBtn;
    btnFechar: TBitBtn;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnGravarClick(Sender: TObject);
  private
    procedure pcdLimpaCamposDespesa;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FCalculaDespesa: TFCalculaDespesa;

implementation

{$R *.dfm}

uses uDMPrincipal;

procedure TFCalculaDespesa.pcdLimpaCamposDespesa;
begin
edtDescricao.Clear;
edtValor.Value := 0;

if edtDescricao.CanFocus then
   edtDescricao.SetFocus;
end;

procedure TFCalculaDespesa.btnGravarClick(Sender: TObject);
begin
pcdLimpaCamposDespesa;
end;

procedure TFCalculaDespesa.FormKeyPress(Sender: TObject; var Key: Char);
begin
if Key = #13 then
   begin
   Perform(WM_NEXTDLGCTL, 0, 0);
   Key := #0;
   end;
end;

end.
