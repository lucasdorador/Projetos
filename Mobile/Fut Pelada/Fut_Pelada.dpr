program Fut_Pelada;

uses
  System.StartUpCopy,
  FMX.Forms,
  UPrincipal in 'UPrincipal.pas' {FPrincipal},
  UCadastroTreino in 'UCadastroTreino.pas' {FCadastroTreino};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFPrincipal, FPrincipal);
  Application.CreateForm(TFCadastroTreino, FCadastroTreino);
  Application.Run;
end.
