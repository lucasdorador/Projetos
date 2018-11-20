unit uPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit, FMX.EditBox, FMX.NumberBox,
  udmPrincipal;

type
  TFPrincipal = class(TForm)
    gbCampos: TGroupBox;
    key_empresa: TEdit;
    Label1: TLabel;
    key_produto: TEdit;
    Label2: TLabel;
    descricao: TEdit;
    Label3: TLabel;
    complemento: TEdit;
    Label4: TLabel;
    grupo: TEdit;
    Label5: TLabel;
    valor_meia: TNumberBox;
    Label6: TLabel;
    valor_inteira: TNumberBox;
    Label7: TLabel;
    btnGravar: TButton;
    btnSair: TButton;
    procedure btnSairClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FPrincipal: TFPrincipal;

implementation

{$R *.fmx}

procedure TFPrincipal.btnGravarClick(Sender: TObject);
begin
dmPrincipal.FDInsert.Close;
dmPrincipal.FDInsert.SQL.Clear;
dmPrincipal.FDInsert.SQL.Add('SELECT KEY_EMPRESA FROM PRODUTOS WHERE (KEY_EMPRESA = :KEY_EMPRESA) AND (KEY_PRODUTO = :KEY_PRODUTO)');
dmPrincipal.FDInsert.ParamByName('KEY_EMPRESA').AsString := key_empresa.Text;
dmPrincipal.FDInsert.ParamByName('KEY_PRODUTO').AsString := key_produto.Text;
dmPrincipal.FDInsert.Open();

if dmPrincipal.FDInsert.IsEmpty then
   begin
   dmPrincipal.FDInsert.Close;
   dmPrincipal.FDInsert.SQL.Clear;
   dmPrincipal.FDInsert.SQL.Add('INSERT INTO PRODUTOS (KEY_EMPRESA, KEY_PRODUTO, DESCRICAO,');
   dmPrincipal.FDInsert.SQL.Add('                      COMPLEMENTOS, GRUPO, VALOR_INTEIRA, VALOR_MEIA) ');
   dmPrincipal.FDInsert.SQL.Add('VALUES (:KEY_EMPRESA, :KEY_PRODUTO, :DESCRICAO, ');
   dmPrincipal.FDInsert.SQL.Add('        :COMPLEMENTOS, :GRUPO, :VALOR_INTEIRA, :VALOR_MEIA)');
   end
else
   begin
   dmPrincipal.FDInsert.Close;
   dmPrincipal.FDInsert.SQL.Clear;
   dmPrincipal.FDInsert.SQL.Add('UPDATE PRODUTOS');
   dmPrincipal.FDInsert.SQL.Add('SET DESCRICAO = :DESCRICAO,');
   dmPrincipal.FDInsert.SQL.Add('    COMPLEMENTOS = :COMPLEMENTOS,');
   dmPrincipal.FDInsert.SQL.Add('    GRUPO = :GRUPO,');
   dmPrincipal.FDInsert.SQL.Add('    VALOR_INTEIRA = :VALOR_INTEIRA,');
   dmPrincipal.FDInsert.SQL.Add('    VALOR_MEIA = :VALOR_MEIA');
   dmPrincipal.FDInsert.SQL.Add('WHERE (KEY_EMPRESA = :KEY_EMPRESA) AND (KEY_PRODUTO = :KEY_PRODUTO)');
   end;

dmPrincipal.FDInsert.ParamByName('KEY_EMPRESA').AsString  := key_empresa.Text;
dmPrincipal.FDInsert.ParamByName('KEY_PRODUTO').AsString  := key_produto.Text;
dmPrincipal.FDInsert.ParamByName('DESCRICAO').AsString    := descricao.Text;
dmPrincipal.FDInsert.ParamByName('COMPLEMENTOS').AsString := complemento.Text;
dmPrincipal.FDInsert.ParamByName('VALOR_INTEIRA').AsFloat := valor_inteira.Value;
dmPrincipal.FDInsert.ParamByName('VALOR_MEIA').AsFloat    := valor_meia.Value;
dmPrincipal.FDInsert.ParamByName('GRUPO').AsString        := grupo.Text;
dmPrincipal.FDInsert.ExecSQL;

end;

procedure TFPrincipal.btnSairClick(Sender: TObject);
begin
Close;
end;

end.
