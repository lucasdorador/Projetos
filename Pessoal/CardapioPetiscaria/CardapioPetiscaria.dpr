program CardapioPetiscaria;

uses
  Vcl.Forms,
  uCadastroCardapio in 'uCadastroCardapio.pas' {FCadastroCardapio},
  uCardapio in 'uCardapio.pas',
  uGrupos in 'uGrupos.pas',
  uDAOCardapio in 'uDAOCardapio.pas',
  DMPrincipal in 'DMPrincipal.pas' {DMPrinc: TDataModule},
  uCons_Grupos in 'uCons_Grupos.pas' {FCons_Grupos},
  uDAOGrupo in 'uDAOGrupo.pas',
  uCons_Produtos in 'uCons_Produtos.pas' {FCons_Produtos};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFCadastroCardapio, FCadastroCardapio);
  Application.CreateForm(TDMPrinc, DMPrinc);
  Application.CreateForm(TFCons_Grupos, FCons_Grupos);
  Application.CreateForm(TFCons_Grupos, FCons_Grupos);
  Application.CreateForm(TFCons_Produtos, FCons_Produtos);
  Application.Run;
end.
