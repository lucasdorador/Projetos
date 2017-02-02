//
// Created by the DataSnap proxy generator.
// 01/02/2017 21:02:41
//

unit ClientClassesUnit1;

interface

uses System.JSON, Datasnap.DSProxyRest, Datasnap.DSClientRest, Data.DBXCommon, Data.DBXClient, Data.DBXDataSnap, Data.DBXJSON, Datasnap.DSProxy, System.Classes, System.SysUtils, Data.DB, Data.SqlExpr, Data.DBXDBReaders, Data.DBXCDSReaders, Data.FireDACJSONReflect, Data.DBXJSONReflect;

type

  IDSRestCachedTFDJSONDataSets = interface;

  TServerMethods1Client = class(TDSAdminRestClient)
  private
    FEchoStringCommand: TDSRestCommand;
    FReverseStringCommand: TDSRestCommand;
    FGetProdutosCommand: TDSRestCommand;
    FGetProdutosCommand_Cache: TDSRestCommand;
    FInsereProdutosClienteCommand: TDSRestCommand;
  public
    constructor Create(ARestConnection: TDSRestConnection); overload;
    constructor Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function EchoString(Value: string; const ARequestFilter: string = ''): string;
    function ReverseString(Value: string; const ARequestFilter: string = ''): string;
    function GetProdutos(const ARequestFilter: string = ''): TFDJSONDataSets;
    function GetProdutos_Cache(const ARequestFilter: string = ''): IDSRestCachedTFDJSONDataSets;
    function InsereProdutosCliente(AProdutos: TFDJSONDataSets; const ARequestFilter: string = ''): Boolean;
  end;

  IDSRestCachedTFDJSONDataSets = interface(IDSRestCachedObject<TFDJSONDataSets>)
  end;

  TDSRestCachedTFDJSONDataSets = class(TDSRestCachedObject<TFDJSONDataSets>, IDSRestCachedTFDJSONDataSets, IDSRestCachedCommand)
  end;

const
  TServerMethods1_EchoString: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Value'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TServerMethods1_ReverseString: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Value'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TServerMethods1_GetProdutos: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TFDJSONDataSets')
  );

  TServerMethods1_GetProdutos_Cache: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TServerMethods1_InsereProdutosCliente: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'AProdutos'; Direction: 1; DBXType: 37; TypeName: 'TFDJSONDataSets'),
    (Name: ''; Direction: 4; DBXType: 4; TypeName: 'Boolean')
  );

implementation

function TServerMethods1Client.EchoString(Value: string; const ARequestFilter: string): string;
begin
  if FEchoStringCommand = nil then
  begin
    FEchoStringCommand := FConnection.CreateCommand;
    FEchoStringCommand.RequestType := 'GET';
    FEchoStringCommand.Text := 'TServerMethods1.EchoString';
    FEchoStringCommand.Prepare(TServerMethods1_EchoString);
  end;
  FEchoStringCommand.Parameters[0].Value.SetWideString(Value);
  FEchoStringCommand.Execute(ARequestFilter);
  Result := FEchoStringCommand.Parameters[1].Value.GetWideString;
end;

function TServerMethods1Client.ReverseString(Value: string; const ARequestFilter: string): string;
begin
  if FReverseStringCommand = nil then
  begin
    FReverseStringCommand := FConnection.CreateCommand;
    FReverseStringCommand.RequestType := 'GET';
    FReverseStringCommand.Text := 'TServerMethods1.ReverseString';
    FReverseStringCommand.Prepare(TServerMethods1_ReverseString);
  end;
  FReverseStringCommand.Parameters[0].Value.SetWideString(Value);
  FReverseStringCommand.Execute(ARequestFilter);
  Result := FReverseStringCommand.Parameters[1].Value.GetWideString;
end;

function TServerMethods1Client.GetProdutos(const ARequestFilter: string): TFDJSONDataSets;
begin
  if FGetProdutosCommand = nil then
  begin
    FGetProdutosCommand := FConnection.CreateCommand;
    FGetProdutosCommand.RequestType := 'GET';
    FGetProdutosCommand.Text := 'TServerMethods1.GetProdutos';
    FGetProdutosCommand.Prepare(TServerMethods1_GetProdutos);
  end;
  FGetProdutosCommand.Execute(ARequestFilter);
  if not FGetProdutosCommand.Parameters[0].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FGetProdutosCommand.Parameters[0].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FGetProdutosCommand.Parameters[0].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetProdutosCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TServerMethods1Client.GetProdutos_Cache(const ARequestFilter: string): IDSRestCachedTFDJSONDataSets;
begin
  if FGetProdutosCommand_Cache = nil then
  begin
    FGetProdutosCommand_Cache := FConnection.CreateCommand;
    FGetProdutosCommand_Cache.RequestType := 'GET';
    FGetProdutosCommand_Cache.Text := 'TServerMethods1.GetProdutos';
    FGetProdutosCommand_Cache.Prepare(TServerMethods1_GetProdutos_Cache);
  end;
  FGetProdutosCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTFDJSONDataSets.Create(FGetProdutosCommand_Cache.Parameters[0].Value.GetString);
end;

function TServerMethods1Client.InsereProdutosCliente(AProdutos: TFDJSONDataSets; const ARequestFilter: string): Boolean;
begin
  if FInsereProdutosClienteCommand = nil then
  begin
    FInsereProdutosClienteCommand := FConnection.CreateCommand;
    FInsereProdutosClienteCommand.RequestType := 'POST';
    FInsereProdutosClienteCommand.Text := 'TServerMethods1."InsereProdutosCliente"';
    FInsereProdutosClienteCommand.Prepare(TServerMethods1_InsereProdutosCliente);
  end;
  if not Assigned(AProdutos) then
    FInsereProdutosClienteCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FInsereProdutosClienteCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FInsereProdutosClienteCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(AProdutos), True);
      if FInstanceOwner then
        AProdutos.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FInsereProdutosClienteCommand.Execute(ARequestFilter);
  Result := FInsereProdutosClienteCommand.Parameters[1].Value.GetBoolean;
end;

constructor TServerMethods1Client.Create(ARestConnection: TDSRestConnection);
begin
  inherited Create(ARestConnection);
end;

constructor TServerMethods1Client.Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ARestConnection, AInstanceOwner);
end;

destructor TServerMethods1Client.Destroy;
begin
  FEchoStringCommand.DisposeOf;
  FReverseStringCommand.DisposeOf;
  FGetProdutosCommand.DisposeOf;
  FGetProdutosCommand_Cache.DisposeOf;
  FInsereProdutosClienteCommand.DisposeOf;
  inherited;
end;

end.

