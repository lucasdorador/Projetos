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
    function fncRetornaItensPedido(poChavePedive: String): TJsonArray;
    function fncRetornaVencimentoPedido(poChavePedive: String): TJsonArray;
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

Form1.pcdMensagemMemo('Requisi��o Enviada com par�metro: Empresa: ' + vlsEmpresa.Value + ' Pedido: ' + vlsPedido.Value + ' na fun��o fncRetornaDadosPedido');
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

Form1.pcdMensagemMemo('Requisi��o Entregue com o par�metro: ' + vlJsonObject.ToString + ' da fun��o fncRetornaDadosPedido');
Result := ja;
end;

function Service.fncRetornaItensPedido(poChavePedive: String): TJsonArray;
var
   vlJsonObject : TJSONObject;
   vlsEmpresa, vlsPedido : TJSONString;
   ja:TJsonArray;
   I: Integer;
begin
vlJsonObject := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(poChavePedive), 0) as TJSONObject;

vlsEmpresa := vlJsonObject.GetValue('Pedv_Empresa') as TJSONString;
vlsPedido  := vlJsonObject.GetValue('Pedv_Numero') as TJSONString;

Form1.pcdMensagemMemo('Requisi��o Enviada com par�metro: Empresa: ' + vlsEmpresa.Value + ' Pedido: ' + vlsPedido.Value + ' na fun��o fncRetornaItensPedido');
DMPrincipal.FDItensPedido.Close;
DMPrincipal.FDItensPedido.ParamByName('EMPRESA').AsString := vlsEmpresa.Value;
DMPrincipal.FDItensPedido.ParamByName('NUMERO').AsString  := vlsPedido.Value;
DMPrincipal.FDItensPedido.Open();

ja := TJsonArray.Create;
vlJsonObject := TJSONObject.Create;

DMPrincipal.FDItensPedido.First;
DMPrincipal.FDItensPedido.FetchAll;

for I := 0 to DMPrincipal.FDItensPedido.RecordCount - 1 do
   begin
   vlJsonObject.AddPair('Produto', DMPrincipal.FDItensPedido.FieldByName('Produto').AsString);
   vlJsonObject.AddPair('Qtde', DMPrincipal.FDItensPedido.FieldByName('Qtde').AsString);
   vlJsonObject.AddPair('Unitario', DMPrincipal.FDItensPedido.FieldByName('Unitario').AsString);
   vlJsonObject.AddPair('Total', DMPrincipal.FDItensPedido.FieldByName('Total').AsString);
   end;

ja.AddElement(vlJsonObject);

Form1.pcdMensagemMemo('Requisi��o Entregue com o par�metro: ' + vlJsonObject.ToString + ' da fun��o fncRetornaItensPedido');
Result := ja;
end;

function Service.fncRetornaVencimentoPedido(poChavePedive: String): TJsonArray;
var
   vlJsonObject : TJSONObject;
   vlsEmpresa, vlsPedido : TJSONString;
   ja:TJsonArray;
   I: Integer;
begin
vlJsonObject := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(poChavePedive), 0) as TJSONObject;

vlsEmpresa := vlJsonObject.GetValue('Pedv_Empresa') as TJSONString;
vlsPedido  := vlJsonObject.GetValue('Pedv_Numero') as TJSONString;

Form1.pcdMensagemMemo('Requisi��o Enviada com par�metro: Empresa: ' + vlsEmpresa.Value + ' Pedido: ' + vlsPedido.Value + ' na fun��o fncRetornaVencimentoPedido');
DMPrincipal.FDVencimentosPedido.Close;
DMPrincipal.FDVencimentosPedido.ParamByName('EMPRESA').AsString := vlsEmpresa.Value;
DMPrincipal.FDVencimentosPedido.ParamByName('NUMERO').AsString  := vlsPedido.Value;
DMPrincipal.FDVencimentosPedido.Open();

ja := TJsonArray.Create;
vlJsonObject := TJSONObject.Create;

DMPrincipal.FDVencimentosPedido.First;
DMPrincipal.FDVencimentosPedido.FetchAll;

for I := 0 to DMPrincipal.FDVencimentosPedido.RecordCount - 1 do
   begin
   vlJsonObject.AddPair('DataVenc', DMPrincipal.FDVencimentosPedido.FieldByName('DataVenc').AsString);
   vlJsonObject.AddPair('Docto', DMPrincipal.FDVencimentosPedido.FieldByName('Docto').AsString);
   vlJsonObject.AddPair('Status', DMPrincipal.FDVencimentosPedido.FieldByName('Status').AsString);
   vlJsonObject.AddPair('Cobranca', DMPrincipal.FDVencimentosPedido.FieldByName('Cobranca').AsString);
   end;

ja.AddElement(vlJsonObject);

Form1.pcdMensagemMemo('Requisi��o Entregue com o par�metro: ' + vlJsonObject.ToString + ' da fun��o fncRetornaVencimentoPedido');
Result := ja;
end;


function Service.Ping: String;
begin
  Form1.pcdMensagemMemo('Teste de Conex�o na fun��o Ping');
  Result := 'Ok';
end;

function Service.ReverseString(Value: string): string;
begin
  Result := System.StrUtils.ReverseString(Value);
end;
end.

