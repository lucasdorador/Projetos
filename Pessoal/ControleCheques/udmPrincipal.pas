unit udmPrincipal;

interface

uses
  System.SysUtils, System.Classes, FireDAC.UI.Intf, FireDAC.VCLUI.Wait,
  FireDAC.Phys.FBDef, FireDAC.Phys, FireDAC.Phys.IBBase, FireDAC.Phys.FB,
  IBX.IBScript, FireDAC.Stan.Intf, FireDAC.Comp.UI;

type
  TDMPrincipal = class(TDataModule)
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FBScript: TIBScript;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMPrincipal: TDMPrincipal;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
