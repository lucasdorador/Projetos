unit uTabelas;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
   Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons,
   Vcl.ExtDlgs, IniFiles, Data.SqlExpr, FireDAc.Comp.Client, FireDAc.Stan.Async;

Type
   TTabelas = Class(TObject)
  private

  public
    class procedure TabelasFirebird(Conexao: TFDConnection); static;

   End;


implementation

uses uFuncoes;

class procedure TTabelas.TabelasFirebird(Conexao: TFDConnection);
var
   VLi : Integer;
   Tipo, Campo: Array[0..202] of String;
begin
//**********************************TABELA BANCOS************************************
//FProcessamento.Gauge1.Progress:=FProcessamento.Gauge1.Progress + 1;
//UFuncoes.ChamaTabela('a Tabela PRODUTO');
if not TableExists(Conexao, 'BANCOS') then
   begin
   Conexao.ExecSQL(
   'CREATE TABLE BANCOS ( '+
   ' BC_CODIGO     VARCHAR(10) NOT NULL, '+
   ' BC_DESCRICAO  VARCHAR(50) '+
   ')');
   end
else
   begin
   for VLi := 0 to 50 do
      begin
      Tipo[VLi]:='';
      Campo[VLi]:='';
      end;

   CAMPO[0]:='BC_CODIGO';
   TIPO[0]:=' VARCHAR(10)';
   CAMPO[1]:='BC_DESCRICAO';
   TIPO[1]:=' VARCHAR(50)';

   for VLi := 0 to 1 do
      begin
      if not FieldExists(Conexao, 'BANCOS', campo[VLi]) then
         begin
         Conexao.ExecSQL(
            'ALTER TABLE BANCOS ADD '+ campo[VLi] +' '+ tipo[VLi] +';');
         end;
      end;
   End;
//**************************Indice PK PRODUTO******************************
if not IndexExists(Conexao, 'BANCOS') then
   begin
   Conexao.ExecSQL(
      'ALTER TABLE BANCOS ADD CONSTRAINT PK_BANCOS PRIMARY KEY (BC_CODIGO);');
   end;

//**********************************TABELA CONTAS************************************
//FProcessamento.Gauge1.Progress:=FProcessamento.Gauge1.Progress + 1;
//UFuncoes.ChamaTabela('a Tabela UNIDADE');
if not TableExists(Conexao, 'CONTAS') then
   begin
   Conexao.ExecSQL(
   'CREATE TABLE CONTAS ( '+
   ' CC_NUMERO     VARCHAR(15) NOT NULL, '+
   ' CC_BANCO      VARCHAR(10) NOT NULL, '+
   ' CC_DESCRICAO  VARCHAR(50), '+
   ' CC_AGENCIA    VARCHAR(10) '+
   ');');
   end
else
   begin
   for VLi := 0 to 50 do
      begin
      Tipo[VLi]:='';
      Campo[VLi]:='';
      end;

   CAMPO[0]:='CC_NUMERO';
   TIPO[0]:=' VARCHAR(15)';
   CAMPO[1]:='CC_DESCRICAO';
   TIPO[1]:=' VARCHAR(50)';
   CAMPO[2]:='CC_AGENCIA';
   TIPO[2]:=' VARCHAR(10)';

   for VLi := 0 to 2 do
      begin
      if not FieldExists(Conexao, 'CONTAS', campo[VLi]) then
         begin
         Conexao.ExecSQL(
            'ALTER TABLE CONTAS ADD '+ campo[VLi] +' '+ tipo[VLi] +';');
         end;
      end;
   End;
//**************************Indice PK UNIDADE******************************
if not IndexExists(Conexao, 'CONTAS') then
   begin
   Conexao.ExecSQL(
      'ALTER TABLE CONTAS ADD CONSTRAINT PK_CONTAS PRIMARY KEY (CC_NUMERO, CC_BANCO);');
   end;

//**********************************TABELA CHEQUES************************************
//FProcessamento.Gauge1.Progress:=FProcessamento.Gauge1.Progress + 1;
//UFuncoes.ChamaTabela('a Tabela CHEQUES');
if not TableExists(Conexao, 'CHEQUES') then
   begin
   Conexao.ExecSQL(
   'CREATE TABLE CHEQUES ( '+
   ' CH_CODIGO           INTEGER NOT NULL, '+
   ' CH_BANCO            VARCHAR(10) NOT NULL, '+
   ' CH_CONTACORRENTE    VARCHAR(15) NOT NULL, '+
   ' CH_NUMEROCHEQUE     VARCHAR(8), '+
   ' CH_VALOR            DOUBLE PRECISION, '+
   ' CH_DATALANCAMENTO   DATE, '+
   ' CH_DATACOMPENSACAO  DATE '+
   ');');
   end
else
   begin
   for VLi := 0 to 50 do
      begin
      Tipo[VLi]:='';
      Campo[VLi]:='';
      end;

   CAMPO[0]:='CH_CODIGO';
   TIPO[0]:=' INTEGER';
   CAMPO[1]:='CH_BANCO';
   TIPO[1]:=' VARCHAR(10)';
   CAMPO[2]:='CH_CONTACORRENTE';
   TIPO[2]:=' VARCHAR(15)';
   CAMPO[3]:='CH_NUMEROCHEQUE';
   TIPO[3]:=' VARCHAR(8)';
   CAMPO[4]:='CH_VALOR';
   TIPO[4]:=' DOUBLE PRECISION';
   CAMPO[5]:='CH_DATALANCAMENTO';
   TIPO[5]:=' DATE';
   CAMPO[6]:='CH_DATACOMPENSACAO';
   TIPO[6]:=' DATE';

   for VLi := 0 to 6 do
      begin
      if not FieldExists(Conexao, 'CHEQUES', campo[VLi]) then
         begin
         Conexao.ExecSQL(
            'ALTER TABLE CHEQUES ADD '+ campo[VLi] +' '+ tipo[VLi] +';');
         end;
      end;
   End;
//**************************Indice PK UNIDADE******************************
if not IndexExists(Conexao, 'CHEQUES') then
   begin
   Conexao.ExecSQL(
      'ALTER TABLE CHEQUES ADD CONSTRAINT PK_CHEQUES PRIMARY KEY (CH_CODIGO, CH_BANCO, CH_CONTACORRENTE);');
   end;
end;

end.
