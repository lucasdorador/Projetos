unit UPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.Controls.Presentation, FMX.Edit, FMX.StdCtrls, FireDac.Comp.Client,
  FireDac.DApt, FMX.EditBox, FMX.NumberBox;

type
  TFprincipal = class(TForm)
    L_Principal: TLayout;
    Image1: TImage;
    Rectangle1: TRectangle;
    GridPanelLayout1: TGridPanelLayout;
    GridPanelLayout2: TGridPanelLayout;
    Image2: TImage;
    Image4: TImage;
    Rectangle2: TRectangle;
    Rectangle3: TRectangle;
    Button1: TButton;
    Layout1: TLayout;
    Button2: TButton;
    edtAlcool: TNumberBox;
    edtGasolina: TNumberBox;
    Label1: TLabel;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fprincipal: TFprincipal;

implementation

uses UDMPrincipal, UHistorico;

procedure TFprincipal.Button1Click(Sender: TObject);
var
   FDHistorico : TFDQuery;
   vlsResultado : String;
   vldAlcool, vldGasolina, vldResultado : Double;
begin
FDHistorico := TFDQuery.Create(nil);
vlsResultado := '';
vldAlcool    := 0;
vldGasolina  := 0;
vldResultado := 0;
try
vldAlcool   := edtAlcool.Value;
vldGasolina := edtGasolina.Value;

vldResultado := vldAlcool / vldGasolina;

if vldResultado < 0.70 then
   vlsResultado := 'Álcool'
else
   vlsResultado := 'Gasolina';

FDHistorico.Close;
FDHistorico.Connection := DMPrincipal.FDConnection1;
FDHistorico.SQL.Clear;
FDHistorico.SQL.Add('INSERT INTO HISTORICO (HIST_DATA, HIST_ALCOOL, HIST_GASOLINA, HIST_RESULTADO) VALUES ');
FDHistorico.SQL.Add('(:HIST_DATA, :HIST_ALCOOL, :HIST_GASOLINA, :HIST_RESULTADO)');
FDHistorico.ParamByName('HIST_DATA').AsString      := FormatDateTime('dd/mm/yyyy', Date);
FDHistorico.ParamByName('HIST_ALCOOL').AsFloat     := StrToFloat(FormatFloat('0.000', edtAlcool.Value));
FDHistorico.ParamByName('HIST_GASOLINA').AsFloat   := StrToFloat(FormatFloat('0.000', edtGasolina.Value));
FDHistorico.ParamByName('HIST_RESULTADO').AsString := vlsResultado;
FDHistorico.ExecSQL;

ShowMessage('Esta mais vantajoso abastecer com: ' + vlsResultado);
finally
   FreeAndNil(FDHistorico);
   end;
end;

procedure TFprincipal.Button2Click(Sender: TObject);
var
   vloHistorico : TFHistorico;
begin
vloHistorico := TFHistorico.Create(nil);
try
vloHistorico.ShowModal;
finally
   FreeAndNil(vloHistorico);
   end;
end;

end.
