//
// Created by the DataSnap proxy generator.
// 22/02/2017 22:48:12
//

unit ClientClassesUnit1;

interface

uses System.JSON, Datasnap.DSProxyRest, Datasnap.DSClientRest, Data.DBXCommon, Data.DBXClient, Data.DBXDataSnap, Data.DBXJSON, Datasnap.DSProxy, System.Classes, System.SysUtils, Data.DB, Data.SqlExpr, Data.DBXDBReaders, Data.DBXCDSReaders, Data.FireDACJSONReflect, Data.DBXJSONReflect;

type

  IDSRestCachedTFDJSONDataSets = interface;

  TServerMethods1Client = class(TDSAdminRestClient)
  private
    FDataModuleDestroyCommand: TDSRestCommand;
    FDataModuleCreateCommand: TDSRestCommand;
    FEchoStringCommand: TDSRestCommand;
    FReverseStringCommand: TDSRestCommand;
    FfncTesteServidorCommand: TDSRestCommand;
    FfncBuscaChequesCommand: TDSRestCommand;
    FfncBuscaChequesCommand_Cache: TDSRestCommand;
  public
    constructor Create(ARestConnection: TDSRestConnection); overload;
    constructor Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
    function EchoString(Value: string; const ARequestFilter: string = ''): string;
    function ReverseString(Value: string; const ARequestFilter: string = ''): string;
    function fncTesteServidor(const ARequestFilter: string = ''): string;
    function fncBuscaCheques(const ARequestFilter: string = ''): TFDJSONDataSets;
    function fncBuscaCheques_Cache(const ARequestFilter: string = ''): IDSRestCachedTFDJSONDataSets;
  end;

  IDSRestCachedTFDJSONDataSets = interface(IDSRestCachedObject<TFDJSONDataSets>)
  end;

  TDSRestCachedTFDJSONDataSets = class(TDSRestCachedObject<TFDJSONDataSets>, IDSRestCachedTFDJSONDataSets, IDSRestCachedCommand)
  end;

const
  TServerMethods1_DataModuleDestroy: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: 'Sender'; Direction: 1; DBXType: 37; TypeName: 'TObject')
  );

  TServerMethods1_DataModuleCreate: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: 'Sender'; Direction: 1; DBXType: 37; TypeName: 'TObject')
  );

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

  TServerMethods1_fncTesteServidor: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TServerMethods1_fncBuscaCheques: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TFDJSONDataSets')
  );

  TServerMethods1_fncBuscaCheques_Cache: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

implementation

procedure TServerMethods1Client.DataModuleDestroy(Sender: TObject);
begin
  if FDataModuleDestroyCommand = nil then
  begin
    FDataModuleDestroyCommand := FConnection.CreateCommand;
    FDataModuleDestroyCommand.RequestType := 'POST';
    FDataModuleDestroyCommand.Text := 'TServerMethods1."DataModuleDestroy"';
    FDataModuleDestroyCommand.Prepare(TServerMethods1_DataModuleDestroy);
  end;
  if not Assigned(Sender) then
    FDataModuleDestroyCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FDataModuleDestroyCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FDataModuleDestroyCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(Sender), True);
      if FInstanceOwner then
        Sender.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FDataModuleDestroyCommand.Execute;
end;

procedure TServerMethods1Client.DataModuleCreate(Sender: TObject);
begin
  if FDataModuleCreateCommand = nil then
  begin
    FDataModuleCreateCommand := FConnection.CreateCommand;
    FDataModuleCreateCommand.RequestType := 'POST';
    FDataModuleCreateCommand.Text := 'TServerMethods1."DataModuleCreate"';
    FDataModuleCreateCommand.Prepare(TServerMethods1_DataModuleCreate);
  end;
  if not Assigned(Sender) then
    FDataModuleCreateCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FDataModuleCreateCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FDataModuleCreateCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(Sender), True);
      if FInstanceOwner then
        Sender.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FDataModuleCreateCommand.Execute;
end;

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

function TServerMethods1Client.fncTesteServidor(const ARequestFilter: string): string;
begin
  if FfncTesteServidorCommand = nil then
  begin
    FfncTesteServidorCommand := FConnection.CreateCommand;
    FfncTesteServidorCommand.RequestType := 'GET';
    FfncTesteServidorCommand.Text := 'TServerMethods1.fncTesteServidor';
    FfncTesteServidorCommand.Prepare(TServerMethods1_fncTesteServidor);
  end;
  FfncTesteServidorCommand.Execute(ARequestFilter);
  Result := FfncTesteServidorCommand.Parameters[0].Value.GetWideString;
end;

function TServerMethods1Client.fncBuscaCheques(const ARequestFilter: string): TFDJSONDataSets;
begin
  if FfncBuscaChequesCommand = nil then
  begin
    FfncBuscaChequesCommand := FConnection.CreateCommand;
    FfncBuscaChequesCommand.RequestType := 'GET';
    FfncBuscaChequesCommand.Text := 'TServerMethods1.fncBuscaCheques';
    FfncBuscaChequesCommand.Prepare(TServerMethods1_fncBuscaCheques);
  end;
  FfncBuscaChequesCommand.Execute(ARequestFilter);
  if not FfncBuscaChequesCommand.Parameters[0].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FfncBuscaChequesCommand.Parameters[0].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FfncBuscaChequesCommand.Parameters[0].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FfncBuscaChequesCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TServerMethods1Client.fncBuscaCheques_Cache(const ARequestFilter: string): IDSRestCachedTFDJSONDataSets;
begin
  if FfncBuscaChequesCommand_Cache = nil then
  begin
    FfncBuscaChequesCommand_Cache := FConnection.CreateCommand;
    FfncBuscaChequesCommand_Cache.RequestType := 'GET';
    FfncBuscaChequesCommand_Cache.Text := 'TServerMethods1.fncBuscaCheques';
    FfncBuscaChequesCommand_Cache.Prepare(TServerMethods1_fncBuscaCheques_Cache);
  end;
  FfncBuscaChequesCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTFDJSONDataSets.Create(FfncBuscaChequesCommand_Cache.Parameters[0].Value.GetString);
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
  FDataModuleDestroyCommand.DisposeOf;
  FDataModuleCreateCommand.DisposeOf;
  FEchoStringCommand.DisposeOf;
  FReverseStringCommand.DisposeOf;
  FfncTesteServidorCommand.DisposeOf;
  FfncBuscaChequesCommand.DisposeOf;
  FfncBuscaChequesCommand_Cache.DisposeOf;
  inherited;
end;

end.

