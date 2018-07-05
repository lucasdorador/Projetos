unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask;

type
  TFLancamentoOS = class(TForm)
    Label1: TLabel;
    edtOS: TMaskEdit;
    Label2: TLabel;
    edtSprint: TMaskEdit;
    Label3: TLabel;
    edtCliente: TMaskEdit;
    Label4: TLabel;
    edtDataInicial: TMaskEdit;
    Label5: TLabel;
    edtDataFinal: TMaskEdit;
    Label6: TLabel;
    edtHoraInicial: TMaskEdit;
    Label7: TLabel;
    edtHoraProposta: TMaskEdit;
    Label8: TLabel;
    edtHoraFinal: TMaskEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FLancamentoOS: TFLancamentoOS;

implementation

{$R *.dfm}

end.
