unit uVariaveisRelatorio;

interface

type TVariaveisRelatorioImposto = Record
     vgsPeriodoApuracao : String;
     vgsCPFCNPJ         : String;
     vgsReferencia      : String;
     vgsVencimento      : String;
     vgsNomeImposto     : String;
     vgsCodReceita      : String;
     vgsNome            : String;
     vgsCodigoBarra     : String;
     vgdValorPrincipal  : Double;
     vgdMulta           : Double;
     vgdJuros           : Double;
     vgdTotal           : Double;
   End;

implementation

end.
