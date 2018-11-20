unit uPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit, FMX.EditBox, FMX.NumberBox,
  udmPrincipal, uMenuInicial, uConstantes, FireDAC.Stan.Param, Data.DB;

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
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
  private
    vlBEdicao : Boolean;
    vlSKeyEmpresa, vlsKeyProduto: String;
    function fncGeraKeyProduto(max: Integer): String;
    procedure pcdLimparCampos;
    procedure carregarProduto;
    { Private declarations }
  public
    procedure setTelaInicial(pbEdicao: Boolean; psKeyEmpresa, psKeyProduto: String);
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

pcdLimparCampos;
end;

procedure TFPrincipal.btnSairClick(Sender: TObject);
begin
FMenuInicial.setAtualizarLista;
Close;
end;

procedure TFPrincipal.FormKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
if Key = vkReturn then
    begin
    Key := vkTab;
    KeyDown(Key, KeyChar, Shift);
    end;

if Key = vkF5 then
   begin
   key_empresa.Text := constkey_empresa;//'-LNIt3Xv5j-bLDcr6p4E';
   end;

if ((Key = vkF6) and (Trim(descricao.Text) = '')) then
   begin
   key_produto.Text := fncGeraKeyProduto(19);
   end;
end;

procedure TFPrincipal.setTelaInicial(pbEdicao: Boolean; psKeyEmpresa, psKeyProduto: String);
begin
vlBEdicao        := pbEdicao;
vlSKeyEmpresa    := psKeyEmpresa;
vlsKeyProduto    := psKeyProduto;
key_empresa.Text := vlSKeyEmpresa;

if not vlBEdicao then
   begin
   pcdLimparCampos;
   end
else
   begin
   carregarProduto();
   key_empresa.Text    := dmPrincipal.FDConsultas.FieldByName('KEY_EMPRESA').AsString;
   key_produto.Text    := dmPrincipal.FDConsultas.FieldByName('KEY_PRODUTO').AsString;
   descricao.Text      := dmPrincipal.FDConsultas.FieldByName('DESCRICAO').AsString;
   complemento.Text    := dmPrincipal.FDConsultas.FieldByName('COMPLEMENTOS').AsString;
   grupo.Text          := dmPrincipal.FDConsultas.FieldByName('GRUPO').AsString;
   valor_meia.Value    := dmPrincipal.FDConsultas.FieldByName('VALOR_MEIA').AsFloat;
   valor_inteira.Value := dmPrincipal.FDConsultas.FieldByName('VALOR_INTEIRA').AsFloat;
   end;

descricao.SetFocus;
end;

procedure TFPrincipal.carregarProduto();
begin
dmPrincipal.FDConsultas.Close;
dmPrincipal.FDConsultas.SQL.Clear;
dmPrincipal.FDConsultas.SQL.Add('SELECT KEY_EMPRESA, KEY_PRODUTO, DESCRICAO,');
dmPrincipal.FDConsultas.SQL.Add('       COMPLEMENTOS, GRUPO, VALOR_INTEIRA, VALOR_MEIA');
dmPrincipal.FDConsultas.SQL.Add('FROM PRODUTOS WHERE (KEY_EMPRESA = :KEY_EMPRESA) AND (KEY_PRODUTO = :KEY_PRODUTO)');
dmPrincipal.FDConsultas.ParamByName('KEY_EMPRESA').AsString := vlSKeyEmpresa;
dmPrincipal.FDConsultas.ParamByName('KEY_PRODUTO').AsString := vlsKeyProduto;
dmPrincipal.FDConsultas.Open();
end;

procedure TFPrincipal.pcdLimparCampos();
begin
key_empresa.Text    := constkey_empresa;
key_produto.Text    := fncGeraKeyProduto(19);
descricao.Text      := '';
complemento.Text    := '';
grupo.Text          := '';
valor_meia.Value    := 0;
valor_inteira.Value := 0;

descricao.SetFocus;
end;

Function TFPrincipal.fncGeraKeyProduto(max: Integer):String;
var
   i:Integer;
   r:String;
const
   str='1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
begin
for i:=1 to max do
   r := r + str[random(length(str))+1];

Result := '-' + r;
end;

end.
