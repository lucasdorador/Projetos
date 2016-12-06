unit uCRUDUsuario;

interface

uses
 System.SysUtils, FireDac.Comp.Client, Data.DB;

type
   TCRUDUsuario = class(TObject)

   private
    FUsua_Imagem: String;
    FUsua_Senha: String;
    FUsua_Nome: String;
    FUsua_Email: String;
    FUsua_Codigo: Integer;
    procedure SetUsua_Email(const Value: String);
    procedure SetUsua_Imagem(const Value: String);
    procedure SetUsua_Nome(const Value: String);
    procedure SetUsua_Senha(const Value: String);
    procedure SetUsua_Codigo(const Value: Integer);

   public
      constructor Create;
      destructor Destroy; override;
      function GravarDados  : Boolean;
      function ExcluirDados : Boolean;
      function BuscarDados  : TFDMemTable;
   protected

   published
      property Usua_Codigo : Integer read FUsua_Codigo write SetUsua_Codigo;
      property Usua_Nome : String read FUsua_Nome write SetUsua_Nome;
      property Usua_Email : String read FUsua_Email write SetUsua_Email;
      property Usua_Imagem : String read FUsua_Imagem write SetUsua_Imagem;
      property Usua_Senha : String read FUsua_Senha write SetUsua_Senha;
   end;

implementation

{ TCrudUsuario }

uses uDMPrincipal;

function TCRUDUsuario.BuscarDados: TFDMemTable;
var
   vloFDMenTable : TFDMemTable;
begin
vloFDMenTable := TFDMemTable.Create(nil);

try
vloFDMenTable.FieldDefs.Clear;
vloFDMenTable.FieldDefs.Add('Usua_Email', ftString, 50, False);
vloFDMenTable.FieldDefs.Add('Usua_Imagem', ftBlob, 0, False);
vloFDMenTable.CreateDataSet;

DMPrincipal.FDUsuario.Close;
DMPrincipal.FDUsuario.SQL.Clear;
DMPrincipal.FDUsuario.SQL.Add('SELECT * FROM USUARIO WHERE USUA_NOME = :NOME');
DMPrincipal.FDUsuario.ParamByName('NOME').AsString := FUsua_Nome;
DMPrincipal.FDUsuario.Open;

vloFDMenTable.Append;
vloFDMenTable.FieldByName('Usua_Email').AsString  := DMPrincipal.FDUsuario.FieldByName('Usua_Email').AsString;
vloFDMenTable.FieldByName('Usua_Imagem').AsString := DMPrincipal.FDUsuario.FieldByName('Usua_Imagem').AsString;
vloFDMenTable.Post;

Result := vloFDMenTable;

except on E: Exception do
   begin
   raise Exception.Create(e.Message);
   end;

   end;
end;

constructor TCrudUsuario.Create;
begin
DMPrincipal.FDUsuario.Open();
end;

destructor TCrudUsuario.Destroy;
begin
DMPrincipal.FDUsuario.Close;
  inherited;
end;

function TCrudUsuario.ExcluirDados: Boolean;
begin
Result := True;
try
DMPrincipal.FDUsuario.Close;
DMPrincipal.FDUsuario.SQL.Clear;
DMPrincipal.FDUsuario.SQL.Add('DELETE FROM USUARIO WHERE USUA_CODIGO = :CODIGO');
DMPrincipal.FDUsuario.ParamByName('CODIGO').AsInteger := FUsua_Codigo;
DMPrincipal.FDUsuario.ExecSQL;
   except on E: Exception do
      begin
      Result := False;
      raise Exception.Create(e.Message);
      end;
end;
end;

function TCrudUsuario.GravarDados: Boolean;
begin
Result := True;
try
DMPrincipal.FDUsuario.Close;
DMPrincipal.FDUsuario.SQL.Clear;
DMPrincipal.FDUsuario.SQL.Add('INSERT INTO USUARIO (USUA_NOME, USUA_EMAIL, USUA_IMAGEM, USUA_SENHA)');
DMPrincipal.FDUsuario.SQL.Add('                    VALUES (:USUA_NOME, :USUA_EMAIL, :USUA_IMAGEM, :USUA_SENHA)');
DMPrincipal.FDUsuario.ParamByName('USUA_NOME').AsString   := FUsua_Nome;
DMPrincipal.FDUsuario.ParamByName('USUA_EMAIL').AsString  := FUsua_Email;
DMPrincipal.FDUsuario.ParamByName('USUA_IMAGEM').AsString := FUsua_Imagem;
DMPrincipal.FDUsuario.ParamByName('USUA_SENHA').AsString  := FUsua_Senha;
DMPrincipal.FDUsuario.ExecSQL;
   except on E: Exception do
      begin
      Result := False;
      raise Exception.Create(e.Message);
      end;
end;
end;

procedure TCRUDUsuario.SetUsua_Codigo(const Value: Integer);
begin
  FUsua_Codigo := Value;
end;

procedure TCRUDUsuario.SetUsua_Email(const Value: String);
begin
  FUsua_Email := Value;
end;

procedure TCRUDUsuario.SetUsua_Imagem(const Value: String);
begin
  FUsua_Imagem := Value;
end;

procedure TCRUDUsuario.SetUsua_Nome(const Value: String);
begin
  FUsua_Nome := Value;
end;

procedure TCRUDUsuario.SetUsua_Senha(const Value: String);
begin
  FUsua_Senha := Value;
end;

end.
