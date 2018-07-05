unit uProduto;

interface

type
   TProduto = class
      private
        Fpro_CodProduto: Integer;
        Fpro_CodIntProduto: Integer;
        Fpro_DescricaoProduto: String;
        Fpro_Estoque: Double;
        Fpro_Empresa: Integer;
        procedure Setpro_CodIntProduto(const Value: Integer);
        procedure Setpro_CodProduto(const Value: Integer);
        procedure Setpro_DescricaoProduto(const Value: String);
        procedure Setpro_Empresa(const Value: Integer);
        procedure Setpro_Estoque(const Value: Double);
      public
        Constructor Create;
        Destructor Destroy; override;
      protected

      published
        property pro_Empresa : Integer read Fpro_Empresa write Setpro_Empresa;
        property pro_CodProduto : Integer read Fpro_CodProduto write Setpro_CodProduto;
        property pro_CodIntProduto : Integer read Fpro_CodIntProduto write Setpro_CodIntProduto;
        property pro_DescricaoProduto: String read Fpro_DescricaoProduto write Setpro_DescricaoProduto;
        property pro_Estoque : Double read Fpro_Estoque write Setpro_Estoque;
   end;

implementation

{ TProduto }

constructor TProduto.Create;
begin
Fpro_CodProduto       := 0;
Fpro_CodIntProduto    := 0;
Fpro_DescricaoProduto := '';
Fpro_Estoque          := 0;
Fpro_Empresa          := 0;
end;

destructor TProduto.Destroy;
begin

inherited;
end;

procedure TProduto.Setpro_CodIntProduto(const Value: Integer);
begin
  Fpro_CodIntProduto := Value;
end;

procedure TProduto.Setpro_CodProduto(const Value: Integer);
begin
  Fpro_CodProduto := Value;
end;

procedure TProduto.Setpro_DescricaoProduto(const Value: String);
begin
  Fpro_DescricaoProduto := Value;
end;

procedure TProduto.Setpro_Empresa(const Value: Integer);
begin
  Fpro_Empresa := Value;
end;

procedure TProduto.Setpro_Estoque(const Value: Double);
begin
  Fpro_Estoque := Value;
end;

end.
