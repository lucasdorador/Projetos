unit uConsultaCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids;

type
  TFConsultaCliente = class(TForm)
    DBGrid1: TDBGrid;
    procedure FormShow(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FConsultaCliente: TFConsultaCliente;

implementation

uses
 uDMPrincipal;

{$R *.dfm}

procedure TFConsultaCliente.DBGrid1DblClick(Sender: TObject);
begin
Close;
end;

procedure TFConsultaCliente.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
DMPrincipal.vgsClienteSelecionado := DMPrincipal.FDConsultaClientesCLIENTE.AsString;
end;

procedure TFConsultaCliente.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Key = VK_RETURN then
   Perform(Wm_NextDlgCtl,0,0)
else if Key = VK_ESCAPE then
   Close;
end;

procedure TFConsultaCliente.FormShow(Sender: TObject);
begin
DMPrincipal.FDConsultaClientes.Close;
DMPrincipal.FDConsultaClientes.Open;
end;

end.
