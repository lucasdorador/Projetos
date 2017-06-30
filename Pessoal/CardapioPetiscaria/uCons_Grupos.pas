unit uCons_Grupos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, DMPrincipal;

type
  TFCons_Grupos = class(TForm)
    GroupBox1: TGroupBox;
    edtcons_Grupos: TEdit;
    DBCons_Grupos: TDBGrid;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtcons_GruposExit(Sender: TObject);
    procedure edtcons_GruposEnter(Sender: TObject);
    procedure DBCons_GruposDblClick(Sender: TObject);
    procedure DBCons_GruposKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FCons_Grupos: TFCons_Grupos;

implementation

{$R *.dfm}

uses uCadastroCardapio;

procedure TFCons_Grupos.DBCons_GruposDblClick(Sender: TObject);
begin
Close;
end;

procedure TFCons_Grupos.DBCons_GruposKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Key = VK_RETURN then
   Close;
end;

procedure TFCons_Grupos.edtcons_GruposEnter(Sender: TObject);
begin
DBCons_Grupos.DataSource.DataSet.Filtered := False;
end;

procedure TFCons_Grupos.edtcons_GruposExit(Sender: TObject);
begin
if Trim(edtcons_Grupos.Text) <> '' then
   begin
   DBCons_Grupos.DataSource.DataSet.Filtered := False;
   DBCons_Grupos.DataSource.DataSet.Filter   := 'GRUPO_DESCRICAO LIKE ' + QuotedStr('%'+edtcons_Grupos.Text+'%');
   DBCons_Grupos.DataSource.DataSet.Filtered := True;
   end
else
   begin
   DBCons_Grupos.DataSource.DataSet.Filtered := False;
   end;
end;

procedure TFCons_Grupos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
FCadastroCardapio.edtCodGrupo.Text := DBCons_Grupos.DataSource.DataSet.FieldByName('GRUPO_CODIGO').AsString;
end;

procedure TFCons_Grupos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
case Key of
   VK_ESCAPE : Close;
   end;
end;

procedure TFCons_Grupos.FormKeyPress(Sender: TObject; var Key: Char);
begin
if Key = #13 then
   begin
   Perform(Wm_NextDlgCtl,0,0);
   Key := #0;
   end
end;

procedure TFCons_Grupos.FormShow(Sender: TObject);
begin
DMPrinc.FDCons_Grupos.Open();
DMPrinc.FDCons_Grupos.Refresh;

if edtcons_Grupos.CanFocus then
   edtcons_Grupos.SetFocus;
end;

end.
