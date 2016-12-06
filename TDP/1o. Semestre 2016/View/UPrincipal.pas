unit UPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus;

type
  TFprincipal = class(TForm)
    MainMenu1: TMainMenu;
    Script1: TMenuItem;
    Executar1: TMenuItem;
    Gerar1: TMenuItem;
    procedure Executar1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fprincipal: TFprincipal;

implementation

{$R *.dfm}

uses ULeScript;

procedure TFprincipal.Executar1Click(Sender: TObject);
begin
Application.CreateForm(TFLeScript, FLeScript);
FLeScript.ShowModal;
FreeAndNil(FLeScript);
end;

end.
