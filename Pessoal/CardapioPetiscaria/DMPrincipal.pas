unit DMPrincipal;

interface

uses
  System.SysUtils, System.Classes, FireDAC.UI.Intf, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, Data.DB, FireDAC.Comp.Client,
  FireDAC.Comp.UI, FireDAc.Dapt, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, frxExportImage, frxClass,
  frxExportPDF, frxDBSet;

type
  TDMPrinc = class(TDataModule)
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDConnection1: TFDConnection;
    FDCons_Grupos: TFDQuery;
    DSCons_Grupos: TDataSource;
    FDCons_GruposGRUPO_CODIGO: TIntegerField;
    FDCons_GruposGRUPO_DESCRICAO: TStringField;
    FDCons_Produto: TFDQuery;
    DSCons_Produto: TDataSource;
    FDCons_ProdutoPRO_CODIGO: TIntegerField;
    FDCons_ProdutoPRO_GRUPO: TIntegerField;
    FDCons_ProdutoPRO_DESCRICAO: TStringField;
    FDCons_ProdutoPRO_VALORMEIA: TFloatField;
    FDCons_ProdutoPRO_VALORINTEIRA: TFloatField;
    frxReport1: TfrxReport;
    frxDBDataset1: TfrxDBDataset;
    FDRel_Cardapio: TFDQuery;
    FDRel_CardapioGRUPO_DESCRICAO: TStringField;
    FDRel_CardapioPRO_DESCRICAO: TStringField;
    FDRel_CardapioPRO_VALORINTEIRA: TFloatField;
    FDRel_CardapioPRO_VALORMEIA: TFloatField;
    frxPDFExport1: TfrxPDFExport;
    frxJPEGExport1: TfrxJPEGExport;
    frxBMPExport1: TfrxBMPExport;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMPrinc: TDMPrinc;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
