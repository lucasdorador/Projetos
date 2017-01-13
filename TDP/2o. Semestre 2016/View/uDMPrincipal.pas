unit uDMPrincipal;

interface

uses
  System.SysUtils, System.Classes, frxClass, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, frxDBSet, frxBarcode;

type
  TDMPrincipal = class(TDataModule)
    frxReport1: TfrxReport;
    FDDARF: TFDMemTable;
    FDDARFPeriodoApuracao: TStringField;
    FDDARFCPFCNPJ: TStringField;
    FDDARFReferencia: TStringField;
    FDDARFVencimento: TStringField;
    FDDARFNomeImposto: TStringField;
    FDDARFCodReceita: TStringField;
    FDDARFNomeRazao: TStringField;
    FDDARFValorPrincipal: TFloatField;
    FDDARFMulta: TFloatField;
    FDDARFJuros: TFloatField;
    FDDARFTotal: TFloatField;
    frxDBDARF: TfrxDBDataset;
    FDDARFCodigoBarras: TStringField;
    frxBarCodeObject1: TfrxBarCodeObject;
    procedure frxReport1GetValue(const VarName: string; var Value: Variant);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMPrincipal: TDMPrincipal;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses uImpostos;

{$R *.dfm}

procedure TDMPrincipal.frxReport1GetValue(const VarName: string;
  var Value: Variant);
begin
//if VarName = 'vmPeriodoApuracao' then
//   Value := FImpostos.vgsPeriodoApuracao
//else if VarName = 'vmCPFCNPJ' then
//   Value := FImpostos.vgsCPFCNPJ
//else if VarName = 'vmReferencia' then
//   Value := FImpostos.vgsReferencia
//else if VarName = 'vmVencimento' then
//   Value := FImpostos.vgsVencimento
//else if VarName = 'vmNomeImposto' then
//   Value := FImpostos.vgsNomeImposto
//else if VarName = 'vmCodReceita' then
//   Value := FImpostos.vgsCodReceita
//else if VarName = 'vmNome' then
//   Value := FImpostos.vgsNome
//else if VarName = 'vmValorPrincipal' then
//   Value := FImpostos.vgdValorPrincipal
//else if VarName = 'vmMulta' then
//   Value := FImpostos.vgdMulta
//else if VarName = 'vmJuros' then
//   Value := FImpostos.vgdJuros
//else if VarName = 'vmTotal' then
//   Value := FImpostos.vgdTotal
//else
//   Value := '';
end;

end.
