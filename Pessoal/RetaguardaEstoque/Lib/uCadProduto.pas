unit uCadProduto;

interface

uses
  uProduto, FireDAc.Comp.Client, FireDAc.Stan.Param, Data.DB,
  FireDAc.DApt;

type
   TCadProduto = class(TProduto)
     private
       FConexao : TFDConnection;
     public
        Constructor Create(poConexao: TFDConnection); virtual;
        Destructor Destroy(); override;
        function Insert : String;
        function Delete : String;
        function ConsDescricaoProduto: String;
        function fncConsUltimoProduto: Integer;
        function fncConsultaProduto: TFDQuery;
   end;

implementation

uses
  System.SysUtils;

{ TCadProduto }

function TCadProduto.ConsDescricaoProduto: String;
var
   vlsResult : String;
   voQuery : TFDQuery;
begin
voQuery := TFDQuery.Create(nil);
voQuery.Close;
voQuery.Connection := FConexao;
try
voQuery.SQL.Clear;
voQuery.SQL.Add('SELECT PRO_DESCRICAOPRODUTO FROM PRODUTO WHERE PRO_EMPRESA = :PRO_EMPRESA AND PRO_CODPRODUTO = :PRO_CODPRODUTO');
voQuery.ParamByName('PRO_EMPRESA').AsInteger         := pro_Empresa;
voQuery.ParamByName('PRO_CODPRODUTO').AsInteger      := pro_CodProduto;
voQuery.Open();

vlsResult := voQuery.FieldByName('PRO_DESCRICAOPRODUTO').AsString;

finally
   Result := vlsResult;
   FreeAndNil(voQuery);
   end;
end;

constructor TCadProduto.Create(poConexao: TFDConnection);
begin
  inherited Create;

FConexao := poConexao;
end;

function TCadProduto.Delete: String;
var
   vlsResult : String;
   voQuery : TFDQuery;
begin
vlsResult := '';
voQuery   := TFDQuery.Create(nil);
try
voQuery.Close;
voQuery.Connection := FConexao;
voQuery.SQL.Clear;
voQuery.SQL.Add('DELETE FROM PRODUTO WHERE PRO_EMPRESA = :PRO_EMPRESA AND PRO_CODPRODUTO = :PRO_CODPRODUTO');
voQuery.ParamByName('PRO_EMPRESA').AsInteger         := pro_Empresa;
voQuery.ParamByName('PRO_CODPRODUTO').AsInteger      := pro_CodProduto;

try
voQuery.ExecSQL;
except
   on E:Exception do
      begin
      vlsResult := 'Erro na função: TCadProduto.Delete - ' + e.Message;
      end;
   end;

finally
   Result := vlsResult;
   FreeAndNil(voQuery);
   end;
end;

destructor TCadProduto.Destroy;
begin

  inherited;
end;

function TCadProduto.fncConsultaProduto: TFDQuery;
var
   voQuery : TFDQuery;
begin
voQuery := TFDQuery.Create(nil);
voQuery.Close;
voQuery.Connection := FConexao;
voQuery.SQL.Clear;
voQuery.SQL.Add('SELECT PRO_CODINTPRODUTO, PRO_DESCRICAOPRODUTO, PRO_ESTOQUE ');
voQuery.SQL.Add('FROM PRODUTO WHERE PRO_EMPRESA = :EMPRESA AND PRO_CODPRODUTO = :PRODUTO');
voQuery.ParamByName('EMPRESA').AsInteger := pro_Empresa;
voQuery.ParamByName('PRODUTO').AsInteger := pro_CodProduto;
voQuery.Open();

Result := voQuery;
end;

function TCadProduto.fncConsUltimoProduto: Integer;
var
   vlsResult : Integer;
   voQuery : TFDQuery;
begin
voQuery := TFDQuery.Create(nil);
voQuery.Close;
voQuery.Connection := FConexao;
try
voQuery.SQL.Clear;
voQuery.SQL.Add('SELECT MAX(PRO_CODPRODUTO) AS ULTIMO FROM PRODUTO WHERE PRO_EMPRESA = :EMPRESA');
voQuery.ParamByName('EMPRESA').AsInteger := pro_Empresa;
voQuery.Open();

vlsResult := voQuery.FieldByName('ULTIMO').AsInteger + 1;

finally
   Result := vlsResult;
   FreeAndNil(voQuery);
   end;
end;

function TCadProduto.Insert: String;
var
   vlsResult : String;
   voQuery : TFDQuery;
begin
vlsResult := '';
voQuery := TFDQuery.Create(nil);
try
voQuery.Close;
voQuery.Connection := FConexao;

voQuery.SQL.Clear;
voQuery.SQL.Add('SELECT PRO_EMPRESA FROM PRODUTO WHERE PRO_EMPRESA = :PRO_EMPRESA AND PRO_CODPRODUTO = :PRO_CODPRODUTO');
voQuery.ParamByName('PRO_EMPRESA').AsInteger         := pro_Empresa;
voQuery.ParamByName('PRO_CODPRODUTO').AsInteger      := pro_CodProduto;
voQuery.Open();

if voQuery.IsEmpty then
   begin
   voQuery.SQL.Clear;
   voQuery.SQL.Add('INSERT INTO PRODUTO (PRO_EMPRESA, PRO_CODPRODUTO, PRO_CODINTPRODUTO, ');
   voQuery.SQL.Add('                     PRO_DESCRICAOPRODUTO, PRO_ESTOQUE)');
   voQuery.SQL.Add('VALUES (:PRO_EMPRESA, :PRO_CODPRODUTO, :PRO_CODINTPRODUTO, ');
   voQuery.SQL.Add('        :PRO_DESCRICAOPRODUTO, :PRO_ESTOQUE)');
   end
else
   begin
   voQuery.SQL.Clear;
   voQuery.SQL.Add('UPDATE PRODUTO');
   voQuery.SQL.Add('SET PRO_CODINTPRODUTO = :PRO_CODINTPRODUTO,');
   voQuery.SQL.Add('    PRO_DESCRICAOPRODUTO = :PRO_DESCRICAOPRODUTO,');
   voQuery.SQL.Add('    PRO_ESTOQUE = :PRO_ESTOQUE');
   voQuery.SQL.Add('WHERE (PRO_EMPRESA = :PRO_EMPRESA) AND (PRO_CODPRODUTO = :PRO_CODPRODUTO)');
   end;

voQuery.ParamByName('PRO_EMPRESA').AsInteger         := pro_Empresa;
voQuery.ParamByName('PRO_CODPRODUTO').AsInteger      := pro_CodProduto;
voQuery.ParamByName('PRO_CODINTPRODUTO').AsInteger   := pro_CodIntProduto;
voQuery.ParamByName('PRO_DESCRICAOPRODUTO').AsString := pro_DescricaoProduto;
voQuery.ParamByName('PRO_ESTOQUE').AsFloat           := pro_Estoque;

try
voQuery.ExecSQL;
except
   on E:Exception do
      begin
      vlsResult := 'Erro na função: TCadProduto.Insert - ' + e.Message;
      end;
   end;

finally
   Result := vlsResult;
   FreeAndNil(voQuery);
   end;
end;

end.
