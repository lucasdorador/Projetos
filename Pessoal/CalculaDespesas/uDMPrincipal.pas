Unit uDMPrincipal;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.Forms, FireDAC.Phys.IBWrapper, FireDAc.Stan.Def, FireDAC.Dapt,
  FireDAC.Phys.FBDef, FireDAC.Phys, FireDAC.Phys.IBBase, FireDAC.Phys.FB,
  FireDAC.Stan.Async, FireDAC.UI.Intf, FireDAC.Stan.Pool, FireDAC.VCLUI.Wait,
  FireDAC.Comp.UI, frxClass, frxExportCSV, frxExportText, frxExportImage,
  frxExportRTF, frxExportHTML, frxExportPDF;

type
  TDMPrincipal = class(TDataModule)
    DSDespesas: TDataSource;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    FDDespesas: TFDQuery;
    FDConnection1: TFDConnection;
    FDDespesasDESP_SEQUENCIA: TIntegerField;
    FDDespesasDESP_ANO: TStringField;
    FDDespesasDESP_DESCRICAO: TStringField;
    FDDespesasDESP_VALOR: TFloatField;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDFaturamento: TFDQuery;
    DSFaturamento: TDataSource;
    FDFaturamentoFAT_ANO: TStringField;
    FDFaturamentoFAT_VALOR: TFloatField;
    frxReport1: TfrxReport;
    frxPDFExport1: TfrxPDFExport;
    frxHTMLExport1: TfrxHTMLExport;
    frxRTFExport1: TfrxRTFExport;
    frxBMPExport1: TfrxBMPExport;
    frxJPEGExport1: TfrxJPEGExport;
    frxTIFFExport1: TfrxTIFFExport;
    frxGIFExport1: TfrxGIFExport;
    frxSimpleTextExport1: TfrxSimpleTextExport;
    frxCSVExport1: TfrxCSVExport;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    poConexao : TFDCOnnection;
    { Public declarations }
  end;

var
  DMPrincipal: TDMPrincipal;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDMPrincipal.DataModuleCreate(Sender: TObject);
begin
poConexao := TFDCOnnection.Create(nil);
if FileExists(ExtractFilePath(Application.ExeName) + 'Despesas.fdb') then
   begin
   poConexao.DriverName := 'FB';
   poConexao.Params.Add('Database='+ExtractFilePath(Application.ExeName) + 'Despesas.fdb');
   poConexao.Params.Add('User_name=SYSDBA');
   poConexao.Params.Add('Password=masterkey');
   poConexao.Params.Add('Protocol=TCPIP');
   poConexao.Params.Add('Server=localhost');
   poConexao.Params.Add('SQLDialect=3');
   poConexao.Params.Add('CharacterSet=WIN1252');

   try
   poConexao.Open;
   except
      on e : EIBNativeException  do
         begin
         Application.MessageBox(PChar('Não foi possível efetuar a conexão. Erro: ' + e.Message), 'Despesas', 0);
           poConexao := nil;
         end;
      end;

   end
else
   begin
   Application.MessageBox(PChar('Não foi possível localizar o arquivo Despesas.fdb na pasta: '+ExtractFilePath(Application.ExeName)), 'Despesas', 0);
   poConexao := nil;
   end;
end;

procedure TDMPrincipal.DataModuleDestroy(Sender: TObject);
begin
if Assigned(poConexao) then
   begin
   poConexao := nil;
   FreeAndNil(poConexao);
   end;
end;

end.
