unit uImpressao;

interface

uses
  FireDAC.Comp.Client, System.SysUtils, frxClass, Vcl.Forms, uGeraApuracao,
  Vcl.Graphics;

type

 TImpressao = class(Tobject)
   private
    vloGeraApuracao : TGeraApuracao;
    FConexao    : TFDConnection;
    FQuery      : TFDQuery;
    pofrxReport : TfrxReport;
    frxMemoAnoBase, frxMemoAnoCalendario, frxMemoReceitaBruta,
    frxMemoDespesas, frxMemoLucroEvidenciado, frxMemoPorcentagemIsenta,
    frxMemoValorIsento, frxMemoValorTributado, frxMemoValorTributadoIR,
    frxMemoNecessidade, frxPorcIsenta, frxDeclaracaoTributado,
    frxDeclaracaoIsento : TfrxMemoView;
    frxChild : TfrxChild;
    FImp_Ano: String;
    procedure VinculaComponentes;
    procedure SetImp_Ano(const Value: String);

   public
    constructor Create(poConexao : TFDConnection);
    destructor Destroy; override;
    procedure pcdImpressaoApuracao;
   published
    property Imp_Ano: String read FImp_Ano write SetImp_Ano;

 end;

implementation

{ TImpressao }

constructor TImpressao.Create(poConexao: TFDConnection);
begin
FConexao := poConexao;

FQuery   := TFDQuery.Create(nil);
FQuery.Connection := FConexao;
FQuery.Close;

pofrxReport     := TfrxReport.Create(nil);
vloGeraApuracao := TGeraApuracao.Create(FConexao);
end;

destructor TImpressao.Destroy;
begin
if Assigned(FQuery) then
   FreeAndNil(FQuery);

if Assigned(pofrxReport) then
   FreeAndNil(pofrxReport);

if Assigned(vloGeraApuracao) then
   FreeAndNil(vloGeraApuracao);

inherited;
end;

procedure TImpressao.pcdImpressaoApuracao;
begin
if FileExists(ExtractFilePath(Application.ExeName) + 'Relatorios\rel_Apuracao.fr3') then
   begin
   pofrxReport.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Relatorios\rel_Apuracao.fr3');
   VinculaComponentes;
   vloGeraApuracao.pcdRetornaValoresApuracaoANO(FImp_Ano);
   frxMemoAnoBase.Memo.Add(vloGeraApuracao.poRetornoApuracao.vlsAPUR_ANO);
   frxMemoAnoCalendario.Memo.Add(FormatFloat('0000', StrToInt(vloGeraApuracao.poRetornoApuracao.vlsAPUR_ANO) + 1));
   frxMemoReceitaBruta.Memo.Add(FormatFloat(',0.00', vloGeraApuracao.poRetornoApuracao.vldAPUR_RECEITABRUTA));
   frxMemoDespesas.Memo.Add(FormatFloat(',0.00', vloGeraApuracao.poRetornoApuracao.vldAPUR_DESPESAS));
   frxMemoLucroEvidenciado.Memo.Add(FormatFloat(',0.00', vloGeraApuracao.poRetornoApuracao.vldAPUR_LUCROEVIDENCIADO));
   frxMemoPorcentagemIsenta.Memo.Add(FormatFloat(',0.00', vloGeraApuracao.poRetornoApuracao.vldAPUR_PORCENTAGEMISENTA));
   frxMemoValorIsento.Memo.Add(FormatFloat(',0.00', vloGeraApuracao.poRetornoApuracao.vldAPUR_VALORISENTO));
   frxMemoValorTributado.Memo.Add(FormatFloat(',0.00', vloGeraApuracao.poRetornoApuracao.vldAPUR_VALORTRIBUTADO));
   frxMemoValorTributadoIR.Memo.Add(FormatFloat(',0.00', vloGeraApuracao.poRetornoApuracao.vldAPUR_VALORDECLARARIR));

   if vloGeraApuracao.poRetornoApuracao.vldAPUR_PORCENTAGEMISENTA = 8 then
      frxPorcIsenta.Memo.Add('Porcentagem Isenta (Comércio, Indústria e Transporte de Carga) (%):')
   else if vloGeraApuracao.poRetornoApuracao.vldAPUR_PORCENTAGEMISENTA = 16 then
      frxPorcIsenta.Memo.Add('Porcentagem Isenta (Transporte de Passageiros) (%):')
   else if vloGeraApuracao.poRetornoApuracao.vldAPUR_PORCENTAGEMISENTA = 32 then
      frxPorcIsenta.Memo.Add('Porcentagem Isenta (Serviços Gerais) (%):')
   else
      frxPorcIsenta.Memo.Add('Porcentagem Isenta (%):');

   if Trim(vloGeraApuracao.poRetornoApuracao.vlsAPUR_DECLARA) = 'True' then
      begin
      frxMemoNecessidade.Memo.Add('Há necessidade de declaração de Imposto de Renda');
      frxMemoNecessidade.Font.Color := clRed;
      frxChild.Visible              := True;

      frxDeclaracaoTributado.Memo.Add(FormatFloat(',0.00', vloGeraApuracao.poRetornoApuracao.vldAPUR_VALORTRIBUTADO));
      frxDeclaracaoIsento.Memo.Add(FormatFloat(',0.00', vloGeraApuracao.poRetornoApuracao.vldAPUR_VALORISENTO));
      end
   else
      begin
      frxMemoNecessidade.Memo.Add('Não há necessidade de declaração de Imposto de Renda');
      frxMemoNecessidade.Font.Color := clBlack;
      frxChild.Visible              := False;
      end;

   pofrxReport.ShowReport(True);
   end
else
   Application.MessageBox(PChar('Relatório rel_Apuracao.fr3 não localizado na pasta: ' + ExtractFilePath(Application.ExeName) + 'Relatorios'), 'Despesas', 0);

end;

procedure TImpressao.SetImp_Ano(const Value: String);
begin
  FImp_Ano := Value;
end;

procedure TImpressao.VinculaComponentes;
begin
frxMemoAnoBase           := TfrxMemoView(pofrxReport.FindObject('MAnoBase'));
frxMemoAnoCalendario     := TfrxMemoView(pofrxReport.FindObject('MAnoCalendario'));
frxMemoReceitaBruta      := TfrxMemoView(pofrxReport.FindObject('MReceitaBruta'));
frxMemoDespesas          := TfrxMemoView(pofrxReport.FindObject('MDespesas'));
frxMemoLucroEvidenciado  := TfrxMemoView(pofrxReport.FindObject('MLucroEvidenciado'));
frxMemoPorcentagemIsenta := TfrxMemoView(pofrxReport.FindObject('MPorcentagemIsenta'));
frxMemoValorIsento       := TfrxMemoView(pofrxReport.FindObject('MValorIsento'));
frxMemoValorTributado    := TfrxMemoView(pofrxReport.FindObject('MValorTributado'));
frxMemoValorTributadoIR  := TfrxMemoView(pofrxReport.FindObject('MValorTributadoIR'));
frxMemoNecessidade       := TfrxMemoView(pofrxReport.FindObject('MNecessidade'));
frxPorcIsenta            := TfrxMemoView(pofrxReport.FindObject('MPorcIsenta'));
frxDeclaracaoTributado   := TfrxMemoView(pofrxReport.FindObject('MDeclaracaoTributado'));
frxDeclaracaoIsento      := TfrxMemoView(pofrxReport.FindObject('MDeclaracaoIsento'));
frxChild                 := TfrxChild(pofrxReport.FindObject('Child1'));

frxMemoAnoBase.Memo.Clear;
frxMemoAnoCalendario.Memo.Clear;
frxMemoReceitaBruta.Memo.Clear;
frxMemoDespesas.Memo.Clear;
frxMemoLucroEvidenciado.Memo.Clear;
frxMemoPorcentagemIsenta.Memo.Clear;
frxMemoValorIsento.Memo.Clear;
frxMemoValorTributado.Memo.Clear;
frxMemoValorTributadoIR.Memo.Clear;
frxMemoNecessidade.Memo.Clear;
frxPorcIsenta.Memo.Clear;
frxDeclaracaoTributado.Memo.Clear;
frxDeclaracaoIsento.Memo.Clear;
end;

end.
