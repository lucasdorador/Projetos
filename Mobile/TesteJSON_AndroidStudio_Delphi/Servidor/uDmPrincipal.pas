unit uDmPrincipal;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.VCLUI.Wait, FireDAC.Comp.UI, UConexaoXE8;

type
  TDMPrincipal = class(TDataModule)
    FDQuery1: TFDQuery;
    FDTable1: TFDTable;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDQuery2: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    vgoConexao : TConexaoXE8;
    vloConexao : TFDConnection;
  public
    { Public declarations }
  end;

var
  DMPrincipal: TDMPrincipal;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDMPrincipal.DataModuleCreate(Sender: TObject);
begin
vgoConexao := TConexaoXE8.Create;
vloConexao := vgoConexao.getConnection;

FDQuery1.Connection := vloConexao;
FDQuery2.Connection := vloConexao;
end;

end.
