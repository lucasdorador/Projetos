unit uDMServer;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.UI.Intf, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.UI, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FBDef,
  FireDAC.Phys.IBBase, FireDAC.Phys.FB, FireDAc.Dapt;

type
  TDMServer = class(TDataModule)
    FDInformacoes: TFDMemTable;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    DSInformacoes: TDataSource;
    FDInformacoesInformacao: TStringField;
    FDInformacoesValor: TStringField;
    FDConexao: TFDConnection;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    procedure DataModuleCreate(Sender: TObject);
  private
    function ConectaBancoDados(psCaminhoBD: String): TFDConnection;
    procedure pcdCriaParametrosConexaoFireDAc(var poConnection: TFDConnection;
      psCaminhoBD: String);
    function LerConfigIni: String;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMServer: TDMServer;

implementation

uses
  Vcl.Dialogs, FireDAC.Phys.IBWrapper, System.IniFiles, Vcl.Forms;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDMServer.DataModuleCreate(Sender: TObject);
begin
if Trim(LerConfigIni) <> '' then
   FDConexao := ConectaBancoDados(LerConfigIni);
end;

function TDMServer.ConectaBancoDados(psCaminhoBD: String): TFDConnection;
var
   FConexao : TFDConnection;
begin
// Conexão com o FIREBIRD COMÉRCIO - FireDac
FConexao    := TFDConnection.Create(nil);
//vgsDataBase := Copy(vgsDataBase, Length(vgsServer) + 2, Length(vgsDataBase));
pcdCriaParametrosConexaoFireDAc(FConexao, psCaminhoBD);
try
   FConexao.Open;
except
   on e : EIBNativeException  do
      begin
      ShowMessage('Não foi possível efetuar a conexão. Erro: ' + e.Message);
        FConexao := nil;
      end;
   end;
Result := FConexao;
end;

procedure TDMServer.pcdCriaParametrosConexaoFireDAc(var poConnection: TFDConnection; psCaminhoBD: String);
begin
poConnection.DriverName := 'FB';
poConnection.Params.Add('Database='+psCaminhoBD);
poConnection.Params.Add('User_name=SYSDBA');
poConnection.Params.Add('Password=masterkey');
poConnection.Params.Add('Protocol=TCPIP');
poConnection.Params.Add('Server=localhost');
poConnection.Params.Add('SQLDialect=3');
poConnection.Params.Add('CharacterSet=WIN1252');
end;

function TDMServer.LerConfigIni: String;
var
  ArqIni: TIniFile;
begin
ArqIni := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'ConfigServer.ini');
try
Result := ArqIni.ReadString('Config', 'CaminhoBD', '');
finally
   ArqIni.Free;
   end;
end;

end.
