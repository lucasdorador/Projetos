unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, System.Actions, Vcl.ActnList;

type
  TFprincipal = class(TForm)
    MainMenu1: TMainMenu;
    Lanamentos1: TMenuItem;
    Apuraa1: TMenuItem;
    LanarApuraes1: TMenuItem;
    Despesas1: TMenuItem;
    Faturamento1: TMenuItem;
    Sair1: TMenuItem;
    ActionList1: TActionList;
    procedure Despesas1Click(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
    procedure Faturamento1Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure pcdMensagem(psMensagem: String);
    { Public declarations }
  end;

var
  Fprincipal: TFprincipal;

implementation

{$R *.dfm}

uses uCalculaDespesa, uFaturamento;

procedure TFprincipal.Despesas1Click(Sender: TObject);
begin
Application.CreateForm(TFCalculaDespesa, FCalculaDespesa);
FCalculaDespesa.ShowModal;
FreeAndNil(FCalculaDespesa);
end;

procedure TFprincipal.Sair1Click(Sender: TObject);
begin
Close;
end;

procedure TFprincipal.Faturamento1Click(Sender: TObject);
begin
Application.CreateForm(TFFaturamento, FFaturamento);
FFaturamento.ShowModal;
FreeAndNil(FFaturamento);
end;

procedure TFprincipal.pcdMensagem(psMensagem: String);
begin
Application.MessageBox(PChar(psMensagem), 'Despesas', 0);
end;

end.
