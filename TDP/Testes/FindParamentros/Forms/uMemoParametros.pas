unit uMemoParametros;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons;

type
  TFMemoParametros = class(TForm)
    Panel1: TPanel;
    btnSair: TBitBtn;
    procedure btnSairClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMemoParametros: TFMemoParametros;

implementation

{$R *.dfm}

procedure TFMemoParametros.btnSairClick(Sender: TObject);
begin
Close;
end;

end.
