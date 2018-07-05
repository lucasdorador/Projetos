program AppEstoque;

uses
  System.StartUpCopy,
  FMX.Forms,
  uPrincipal in 'uPrincipal.pas' {Fprincipal},
  uProduto in '..\ServidorEstoqueISAPI\Lib\uProduto.pas',
  uCadProduto in 'Lib\uCadProduto.pas',
  uDMPrincipal in 'uDMPrincipal.pas' {DMPrincipal: TDataModule},
  uCompras in 'Lib\uCompras.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFprincipal, Fprincipal);
  Application.CreateForm(TDMPrincipal, DMPrincipal);
  Application.Run;
end.
