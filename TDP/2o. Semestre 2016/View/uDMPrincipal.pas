unit uDMPrincipal;

interface

uses
  System.SysUtils, System.Classes, frxClass;

type
  TDMPrincipal = class(TDataModule)
    frxReport1: TfrxReport;
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
