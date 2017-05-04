unit uProcessa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Samples.Gauges, Vcl.StdCtrls;

type
  TFProcessa = class(TForm)
    GroupBox1: TGroupBox;
    Gauge1: TGauge;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FProcessa: TFProcessa;

implementation

{$R *.dfm}

end.
