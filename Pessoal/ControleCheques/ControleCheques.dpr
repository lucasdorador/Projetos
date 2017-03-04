program ControleCheques;

uses
  Vcl.Forms,
  uControleCheques in 'uControleCheques.pas' {FControleCheques},
  uTabelas in 'Class\uTabelas.pas',
  uFuncoes in 'Class\uFuncoes.pas',
  uVariaveis in 'Class\uVariaveis.pas',
  udmPrincipal in 'udmPrincipal.pas' {DMPrincipal: TDataModule},
  uConsultas in 'uConsultas.pas' {FConsultas},
  uPrincipal in 'uPrincipal.pas' {FPrincipal},
  uCadastros in 'uCadastros.pas' {FCadastros};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDMPrincipal, DMPrincipal);
  Application.CreateForm(TFPrincipal, FPrincipal);
  Application.CreateForm(TFCadastros, FCadastros);
  Application.Run;
end.
