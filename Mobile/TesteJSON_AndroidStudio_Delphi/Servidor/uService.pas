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

Form1.pcdMensagemMemo('Requisição Enviada com parâmetro: Empresa: ' + vlsEmpresa.Value + ' Pedido: ' + vlsPedido.Value + ' na função fncRetornaDadosPedido');
DMPrincipal.FDQuery1.Close;
DMPrincipal.FDQuery1.ParamByName('EMPRESA').AsString := vlsEmpresa.Value;
DMPrincipal.FDQuery1.ParamByName('NUMERO').AsString  := vlsPedido.Value;
DMPrincipal.FDQuery1.Open();

ja := TJsonArray.Create;
vlJsonObject := TJSONObject.Create;

vlJsonObject.AddPair('Cliente', TJSONString.Create(DMPrincipal.FDQuery1.FieldByName('PEDV_CLIENTE').AsString));
vlJsonObject.AddPair('Razao', TJSONString.Create(DMPrincipal.FDQuery1.FieldByName('CLI_RAZAO').AsString));
ja.AddElement(vlJsonObject);

Form1.pcdMensagemMemo('Requisição Entregue com o parâmetro: ' + vlJsonObject.ToString + ' da função fncRetornaDadosPedido');
Result := ja;
end;

function Service.Ping: String;
begin
  Form1.pcdMensagemMemo('Teste de Conexão na função Ping');
  Result := 'Ok';
end;

function Service.ReverseString(Value: string): string;
begin
  Result := System.StrUtils.ReverseString(Value);
end;
end.

