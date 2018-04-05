unit uDMPrincipal;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TDMPrincipal = class(TDataModule)
    FDMemPrincipal: TFDMemTable;
    FDMemPrincipalAno: TStringField;
    FDMemPrincipalDespesa: TStringField;
    FDMemPrincipalValor: TFloatField;
    DSPrincipal: TDataSource;
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
