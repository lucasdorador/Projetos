unit ServerMethodsUnit1;

interface

uses System.SysUtils, System.Classes, System.Json,
     Datasnap.DSServer, Datasnap.DSAuth, DataSnap.DSProviderDataModuleAdapter,
     FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
     FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
     FireDAC.Phys, Data.DB, FireDAC.Comp.Client, Forms, Data.FireDACJSONReflect,
  FireDAC.Phys.FBDef, FireDAC.Phys.IBBase, FireDAC.Phys.FB;

type
{$METHODINFO ON}
  TServerMethods1 = class(TDataModule)
    Conexao: TFDConnection;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
     vloFDMemTemp1 : TFDMemTable;
    { Private declarations }
  public
    { Public declarations }
    function EchoString(Value: string): string;
    function ReverseString(Value: string): string;
    function fncTesteServidor : String;
    function fncBuscaCheques : TFDJSONDataSets;
  end;
{$METHODINFO OFF}

implementation


{$R *.dfm}


uses System.StrUtils, UManipulacaoINI, uClassBancoDados;

procedure TServerMethods1.DataModuleCreate(Sender: TObject);
var
   vlINi : TManipulacaoINI;
begin
try
vlINi := TManipulacaoINI.Create(ExtractFilePath(Application.ExeName) + 'dbxconnections.ini', 'DFSISTEMAS');
try
Conexao.Close;
vlINi.Conectar(Conexao);
Conexao.Connected := True;

finally
   FreeAndNil(vlINi);
   end;

vloFDMemTemp1 := TFDMemTable.Create(nil);

except
   on e : exception do
      begin
      raise Exception.Create(e.Message);
      end;
   end;
end;

procedure TServerMethods1.DataModuleDestroy(Sender: TObject);
begin
Conexao.Close;
FreeAndNil(Conexao);
FreeAndNil(vloFDMemTemp1);
end;

function TServerMethods1.EchoString(Value: string): string;
begin
  Result := Value;
end;

function TServerMethods1.fncBuscaCheques: TFDJSONDataSets;
var
   vlDados        : TCamadaBancoDados;
   vlQueryCheques : TFDQuery;
begin
vlDados := TCamadaBancoDados.Create(Conexao);
//vlDados.Conexao := FDConexao;
try
vlQueryCheques     := vlDados.fncBuscaTodosCheques;
vloFDMemTemp1.Data := vlQueryCheques.Data;

Result := TFDJSONDataSets.Create;

TFDJSONDataSetsWriter.ListAdd(Result, vloFDMemTemp1);

finally
   if Assigned(vlQueryCheques) then
      FreeAndNil(vlQueryCheques);
   if Assigned(vlDados) then
      FreeAndNil(vlDados);
   end;
end;

function TServerMethods1.fncTesteServidor: String;
begin
Result := 'OK';
end;

function TServerMethods1.ReverseString(Value: string): string;
begin
  Result := System.StrUtils.ReverseString(Value);
end;

end.

