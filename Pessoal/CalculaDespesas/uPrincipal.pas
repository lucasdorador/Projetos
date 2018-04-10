unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, System.Actions, Vcl.ActnList,
  Vcl.PlatformDefaultStyleActnCtrls, Vcl.ActnMan, Vcl.ToolWin, Vcl.ActnCtrls,
  System.ImageList, Vcl.ImgList;

type
  TFprincipal = class(TForm)
    MainMenu1: TMainMenu;
    Lanamentos1: TMenuItem;
    Apuraa1: TMenuItem;
    FecharApuracao1: TMenuItem;
    Despesas1: TMenuItem;
    Faturamento1: TMenuItem;
    Sair1: TMenuItem;
    ActionToolBar1: TActionToolBar;
    ActionManager1: TActionManager;
    act_Despesas: TAction;
    act_Faturamento: TAction;
    act_ApuraAnual: TAction;
    act_Sair: TAction;
    ApuraesFinalizadas1: TMenuItem;
    act_ApurFechadas: TAction;
    ImageList1: TImageList;
    procedure Despesas1Click(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
    procedure Faturamento1Click(Sender: TObject);
    procedure act_DespesasExecute(Sender: TObject);
    procedure act_FaturamentoExecute(Sender: TObject);
    procedure act_SairExecute(Sender: TObject);
    procedure FecharApuracao1Click(Sender: TObject);
    procedure ApuraesFinalizadas1Click(Sender: TObject);
    procedure act_ApuraAnualExecute(Sender: TObject);
    procedure act_ApurFechadasExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
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

uses uCalculaDespesa, uFaturamento, uApuracao;

procedure TFprincipal.act_ApuraAnualExecute(Sender: TObject);
begin
FecharApuracao1.Click;
end;

procedure TFprincipal.act_ApurFechadasExecute(Sender: TObject);
begin
ApuraesFinalizadas1.Click;
end;

procedure TFprincipal.act_DespesasExecute(Sender: TObject);
begin
Despesas1.Click;
end;

procedure TFprincipal.act_FaturamentoExecute(Sender: TObject);
begin
Faturamento1.Click;
end;

procedure TFprincipal.act_SairExecute(Sender: TObject);
begin
Sair1.Click;
end;

procedure TFprincipal.ApuraesFinalizadas1Click(Sender: TObject);
begin
Application.CreateForm(TFApuracao, FApuracao);
FApuracao.vPaleta := 'Fechadas';
FApuracao.ShowModal;
FreeAndNil(FApuracao);
end;

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

procedure TFprincipal.FecharApuracao1Click(Sender: TObject);
begin
Application.CreateForm(TFApuracao, FApuracao);
FApuracao.vPaleta := 'Apuração';
FApuracao.ShowModal;
FreeAndNil(FApuracao);
end;

procedure TFprincipal.FormShow(Sender: TObject);
begin
Height := Screen.WorkAreaHeight;
Width  := Screen.WorkAreaWidth;
end;

procedure TFprincipal.pcdMensagem(psMensagem: String);
begin
Application.MessageBox(PChar(psMensagem), 'Despesas', 0);
end;

end.
