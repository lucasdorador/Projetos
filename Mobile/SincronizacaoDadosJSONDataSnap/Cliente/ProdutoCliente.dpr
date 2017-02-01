program ProdutoCliente;

uses
  System.StartUpCopy,
  FMX.Forms,
  uPrincipal in 'uPrincipal.pas' {FPrincipal},
  udmAcessoDados in 'udmAcessoDados.pas' {dmAcessoDados: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFPrincipal, FPrincipal);
  Application.CreateForm(TdmAcessoDados, dmAcessoDados);
  Application.Run;
end.
