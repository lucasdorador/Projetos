unit uComunicaServer;

interface

uses
   FGX.ProgressDialog, FMX.Dialogs;

type
   TComunicaServer = class(TObject)
      private
        FvloProgresso: TfgActivityDialog;
        FvlsMensagemErro: String;
        procedure SetvloProgresso(const Value: TfgActivityDialog);
        procedure SetvlsMensagemErro(const Value: String);

      public
        constructor Create();
        destructor Destroy; override;
        function fncValidaConexaoServidor : Boolean;
      published
        property vloProgresso : TfgActivityDialog read FvloProgresso write SetvloProgresso;
        property vlsMensagemErro : String read FvlsMensagemErro write SetvlsMensagemErro;


   end;

implementation

{ TComunicaServer }

uses ClientClassesUnit1, System.Classes, ClientModuleUnit1, System.SysUtils;

constructor TComunicaServer.Create;
begin
inherited;

end;

destructor TComunicaServer.Destroy;
begin

  inherited;
end;

function TComunicaServer.fncValidaConexaoServidor: Boolean;
var
   vloServico : TServerMethods1Client;
   vlRetorno  : String;
begin
TThread.CreateAnonymousThread(procedure ()
   begin
   FvloProgresso.show;
   try
   vloServico := TServerMethods1Client.Create(ClientModule1.DSRestConnection1);

   try
   vlRetorno := vloServico.fncTesteServidor();
   Except
      on e : exception do
         begin
         vlRetorno        := '';
         FvlsMensagemErro := e.message;
         end;
      end;

   TThread.Synchronize (TThread.CurrentThread,
      procedure ()
         begin
         if vlRetorno = 'OK' then
            ShowMessage('Comunicação com o servidor efetuada com sucesso!')
         else
            ShowMessage('Não foi possível efetuar a comunicação com servidor. Erro: ' + FvlsMensagemErro);
         end);

   finally
      FvloProgresso.Hide;
      if Assigned(vloServico) then
         FreeAndNil(vloServico);
      end;
   end).Start;
end;


procedure TComunicaServer.SetvloProgresso(const Value: TfgActivityDialog);
begin
  FvloProgresso := Value;
end;

procedure TComunicaServer.SetvlsMensagemErro(const Value: String);
begin
  FvlsMensagemErro := Value;
end;

end.
