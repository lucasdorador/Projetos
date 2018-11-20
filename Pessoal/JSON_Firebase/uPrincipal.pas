unit uPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit, FMX.EditBox, FMX.NumberBox;

type
  TFPrincipal = class(TForm)
    gbCampos: TGroupBox;
    key_empresa: TEdit;
    Label1: TLabel;
    key_produto: TEdit;
    Label2: TLabel;
    descricao: TEdit;
    Label3: TLabel;
    complemento: TEdit;
    Label4: TLabel;
    grupo: TEdit;
    Label5: TLabel;
    valor_meia: TNumberBox;
    Label6: TLabel;
    valor_inteira: TNumberBox;
    Label7: TLabel;
    btnGravar: TButton;
    btnSair: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FPrincipal: TFPrincipal;

implementation

{$R *.fmx}

end.
