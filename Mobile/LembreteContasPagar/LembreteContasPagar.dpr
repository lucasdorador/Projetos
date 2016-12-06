program LembreteContasPagar;

uses
  System.StartUpCopy,
  FMX.Forms,
  uPrincipal in 'uPrincipal.pas' {Fprincipal},
  uContas in 'uContas.pas' {FContas},
  uLogin in 'uLogin.pas' {FLogin},
  uDMPrincipal in 'uDMPrincipal.pas' {DMPrincipal: TDataModule},
  uCadastraUsuario in 'uCadastraUsuario.pas' {FCadastraUsuario},
  uCRUDUsuario in 'Classes\uCRUDUsuario.pas',
  uAtualizacao in 'Classes\uAtualizacao.pas',
  uSplash in 'uSplash.pas' {FSplash};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDMPrincipal, DMPrincipal);
  Application.CreateForm(TFSplash, FSplash);
  Application.CreateForm(TFLogin, FLogin);
  Application.Run;
end.
