unit ServerMethodsUnit1;

interface

uses System.SysUtils, System.Classes, System.Json,
     Datasnap.DSServer, Datasnap.DSAuth, DataSnap.DSProviderDataModuleAdapter,
     FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
     FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
     FireDAC.Phys, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
     FireDAC.DApt, FireDAC.Phys.FBDef, FireDAC.Phys.IBBase, FireDAC.Phys.FB,
     FireDAC.Stan.StorageBin, FireDAC.Stan.StorageJSON, FireDAC.Comp.Client,
     Data.DB, FireDAC.Comp.DataSet, Data.FireDACJSONReflect;

type
  TServerMethods1 = class(TDSServerModule)
    cnnConexaoServidor: TFDConnection;
    qryProdutos: TFDQuery;
    qryInsercao: TFDQuery;
    memAuxiliar: TFDMemTable;
    FDStanStorageJSONLink1: TFDStanStorageJSONLink;
    FDStanStorageBinLink1: TFDStanStorageBinLink;
    driver: TFDPhysFBDriverLink;
  private
    { Private declarations }
    function ExisteProduto(ACodigo, ANome: String): Boolean;
  public
    { Public declarations }
    function EchoString(Value: string): string;
    function ReverseString(Value: string): string;
    function GetProdutos(): TFDJSONDataSets;
    function InsereProdutosCliente(AProdutos: TFDJSONDataSets): Boolean;
  end;

implementation


{$R *.dfm}


uses System.StrUtils;

function TServerMethods1.EchoString(Value: string): string;
begin
  Result := Value;
end;

function TServerMethods1.ExisteProduto(ACodigo, ANome: String): Boolean;
begin
with TFDQuery.Create(Self) do
   try
   Connection := cnnConexaoServidor;
   SQL.Text := 'select idproduto from produtos where cod = :cod and descricao = :descricao';
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

function TServerMethods1.GetProdutos: TFDJSONDataSets;
begin
qryProdutos.Active := False;
qryProdutos.SQL.Add('select cod, descricao from produtos');
Result := TFDJSONDataSets.Create;
TFDJSONDataSetsWriter.ListAdd(Result, qryProdutos);
end;

function TServerMethods1.InsereProdutosCliente(
  AProdutos: TFDJSONDataSets): Boolean;
var
   ACodigo, ADescricao: String;
begin
Result := False;
if TFDJSONDataSetsReader.GetListCount(AProdutos) = 1 then
   begin
   memAuxiliar.Active := False;
   memAuxiliar.AppendData(TFDJSONDataSetsReader.GetListValue(AProdutos, 0));
   qryInsercao.SQL.Clear;
   qryInsercao.SQL.Add('insert into produtos (cod, descricao) values (:cod, :descricao)');
   while not memAuxiliar.Eof do
      begin
      ACodigo := memAuxiliar.FieldByName('codigo').AsString;
      ADescricao := memAuxiliar.FieldByName('nome').AsString;
      if not ExisteProduto(ACodigo, ADescricao) then
         begin
         qryInsercao.ParamByName('cod').AsString := ACodigo;
         qryInsercao.ParamByName('descricao').AsString := ADescricao;
         qryInsercao.ExecSQL;
         end;
      memAuxiliar.Next;
      end;
   Result := True;
   end;
end;

function TServerMethods1.ReverseString(Value: string): string;
begin
  Result := System.StrUtils.ReverseString(Value);
end;
end.

