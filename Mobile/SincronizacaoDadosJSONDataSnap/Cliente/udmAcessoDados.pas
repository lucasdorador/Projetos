unit udmAcessoDados;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.Client, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Stan.StorageJSON, FireDAC.Phys.SQLite, FireDAC.FMXUI.Wait,
  FireDAC.Comp.UI;

type
  TdmAcessoDados = class(TDataModule)
    cnnConexao: TFDConnection;
    driver: TFDPhysSQLiteDriverLink;
    json: TFDStanStorageJSONLink;
    qryProdutos: TFDQuery;
    qryInsercao: TFDQuery;
    memInsercao: TFDMemTable;
    qryProdutosidproduto: TFDAutoIncField;
    qryProdutoscodigo: TStringField;
    qryProdutosnome: TStringField;
    WaitCursor: TFDGUIxWaitCursor;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmAcessoDados: TdmAcessoDados;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure TdmAcessoDados.DataModuleCreate(Sender: TObject);
begin
qryProdutos.Open();
end;

end.
