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

Form1.pcdMensagemMemo('Requisi��o Enviada com par�metro: Empresa: ' + vlsEmpresa.Value + ' Pedido: ' + vlsPedido.Value + ' na fun��o fncRetornaDadosPedido');
DMPrincipal.FDQuery1.Close;
DMPrincipal.FDQuery1.ParamByName('EMPRESA').AsString := vlsEmpresa.Value;
DMPrincipal.FDQuery1.ParamByName('NUMERO').AsString  := vlsPedido.Value;
DMPrincipal.FDQuery1.Open();

ja := TJsonArray.Create;
vlJsonObject := TJSONObject.Create;

vlJsonObject.AddPair('Cliente', TJSONString.Create(DMPrincipal.FDQuery1.FieldByName('PEDV_CLIENTE').AsString));
vlJsonObject.AddPair('Razao', TJSONString.Create(DMPrincipal.FDQuery1.FieldByName('CLI_RAZAO').AsString));
ja.AddElement(vlJsonObject);

Form1.pcdMensagemMemo('Requisi��o Entregue com o par�metro: ' + vlJsonObject.ToString + ' da fun��o fncRetornaDadosPedido');
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

