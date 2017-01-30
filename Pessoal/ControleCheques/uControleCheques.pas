unit uControleCheques;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons,
  Vcl.Mask, uTDPNumberEditXE8, Data.DB, Vcl.Grids, Vcl.DBGrids;

type
  TFControleCheques = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    btnCons_Bancos: TBitBtn;
    PBancos: TPanel;
    edtContaCorrente: TEdit;
    btnContaCorrente: TBitBtn;
    PContaCorrente: TPanel;
    edtBanco: TMaskEdit;
    edtNumeroCheque: TEdit;
    edtValor: TDPTNumberEditXE8;
    edtData: TMaskEdit;
    edtCompensacao: TMaskEdit;
    btnGravar: TBitBtn;
    btnExcluir: TBitBtn;
    btnSair: TBitBtn;
    DBGrid1: TDBGrid;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure edtDataEnter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FControleCheques: TFControleCheques;

implementation

{$R *.dfm}

procedure TFControleCheques.btnSairClick(Sender: TObject);
begin
Close;
end;

procedure TFControleCheques.edtDataEnter(Sender: TObject);
begin
if edtData.Text = '  /  /    ' then
   edtData.Text := FormatDateTime('dd/mm/yyyy', Date);

end;

procedure TFControleCheques.FormKeyPress(Sender: TObject; var Key: Char);
begin
if Key = #13 then
   begin
   Perform(Wm_NextDlgCtl,0,0);
   Key := #0;
   end
else if Key = #27 then {ESC}
   begin
   btnSairClick(Sender);
   end;
end;

procedure TFControleCheques.FormShow(Sender: TObject);
begin
edtBanco.SetFocus;
end;

end.
