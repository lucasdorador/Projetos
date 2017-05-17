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
    function fncRetornaDadosPedido(id_pedido: String): TJSONObject;

  end;
{$METHODINFO OFF}

implementation


uses System.StrUtils, uDmPrincipal, Vcl.Dialogs, DataSetConverter4D.Helper,
  uDashBoard;

function Service.EchoString(Value: string): string;
begin
  Result := Value;
end;

function Service.fncRetornaDadosPedido(id_pedido: String): TJSONObject;
var
   vlJsonObject : TJSONObject;
begin
Form1.pcdMensagemMemo('Requisi��o Enviada com par�metro: ' + id_pedido + ' na fun��o fncRetornaDadosPedido');
DMPrincipal.FDQuery1.Close;
DMPrincipal.FDQuery1.ParamByName('EMPRESA').AsString := '01';
DMPrincipal.FDQuery1.ParamByName('NUMERO').AsString  := id_pedido;
DMPrincipal.FDQuery1.Open();

vlJsonObject := TJSONObject.Create;

vlJsonObject.AddPair('Cliente', TJSONString.Create(DMPrincipal.FDQuery1.FieldByName('PEDV_CLIENTE').AsString));
vlJsonObject.AddPair('Razao', TJSONString.Create(DMPrincipal.FDQuery1.FieldByName('CLI_RAZAO').AsString));

Form1.pcdMensagemMemo('Requisi��o Entregue com o par�metro: ' + vlJsonObject.ToString + ' da fun��o fncRetornaDadosPedido');
Result := vlJsonObject;
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

