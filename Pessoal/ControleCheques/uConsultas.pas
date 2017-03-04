unit uConsultas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.Buttons;

type
   TTabelaConsulta = (ttcBanco, ttcConta);
   TFormConsulta   = (tfcControle, tfcCadastro);

type
  TFConsultas = class(TForm)
    Label1: TLabel;
    edtConsultas: TEdit;
    DBGrid1: TDBGrid;
    dsBanco: TDataSource;
    dsConta: TDataSource;
    FDBanco: TFDQuery;
    FDConta: TFDQuery;
    BitBtn1: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure edtConsultasExit(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    vgsTabelaConsulta : TTabelaConsulta;
    vgsFormConsulta   : TFormConsulta;
    vgBanco : string;
  end;

var
  FConsultas: TFConsultas;

implementation

{$R *.dfm}

uses uControleCheques, uCadastros, uPrincipal, uVariaveis;

procedure TFConsultas.BitBtn1Click(Sender: TObject);
begin
Close;
end;

procedure TFConsultas.DBGrid1DblClick(Sender: TObject);
begin
Close;
end;

procedure TFConsultas.edtConsultasExit(Sender: TObject);
begin
if vgsTabelaConsulta = ttcBanco then
   begin
   FDBanco.Filtered := False;
   FDBanco.Filter   := 'BC_DESCRICAO LIKE ' + QuotedStr('%' + edtConsultas.Text + '%');
   FDBanco.Filtered := True;
   end
else if vgsTabelaConsulta = ttcConta then
   begin
   FDConta.Filtered := False;
   FDConta.Filter   := 'CC_DESCRICAO LIKE ' + QuotedStr('%' + edtConsultas.Text + '%');
   FDConta.Filtered := True;
   end;
end;

procedure TFConsultas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
if vgsTabelaConsulta = ttcBanco then
   begin
   if vgsFormConsulta = tfcControle then
      FControleCheques.edtBanco.Text := DBGrid1.DataSource.DataSet.FieldByName('BC_CODIGO').AsString
   else if vgsFormConsulta = tfcCadastro then
      FCadastros.edtBancoContaCorrente.Text := DBGrid1.DataSource.DataSet.FieldByName('BC_CODIGO').AsString;
   end
else if vgsTabelaConsulta = ttcConta then
   begin
   FControleCheques.edtContaCorrente.Text := DBGrid1.DataSource.DataSet.FieldByName('CC_NUMERO').AsString;
   end;
end;

procedure TFConsultas.FormKeyPress(Sender: TObject; var Key: Char);
begin
if Key = #13 then
   begin
   Perform(Wm_NextDlgCtl,0,0);
   Key := #0;
   end
else if Key = #27 then {ESC}
   begin
   Close;
   end;
end;

procedure TFConsultas.FormShow(Sender: TObject);
begin
if vgsTabelaConsulta = ttcBanco then
   begin
   DBGrid1.DataSource := dsBanco;
   FDBanco.Close;
   FDBanco.Connection := vgConexao;
   FDBanco.SQL.Clear;
   FDBanco.SQL.Add('SELECT * FROM BANCOS');
   FDBanco.Open();

   DBGrid1.Columns[0].FieldName := 'BC_CODIGO';
   DBGrid1.Columns[1].FieldName := 'BC_DESCRICAO';
   end
else if vgsTabelaConsulta = ttcConta then
   begin
   DBGrid1.DataSource := dsConta;
   FDConta.Close;
   FDConta.Connection := vgConexao;
   FDConta.SQL.Clear;
   FDConta.SQL.Add('SELECT * FROM CONTAS WHERE CC_BANCO = :BANCO');
   FDConta.ParamByName('BANCO').AsString := vgBanco;
   FDConta.Open();

   DBGrid1.Columns[0].FieldName := 'CC_NUMERO';
   DBGrid1.Columns[1].FieldName := 'CC_DESCRICAO';
   end;
end;

end.
