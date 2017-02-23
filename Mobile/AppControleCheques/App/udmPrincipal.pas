unit udmPrincipal;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.FMXUI.Wait, FireDAC.Comp.UI;

type
  TdmPrincipal = class(TDataModule)
    Conexao: TFDConnection;
    FDConsulta: TFDQuery;
    FDConsultaCH_CODIGO: TFDAutoIncField;
    FDConsultaCH_BANCO: TStringField;
    FDConsultaCH_CONTACORRENTE: TStringField;
    FDConsultaCH_NUMEROCHEQUE: TStringField;
    FDConsultaCH_VALOR: TFloatField;
    FDConsultaCH_DATALANCAMENTO: TDateField;
    FDConsultaCH_DATACOMPENSACAO: TDateField;
    FDConsultaCH_FORNECEDOR: TStringField;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDMCheques: TFDMemTable;
    FDMChequesCH_CODIGO: TFDAutoIncField;
    FDMChequesCH_BANCO: TStringField;
    FDMChequesCH_CONTACORRENTE: TStringField;
    FDMChequesCH_NUMEROCHEQUE: TStringField;
    FDMChequesCH_VALOR: TFloatField;
    FDMChequesCH_DATALANCAMENTO: TDateField;
    FDMChequesCH_DATACOMPENSACAO: TDateField;
    FDMChequesCH_FORNECEDOR: TStringField;
    procedure ConexaoBeforeConnect(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
    procedure FDConsultaAfterPost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmPrincipal: TdmPrincipal;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

uses System.IOUtils;

procedure TdmPrincipal.ConexaoBeforeConnect(Sender: TObject);
var
   vlsCaminhoBanco : String;
begin
Conexao.LoginPrompt := False;
Conexao.Params.Values['DriverID'] := 'SQLite';
//Conectando no android
{$IF DEFINED (ANDROID)}
   vlsCaminhoBanco := TPath.GetDocumentsPath + PathDelim + 'ControleCheques.sdb';
   Conexao.Params.Values['Database'] := vlsCaminhoBanco;
{$ENDIF}
//Conectando no Windows
{$IF DEFINED (MSWINDOWS)}
   vlsCaminhoBanco := 'F:\Projetos\trunk\Mobile\AppControleCheques\Banco_de_Dados\ControleCheques.sdb';
   Conexao.Params.Values['Database'] := vlsCaminhoBanco;
{$ENDIF}
end;

procedure TdmPrincipal.DataModuleCreate(Sender: TObject);
begin
Conexao.Connected := True;
end;

procedure TdmPrincipal.FDConsultaAfterPost(DataSet: TDataSet);
begin
if FDConsulta.ApplyUpdates > 0 then;
   FDConsulta.CancelUpdates;
end;

end.
