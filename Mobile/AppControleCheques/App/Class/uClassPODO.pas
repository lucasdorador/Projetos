unit uClassPODO;

interface
   type
      TConfiguracaoApp = class(TObject)
        private
    FpsPortaConexao: String;
    FpsEnderecoIP: String;
    procedure SetpsEnderecoIP(const Value: String);
    procedure SetpsPortaConexao(const Value: String);

        public
          Constructor Create();
        published
          property psEnderecoIP   : String read FpsEnderecoIP write SetpsEnderecoIP;
          property psPortaConexao : String read FpsPortaConexao write SetpsPortaConexao;


      end;

implementation

{ TConfiguracaoApp }

constructor TConfiguracaoApp.Create;
begin
FpsPortaConexao := '';
FpsEnderecoIP   := '';
end;

procedure TConfiguracaoApp.SetpsEnderecoIP(const Value: String);
begin
  FpsEnderecoIP := Value;
end;

procedure TConfiguracaoApp.SetpsPortaConexao(const Value: String);
begin
  FpsPortaConexao := Value;
end;

end.
