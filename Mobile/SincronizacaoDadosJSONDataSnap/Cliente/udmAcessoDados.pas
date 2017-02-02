unit udmAcessoDados;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.Client, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Stan.StorageJSON, FireDAC.Phys.SQLite, FireDAC.FMXUI.Wait,
  FireDAC.Comp.UI, ClientModuleUnit1, Data.FireDACJSONReflect, FMX.Dialogs;

type
  TdmAcessoDados = class(TDataModule)
    cnnConexao: TFDConnection;
    driver: TFDPhysSQLiteDriverLink;
    json: TFDStanStorageJSONLink;
    qryProdutos: TFDQuery;
    qryInsercao: TFDQuery;
    memInsercao: TFDMemTable;
    qryProdutosidproduto: TFDAutoIncField;
    qryProdutoscodigo: TStringField;
    qryProdutosnome: TStringField;
    WaitCursor: TFDGUIxWaitCursor;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    function ExisteProduto(ACodigo, ANome: String): Boolean;
  public
    { Public declarations }
    procedure AtualizaProdutosDoServidor;
    procedure EnviaProdutosParaServidor;
  end;

var
  dmAcessoDados: TdmAcessoDados;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure TdmAcessoDados.AtualizaProdutosDoServidor;
var
   dsProdutos: TFDJSONDataSets;
   ACodigo, ANome: String;
   vlCliente1 : TClientModule1;
begin
vlCliente1 := TClientModule1.Create(Self);
dsProdutos := vlCliente1.ServerMethods1Client.GetProdutos();
if TFDJSONDataSetsReader.GetListCount(dsProdutos) = 1 then
   begin
   memInsercao.Active := false;
   memInsercao.AppendData(TFDJSONDataSetsReader.GetListValue(dsProdutos, 0));
   qryInsercao.SQL.Clear;
   qryInsercao.SQL.Add('insert into produtos (codigo, nome) values (:codigo, :nome)');
   while not memInsercao.Eof do
      begin
      ACodigo := memInsercao.FieldByName('cod').AsString;
      ANome := memInsercao.FieldByName('descricao').AsString;
      if not ExisteProduto(ACodigo, ANome) then
         begin
         qryInsercao.ParamByName('codigo').AsString := ACodigo;
         qryInsercao.ParamByName('nome').AsString := ANome;
         qryInsercao.ExecSQL;
         end;
      memInsercao.Next;
      end;
   end;
end;

procedure TdmAcessoDados.DataModuleCreate(Sender: TObject);
begin
qryProdutos.Open();
end;

procedure TdmAcessoDados.EnviaProdutosParaServidor;
var
dsProdutos: TFDJSONDataSets;
vlCliente1 : TClientModule1;
begin
vlCliente1 := TClientModule1.Create(Self);
dsProdutos := TFDJSONDataSets.Create;
TFDJSONDataSetsWriter.ListAdd(dsProdutos, qryProdutos);

if not vlCliente1.ServerMethods1Client.InsereProdutosCliente(dsProdutos) then
   ShowMessage('Erro ao enviar para o servidor');
end;

function TdmAcessoDados.ExisteProduto(ACodigo, ANome: String): Boolean;
begin
with TFDQuery.Create(Self) do
   try
   Connection := cnnConexao;
   SQL.Text := 'select idproduto from produtos where codigo = :codigo and nome = :nome';
   Params[0].AsString := ACodigo;
   Params[1].AsString := ANome;
   Open();
   if IsEmpty then
      Result := False
   else
      Result := True;
   finally
      Free;
      end;
end;

end.
