unit UDMPrincipal;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.FMXUI.Wait,
  FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteDef, FireDAC.Phys.SQLite,
  FireDAC.Comp.UI, Data.DB, FireDAC.Comp.Client;

type
  TDMPrincipal = class(TDataModule)
    FDConnection1: TFDConnection;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    procedure FDConnection1BeforeConnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMPrincipal: TDMPrincipal;

implementation

uses System.IOUtils;

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure TDMPrincipal.FDConnection1BeforeConnect(Sender: TObject);
begin
FDConnection1.Params.Values['Database'] := TPath.GetDocumentsPath + PathDelim + 'Alc_Gas.db';
end;

end.
