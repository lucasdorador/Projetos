unit uVariaveis;

interface

uses
   FireDAc.Comp.Client;

type
   TTipoTabelaCadastro = (tt_Banco, tt_Conta);

var
   vgCaminhoBanco, vgUsuarioBanco, vgSenhaBanco : String;
   vgConexao : TFDConnection;

implementation

end.
