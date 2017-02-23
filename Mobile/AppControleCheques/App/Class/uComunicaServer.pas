unit uComunicaServer;

interface

uses
   FGX.ProgressDialog, FMX.Dialogs, Data.FireDACJSONReflect;

type
   TComunicaServer = class(TObject)
      private
        FvloProgresso: TfgActivityDialog;
        FvlsMensagemErro: String;
        procedure SetvloProgresso(const Value: TfgActivityDialog);
        procedure SetvlsMensagemErro(const Value: String);
    function retornaErroTimeOut(vlClassName, vlErro: String): String;

      public
        constructor Create();
        destructor Destroy; override;
        function fncValidaConexaoServidor : Boolean;
        function fncValidaConexaoServidorSemMsg : Boolean;
        procedure getListaCheques;
      published
        property vloProgresso : TfgActivityDialog read FvloProgresso write SetvloProgresso;
        property vlsMensagemErro : String read FvlsMensagemErro write SetvlsMensagemErro;


   end;

const
   vlMsgErro = 'Não foi possível conectar-se ao servidor. Por favor verifique!';

implementation

{ TComunicaServer }

uses ClientClassesUnit1, System.Classes, ClientModuleUnit1, System.SysUtils,
     udmPrincipal, uConfiguracao;

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


function TComunicaServer.fncValidaConexaoServidorSemMsg: Boolean;
var
   vlservico : TServerMethods1Client;
   vlRetorno : String;
begin
try
vlservico := TServerMethods1Client.Create(ClientModule1.DSRestConnection1);

try
vlRetorno := vlservico.fncTesteServidor();
Except
   on e:exception do
      begin
      vlRetorno       := '';
      vlsMensagemErro := e.Message;
      end;
   end;

if vlRetorno = 'OK' then
   begin
   Result := True;
   end
else
   begin
   Result := False;
   end;

finally
   if Assigned(vlservico) then
      FreeAndNil(vlservico);
   end;
end;

procedure TComunicaServer.getListaCheques;
begin

TThread.CreateAnonymousThread(procedure ()
var
   vlServico        : TServerMethods1Client;
   vlRetornoServer  : TFDJSONDataSets;
begin

try //finally

try
FvloProgresso.Message := 'Buscando informações do servidor...';
FvloProgresso.Show;

vlServico := TServerMethods1Client.Create(ClientModule1.DSRestConnection1);

if fncValidaConexaoServidorSemMsg then
   begin
   vlRetornoServer := vlServico.fncBuscaCheques();

   dmPrincipal.FDMCheques.Active := False;
   //Fazemos um teste para verifica se realmente há DataSets no retorno da função
   Assert(TFDJSONDataSetsReader.GetListCount(vlRetornoServer) = 1);
   //Adicionamos o conteúdo do DataSet "baixado" ao Memory Table
   dmPrincipal.FDMCheques.AppendData(TFDJSONDataSetsReader.GetListValue(vlRetornoServer, 0));

   if not dmPrincipal.FDMCheques.Active then
      dmPrincipal.FDMCheques.Open;

//   TThread.Synchronize (TThread.CurrentThread,
//   procedure ()
//      begin
//      vlAppDao := TAppDAO.Create;
//      try
//      vlAppDao.carregaListaReprese(frmLogin.edtUsuario);
//      finally
//         FreeAndNil(vlAppDao);
//         end;
//      end);
   end
else
   begin
   TThread.Synchronize (TThread.CurrentThread,
   procedure ()
      begin
      ShowMessage(vlsMensagemErro);
      end);
   end;

Except
   on e :exception do
      begin
      TThread.Synchronize (TThread.CurrentThread,
      procedure ()
         begin
         {if e.ClassName = 'EIdSocketError' then
            ShowMessage(vlMsgErro)
         else
            ShowMessage(e.Message + ' ' + e.ClassName);}

         ShowMessage(retornaErroTimeOut(e.ClassName, e.Message));
         FConfiguracao.Show;
         end);
      end;
   end;

finally
   FvloProgresso.Hide;
   if Assigned(vlServico) then
      FreeAndNil(vlServico);
   if Assigned(vlRetornoServer) then
      FreeAndNil(vlRetornoServer);
   end;

end).Start;
end;

function TComunicaServer.retornaErroTimeOut(vlClassName, vlErro : String): String;
begin
if (Trim(vlClassName) = 'EIdSocketError') or
   (Pos('TIMEOUT' , AnsiUpperCase(vlErro)) > 0) or
   (Pos('TIME OUT', AnsiUpperCase(vlErro)) > 0) or
   (Pos('FAILED TO CONNECT', AnsiUpperCase(vlErro)) > 0) then
   begin
   Result := vlMsgErro;
   end
else
   begin
   Result := vlErro + ' ' + vlClassName;
   end;
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
