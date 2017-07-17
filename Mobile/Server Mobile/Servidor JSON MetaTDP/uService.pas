unit uService;

interface

uses System.SysUtils, System.Classes, Datasnap.DSServer, Datasnap.DSAuth,
     System.JSON, FireDAc.Comp.Client, FireDAc.Dapt;

type
{$METHODINFO ON}
  Service = class(TComponent)
  private
    { Private declarations }
  public
    { Public declarations }
    function EchoString(Value: string): string;
    function ReverseString(Value: string): string;
    function Ping: String;
    function fncRetornaItensPedido(poChavePedive: String): TJSONObject;
    function fncRetornaVencimentoPedido(poChavePedive: String): TJSONObject;
    function fncRetornaDadosPedido(poChavePedive: String): TJsonArray;

  end;
{$METHODINFO OFF}

implementation


uses System.StrUtils, uDmPrincipal, Vcl.Dialogs,  uDashBoard;

function Service.EchoString(Value: string): string;
begin
  Result := Value;
end;

function Service.fncRetornaDadosPedido(poChavePedive: String): TJsonArray;
var
   vlJsonObject : TJSONObject;
   vlsEmpresa, vlsPedido : TJSONString;
   ja:TJsonArray;
begin
vlJsonObject := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(poChavePedive), 0) as TJSONObject;

vlsEmpresa := vlJsonObject.GetValue('Pedv_Empresa') as TJSONString;
vlsPedido  := vlJsonObject.GetValue('Pedv_Numero') as TJSONString;

FDashBoard.pcdMensagemMemo('Requisi��o Enviada com par�metro: Empresa: ' + vlsEmpresa.Value + ' Pedido: ' + vlsPedido.Value + ' na fun��o fncRetornaDadosPedido');
DMPrincipal.FDCabecalhoPedido.Close;
DMPrincipal.FDCabecalhoPedido.ParamByName('EMPRESA').AsString := vlsEmpresa.Value;
DMPrincipal.FDCabecalhoPedido.ParamByName('NUMERO').AsString  := vlsPedido.Value;
DMPrincipal.FDCabecalhoPedido.Open();

ja := TJsonArray.Create;
vlJsonObject := TJSONObject.Create;

vlJsonObject.AddPair('Empresa', DMPrincipal.FDCabecalhoPedido.FieldByName('Empresa').AsString);
vlJsonObject.AddPair('Pedido', DMPrincipal.FDCabecalhoPedido.FieldByName('Pedido').AsString);
vlJsonObject.AddPair('Cliente', DMPrincipal.FDCabecalhoPedido.FieldByName('Cliente').AsString);
vlJsonObject.AddPair('DataPedido', DMPrincipal.FDCabecalhoPedido.FieldByName('DataPedido').AsString);
vlJsonObject.AddPair('Negociacao', DMPrincipal.FDCabecalhoPedido.FieldByName('Negociacao').AsString);
vlJsonObject.AddPair('Status', DMPrincipal.FDCabecalhoPedido.FieldByName('Status').AsString);

ja.AddElement(vlJsonObject);

FDashBoard.pcdMensagemMemo('Requisi��o Entregue com o par�metro: ' + vlJsonObject.ToString + ' da fun��o fncRetornaDadosPedido');
Result := ja;
end;

function Service.fncRetornaItensPedido(poChavePedive: String): TJSONObject;
var
   vlJsonObject, vlPropertyJson : TJSONObject;
   vlsEmpresa, vlsPedido : TJSONString;
   vlJsonList:TJsonArray;
   vlI: Integer;
//   SSArquivoStream: TStringStream;
begin
vlJsonObject := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(poChavePedive), 0) as TJSONObject;

vlsEmpresa := vlJsonObject.GetValue('Pedv_Empresa') as TJSONString;
vlsPedido  := vlJsonObject.GetValue('Pedv_Numero') as TJSONString;

FDashBoard.pcdMensagemMemo('Requisi��o Enviada com par�metro: Empresa: ' + vlsEmpresa.Value + ' Pedido: ' + vlsPedido.Value + ' na fun��o fncRetornaItensPedido');
DMPrincipal.FDItensPedido.Close;
DMPrincipal.FDItensPedido.ParamByName('EMPRESA').AsString := vlsEmpresa.Value;
DMPrincipal.FDItensPedido.ParamByName('NUMERO').AsString  := vlsPedido.Value;
DMPrincipal.FDItensPedido.Open();

vlJsonList   := TJsonArray.Create;
vlJsonObject := TJSONObject.Create;

DMPrincipal.FDItensPedido.First;
DMPrincipal.FDItensPedido.FetchAll;

//for I := 0 to DMPrincipal.FDItensPedido.RecordCount - 1 do
while not DMPrincipal.FDItensPedido.Eof do
   begin
   vlPropertyJson := TJSONObject.Create;
   vlPropertyJson.AddPair('Produto', DMPrincipal.FDItensPedido.FieldByName('Produto').AsString);
   vlPropertyJson.AddPair('Qtde', StringReplace(DMPrincipal.FDItensPedido.FieldByName('Qtde').AsString,',', '.',[rfReplaceAll]));
   vlPropertyJson.AddPair('Unitario', StringReplace(DMPrincipal.FDItensPedido.FieldByName('Unitario').AsString,',', '.',[rfReplaceAll]));
   vlPropertyJson.AddPair('Total', StringReplace(DMPrincipal.FDItensPedido.FieldByName('Total').AsString,',', '.',[rfReplaceAll]));
   vlJsonList.AddElement(vlPropertyJson);

   DMPrincipal.FDItensPedido.Next;
   end;

vlJsonObject.AddPair('Itens', vlJsonList);

//SSArquivoStream := TStringStream.Create(vlJsonObject.ToString);
//SSArquivoStream.SaveToFile('C:\JSON.txt');

FDashBoard.pcdMensagemMemo('Requisi��o Entregue com o par�metro: ' + vlJsonObject.ToString + ' da fun��o fncRetornaItensPedido');
Result := vlJsonObject;
end;

function Service.fncRetornaVencimentoPedido(poChavePedive: String): TJSONObject;
var
   vlJsonObject, vlPropertyJson : TJSONObject;
   vlsEmpresa, vlsPedido : TJSONString;
   vlJsonList:TJsonArray;
   I: Integer;
//   SSArquivoStream: TStringStream;
begin
vlJsonObject := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(poChavePedive), 0) as TJSONObject;

vlsEmpresa := vlJsonObject.GetValue('Pedv_Empresa') as TJSONString;
vlsPedido  := vlJsonObject.GetValue('Pedv_Numero') as TJSONString;

FDashBoard.pcdMensagemMemo('Requisi��o Enviada com par�metro: Empresa: ' + vlsEmpresa.Value + ' Pedido: ' + vlsPedido.Value + ' na fun��o fncRetornaVencimentoPedido');
DMPrincipal.FDVencimentosPedido.Close;
DMPrincipal.FDVencimentosPedido.ParamByName('EMPRESA').AsString := vlsEmpresa.Value;
DMPrincipal.FDVencimentosPedido.ParamByName('NUMERO').AsString  := vlsPedido.Value;
DMPrincipal.FDVencimentosPedido.Open();

vlJsonList   := TJsonArray.Create;
vlJsonObject := TJSONObject.Create;

DMPrincipal.FDVencimentosPedido.First;
DMPrincipal.FDVencimentosPedido.FetchAll;

//for I := 0 to DMPrincipal.FDVencimentosPedido.RecordCount - 1 do
while not DMPrincipal.FDVencimentosPedido.Eof do
   begin
   vlPropertyJson := TJSONObject.Create;
   vlPropertyJson.AddPair('DataVenc', DMPrincipal.FDVencimentosPedido.FieldByName('DataVenc').AsString);
   vlPropertyJson.AddPair('Docto', DMPrincipal.FDVencimentosPedido.FieldByName('Docto').AsString);
   vlPropertyJson.AddPair('Status', DMPrincipal.FDVencimentosPedido.FieldByName('Status').AsString);
   vlPropertyJson.AddPair('Cobranca', DMPrincipal.FDVencimentosPedido.FieldByName('Cobranca').AsString);
   vlJsonList.Add(vlPropertyJson);

   DMPrincipal.FDVencimentosPedido.Next;
   end;

vlJsonObject.AddPair('Vencimentos', vlJsonList);

//SSArquivoStream := TStringStream.Create(vlJsonObject.ToString);
//SSArquivoStream.SaveToFile('C:\JSON.txt');

FDashBoard.pcdMensagemMemo('Requisi��o Entregue com o par�metro: ' + vlJsonObject.ToString + ' da fun��o fncRetornaVencimentoPedido');
Result := vlJsonObject;
end;


function Service.Ping: String;
begin
  FDashBoard.pcdMensagemMemo('Teste de Conex�o na fun��o Ping');
  Result := 'Ok';
end;

function Service.ReverseString(Value: string): string;
begin
  Result := System.StrUtils.ReverseString(Value);
end;
end.

