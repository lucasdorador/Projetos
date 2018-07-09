unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, System.ImageList,
  Vcl.ImgList, System.Actions, Vcl.ActnList, Vcl.PlatformDefaultStyleActnCtrls,
  Vcl.ActnMan, Vcl.ToolWin, Vcl.ActnCtrls;

type
  TFPrincipal = class(TForm)
    MainMenu1: TMainMenu;
    Lanamentos1: TMenuItem;
    LanamentosDirios1: TMenuItem;
    LanamentosdeOS1: TMenuItem;
    ActionToolBar1: TActionToolBar;
    ActionManager1: TActionManager;
    Lancamento_Diario: TAction;
    ImageList1: TImageList;
    Lancamento_OS: TAction;
    Sair1: TMenuItem;
    Opes1: TMenuItem;
    Backup1: TMenuItem;
    Restaurao1: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
    procedure LanamentosDirios1Click(Sender: TObject);
    procedure LanamentosdeOS1Click(Sender: TObject);
    procedure Lancamento_DiarioExecute(Sender: TObject);
    procedure Lancamento_OSExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FPrincipal: TFPrincipal;

implementation

uses
 uLancamentodiario, uLancamentoOS;

{$R *.dfm}

procedure TFPrincipal.FormShow(Sender: TObject);
begin
Height := Screen.WorkAreaHeight;
Width  := Screen.WorkAreaWidth;
end;

procedure TFPrincipal.LanamentosdeOS1Click(Sender: TObject);
begin
Application.CreateForm(TFLancamentoOS, FLancamentoOS);
FLancamentoOS.ShowModal;
FreeAndNil(FLancamentoOS);
end;

procedure TFPrincipal.LanamentosDirios1Click(Sender: TObject);
begin
Application.CreateForm(TFLancamentodiario, FLancamentodiario);
FLancamentodiario.ShowModal;
FreeAndNil(FLancamentodiario);
end;

procedure TFPrincipal.Lancamento_DiarioExecute(Sender: TObject);
begin
LanamentosDirios1Click(Sender);
end;

procedure TFPrincipal.Lancamento_OSExecute(Sender: TObject);
begin
LanamentosdeOS1Click(Sender);
end;

procedure TFPrincipal.Sair1Click(Sender: TObject);
begin
Close;
end;

end.
