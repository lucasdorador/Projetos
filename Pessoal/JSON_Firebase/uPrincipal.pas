unit uPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit, FMX.EditBox, FMX.NumberBox,
  udmPrincipal, uMenuInicial, uConstantes;

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
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
  private
    vlBEdicao : Boolean;
    vlSKeyEmpresa, vlsKeyProduto: String;
    function fncGeraKeyProduto(max: Integer): String;
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

procedure TFPrincipal.FormShow(Sender: TObject);
begin
key_empresa.Text := constkey_empresa;

if not vlBEdicao then
   key_produto.Text := fncGeraKeyProduto(19);

key_produto.SetFocus;
end;

procedure TFPrincipal.setTelaInicial(pbEdicao: Boolean; psKeyEmpresa, psKeyProduto: String);
begin
vlBEdicao     := pbEdicao;
vlSKeyEmpresa := psKeyEmpresa;
vlsKeyProduto := psKeyProduto;
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
