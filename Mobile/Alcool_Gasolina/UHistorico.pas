unit UHistorico;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FMX.ListView.Types, System.Rtti,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope, FMX.ListView,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFHistorico = class(TForm)
    FDHistorico: TFDQuery;
    ListView1: TListView;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkFillControlToField1: TLinkFillControlToField;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FHistorico: TFHistorico;

implementation

{$R *.fmx}

uses UDMPrincipal;

procedure TFHistorico.FormShow(Sender: TObject);
begin
FDHistorico.Close;
FDHistorico.Connection := DMPrincipal.FDConnection1;
FDHistorico.Open();
end;

end.
