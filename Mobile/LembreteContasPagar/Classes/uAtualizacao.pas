unit uAtualizacao;

interface

uses
    FMX.ListBox;

type
   TAtualizacao = class(TObject)
      private

      protected

      public
         constructor Create;
         destructor Destroy; override;
         procedure fncCarregaUsuarios(vlCombo : TComboBox);
      published

   end;

implementation

{ TAtualizacao }

uses uDMPrincipal;

constructor TAtualizacao.Create;
begin
inherited Create;
end;

destructor TAtualizacao.Destroy;
begin

  inherited;
end;

procedure TAtualizacao.fncCarregaUsuarios(vlCombo : TComboBox);
begin
DMPrincipal.FDUsuario.Close;
DMPrincipal.FDUsuario.SQL.Clear;
DMPrincipal.FDUsuario.SQL.Add('SELECT * FROM USUARIO ORDER BY USUA_NOME');
DMPrincipal.FDUsuario.Open;
DMPrincipal.FDUsuario.FetchAll;
DMPrincipal.FDUsuario.First;
vlCombo.Items.Clear;

while not DMPrincipal.FDUsuario.Eof do
   begin
   vlCombo.Items.Add(DMPrincipal.FDUsuario.FieldByName('USUA_NOME').AsString);
   DMPrincipal.FDUsuario.Next;
   end;
end;

end.
