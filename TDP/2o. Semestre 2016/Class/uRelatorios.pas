unit uRelatorios;

interface

uses
   FireDAC.Comp.Client, SysUtils, Vcl.Forms, Windows, Vcl.Controls, Data.DB,
   System.Classes, Vcl.CheckLst, UFuncoesFaciliteXE8, uConstantes, uVariaveisRelatorio;

type TRelatorios = class
   public
      class procedure pcdGeraDadosImprimirImposto(poVariaveis : TVariaveisRelatorioImposto; var poFDMemTable : TFDMemTable);

end;

implementation

class procedure TRelatorios.pcdGeraDadosImprimirImposto(poVariaveis : TVariaveisRelatorioImposto; var poFDMemTable : TFDMemTable);
begin
if not poFDMemTable.Active then
   poFDMemTable.Active := True;

poFDMemTable.Append;
poFDMemTable.FieldByName('PeriodoApuracao').AsString := poVariaveis.vgsPeriodoApuracao;
poFDMemTable.FieldByName('CPFCNPJ').AsString         := poVariaveis.vgsCPFCNPJ;
poFDMemTable.FieldByName('CodigoBarras').AsString    := poVariaveis.vgsCodigoBarra;
poFDMemTable.FieldByName('Referencia').AsString      := poVariaveis.vgsReferencia;
poFDMemTable.FieldByName('Vencimento').AsString      := poVariaveis.vgsVencimento;
poFDMemTable.FieldByName('NomeImposto').AsString     := poVariaveis.vgsNomeImposto;
poFDMemTable.FieldByName('CodReceita').AsString      := poVariaveis.vgsCodReceita;
poFDMemTable.FieldByName('NomeRazao').AsString       := poVariaveis.vgsNome;
poFDMemTable.FieldByName('ValorPrincipal').AsFloat   := poVariaveis.vgdValorPrincipal;
poFDMemTable.FieldByName('Multa').AsFloat            := poVariaveis.vgdMulta;
poFDMemTable.FieldByName('Juros').AsFloat            := poVariaveis.vgdJuros;
poFDMemTable.FieldByName('Total').AsFloat            := poVariaveis.vgdTotal;
poFDMemTable.Post;
end;

end.
