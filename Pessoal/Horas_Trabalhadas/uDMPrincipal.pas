unit uDMPrincipal;

interface

uses
  System.SysUtils, System.Classes, UConexao, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, Vcl.Dialogs, FireDAC.DApt,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Phys.IBBase;

type
  TDMPrincipal = class(TDataModule)
    FDConnection1: TFDConnection;
    FDLancamento_Diario: TFDQuery;
    dsLancamento_Diario: TDataSource;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    FDLancamento_DiarioNUMEROOS: TStringField;
    FDLancamento_DiarioSPRINT: TIntegerField;
    FDLancamento_DiarioDATATRABALHADA: TDateField;
    FDLancamento_DiarioHORADISPONIVEL: TStringField;
    FDLancamento_DiarioHORAPERDIDA: TStringField;
    FDLancamento_DiarioHORATRABALHADA: TStringField;
    FDConsultaClientes: TFDQuery;
    dsConsultaClientes: TDataSource;
    FDConsultaClientesCLIENTE: TStringField;
    FDInsert: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    poConexao : TConexao;
    { Private declarations }
  public
    vgsClienteSelecionado : string;
    { Public declarations }
  end;

var
  DMPrincipal: TDMPrincipal;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDMPrincipal.DataModuleCreate(Sender: TObject);
begin
poConexao := TConexao.Create;
FDConnection1.Connected := False;
FDConnection1 := poConexao.getConnection;

try
FDConnection1.Connected := True;

except
   on E:Exception do
      begin
      ShowMessage('Erro ao abrir a conexão. ' + e.Message);
      Abort;
      end;
   end;


FreeAndNil(poConexao);
end;

procedure TDMPrincipal.DataModuleDestroy(Sender: TObject);
begin
if Assigned(poConexao) then
   FreeAndNil(poConexao);
end;

end.
