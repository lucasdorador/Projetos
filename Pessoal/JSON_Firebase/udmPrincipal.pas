unit udmPrincipal;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, Data.DB,
  FireDAC.Comp.Client, FireDAC.Phys.FB, FireDAC.Phys.FBDef, FMX.Dialogs,
  Winapi.Windows, FMX.Forms, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.FMXUI.Wait,
  FireDAC.Comp.UI;

type
  TdmPrincipal = class(TDataModule)
    FDConnection: TFDConnection;
    FDInsert: TFDQuery;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    procedure DataModuleCreate(Sender: TObject);
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

procedure TdmPrincipal.DataModuleCreate(Sender: TObject);
begin
if NOT FileExists(System.SysUtils.GetCurrentDir + '\CARDAPIO_ONLINE.FDB') then
  begin
  ShowMessage('N�o foi localizado o banco de dados na pasta: '+System.SysUtils.GetCurrentDir+'. A Aplica��o n�o ir� funcionar.');
  Application.Terminate;
  exit;
  end
else
   begin
   FDConnection.Close;
   FDConnection.Open();
   end;

end;

end.
