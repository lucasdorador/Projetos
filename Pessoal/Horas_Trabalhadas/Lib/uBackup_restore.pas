{$M+}
unit uBackup_restore;

interface

uses
  FireDAC.Phys.FB, IBX.IBServices, FireDAC.Comp.Client, Vcl.StdCtrls,
  System.SysUtils, Vcl.Forms;

type
  TBackup_restore = class(TObject)
  private
    FConexao : TFDConnection;
    FBackupFB: TIBBackupService;
    FRestoreFB: TIBRestoreService ;
    FMemoBackup: TMemo;
    procedure SetBackupFB(const Value: TIBBackupService );
    procedure SetRestoreFB(const Value: TIBRestoreService);
    procedure SetMemoBackup(const Value: TMemo);
  public
    constructor Create(poConexao: TFDCOnnection);
    destructor Destroy; override;
    procedure Backup(psCaminhoFBK : String);
    procedure Restore(psCaminhoFBK : String);
  published
    property BackupFB: TIBBackupService read FBackupFB write SetBackupFB;
    property RestoreFB: TIBRestoreService read FRestoreFB write SetRestoreFB;
    property MemoBackup : TMemo read FMemoBackup write SetMemoBackup;
  end;

implementation

{ TBackup_restore }

procedure TBackup_restore.Backup(psCaminhoFBK : String);
begin
if FBackupFB <> nil then
   begin
   try
      MemoBackup.Clear;
      MemoBackup.Lines.Add('Preparando para gerar o backup...');
      MemoBackup.Lines.Add('');

      FConexao.Connected:=False;//desconecta da base de dados
      FBackupFB.DatabaseName:=FConexao.Params.Database;//caminho da base de dados
      FBackupFB.ServerName:='localhost';//nome do servidor
      FBackupFB.BackupFile.Clear;
      FBackupFB.BackupFile.Add(psCaminhoFBK);//adiciona o caminho do arquivo de backup escolhido pelo usu�rio
      FBackupFB.Protocol:=Local;//protocolo de conex�o
      FBackupFB.Params.Clear;
      FBackupFB.Params.Add('user_name=SYSDBA');//nome de usu�rio
      FBackupFB.Params.Add('password=masterkey');//senha do usu�rio

      FBackupFB.Options:=[];//limpa a propriedade option
      {o bloco de if abaixo esta adicionando as op��es de restaura��o de acordo com o  que o usu�rio escolheu. Ap�s esta listagem voc� encontra um link para um outro artigo onde voc� encontra mais informa��es sobre essas e outras op��es de restaura��o}
      FBackupFB.Options:= FBackupFB.Options+[IgnoreChecksums];
      FBackupFB.Options:= FBackupFB.Options+[IgnoreLimbo];
      FBackupFB.Options:= FBackupFB.Options+[NoGarbageCollection];

      {a propriedade verbose do TIBBackupService especifica
      se durante o processo de backup ser� retornado para a
      aplica��o o detalhamento da execu��o}
      FBackupFB.Verbose := True;

      MemoBackup.Lines.Add('  Verbose: '+BoolToStr(True));
      MemoBackup.Lines.Add('  Nome do servidor: '+FBackupFB.ServerName);
      MemoBackup.Lines.Add('');
      FBackupFB.Active:=True;//ativa o servi�o de backup, mais ainda n�o inicia.
      MemoBackup.Lines.Add('');
      MemoBackup.Lines.Add('/***INICIO***\');
      Application.ProcessMessages;
      MemoBackup.Lines.Add('');
      try
         FBackupFB.ServiceStart;//inicia o processo de backup
         while not FBackupFB.Eof do
            begin
            {conforme o backup vai sendo executado o nos podemos pegar os detalhes da sua execu��o atrav�s da fun��o GetNextLine}
            MemoBackup.Lines.Add(FBackupFB.GetNextLine);
            end;
      finally
         end;

      FBackupFB.Active:=False;//desativa o servi�o de backup
      MemoBackup.Lines.Add('');
      MemoBackup.Lines.Add('/****FIM****\');
      MemoBackup.Lines.Add('');
      MemoBackup.Lines.Add('');
      MemoBackup.Lines.Add('Backup conclu�do.');
      MemoBackup.Lines.Add('Backup gravado em: ' + psCaminhoFBK);
      FConexao.Connected:=True;//conecta o sistema na base de dados
   except
      on E: Exception do
         begin
         MemoBackup.Lines.Add('Ocorreu um erro inesperado. O backup n�o foi conclu�do.');
         MemoBackup.Lines.Add('Informa��es da exce��o:');
         MemoBackup.Lines.Add('  '+E.Message);
         FConexao.Connected:=True;//conecta o sistema na base de dados
         end;
      end;
   end;
end;

constructor TBackup_restore.Create(poConexao: TFDCOnnection);
begin
FConexao := poConexao;

end;

destructor TBackup_restore.Destroy;
begin
inherited;
end;

procedure TBackup_restore.Restore(psCaminhoFBK: String);
begin
if FRestoreFB <> nil then
   begin
   try
      MemoBackup.Clear;
      MemoBackup.Lines.Add('Preparando para restaurar o backup...');
      MemoBackup.Lines.Add('');

      with FRestoreFB do
         begin
         FConexao.Connected := False;//desconecta da base
         DatabaseName.Clear;
         DatabaseName.Add(FConexao.Params.Database);//caminho da base
         ServerName:='';//nome do servidor
         BackupFile.Clear;
         BackupFile.Add(psCaminhoFBK);//caminho do arquivo de backup
         Protocol:=Local;//protocolo de conex�o
         Params.Clear;
         Params.Add('user_name=SYSDBA');//nome de usu�rio
         Params.Add('password=masterkey');//senha do usu�rio

         Options:=[];
         Options:=[CreateNewDB];
         {o bloco de if abaixo esta adicionando as op��es de restaura��o de acordo com o que o usu�rio escolheu. Ap�s esta listagem voc� encontra um link para um outro artigo onde voc� encontra mais informa��es sobre essas e outras op��es de restaura��o}
//         if CBDesativarIndices.Checked then
//            Options:=Options+[DeactivateIndexes];
//         if CBSemShadow.Checked then
//            Options:=Options+[NoShadow];
//         if CBSemValidar.Checked then
//            Options:=Options+[NoValidityCheck];
//         if CBUmaTabela.Checked then
//            Options:=Options+[OneRelationAtATime];
//         if CBSubstituir.Checked then
//            Options:=Options+[Replace];

         {a propriedade verbose do TIBRestoreService especifica
         se durante o processo de restaura��o ser� retornado para a
         aplica��o o detalhamento da execu��o}
         Verbose:=True;

//         MemoBackup.Lines.Add('  Desativar indices: '+BoolToStr(CBDesativarIndices.Checked));
//         MemoBackup.Lines.Add('  Restaurar arquivo espelho: '+BoolToStr(not CBSemShadow.Checked));
//         MemoBackup.Lines.Add('  Validar regras de integridade: '+BoolToStr(not CBSemValidar.Checked));
//         MeMemoBackupmo1.Lines.Add('  Restaurar uma tabela por vez: '+BoolToStr(CBUmaTabela.Checked));
         MemoBackup.Lines.Add('  Nome do servidor: '+ServerName);
         MemoBackup.Lines.Add('');
         Active:=True;//ativa o servico de restaura��o, mais ainda nao inicia.
         MemoBackup.Lines.Add('');
         MemoBackup.Lines.Add('/***INICIO***\');
         Application.ProcessMessages;
         MemoBackup.Lines.Add('');
         try
            ServiceStart;//inicia o restore
            while not Eof do
               begin
               {assim como no backup, conforme a restaura��o vai sendo executada os detalhes da execu��o podem ser lidos atrav�s da fun��o GetNextLine}
               MemoBackup.Lines.Add(GetNextLine);
               end;
         finally
            end;
         Active:=False;//desativa o servi�o de restore
         MemoBackup.Lines.Add('');
         MemoBackup.Lines.Add('/****FIM****\');
         end;

      MemoBackup.Lines.Add('');
      MemoBackup.Lines.Add('');
      MemoBackup.Lines.Add('Backup restaurado com sucesso.');
      FConexao.Connected:=True;//conecta o sistema na base de dados
   except
      on E: Exception do
         begin
         MemoBackup.Lines.Add('Ocorreu um erro inesperado. O restore n�o foi conclu�do.');
         MemoBackup.Lines.Add('Informa��es da exce��o:');
         MemoBackup.Lines.Add('  '+E.Message);
         FConexao.Connected:=True;//conecta o sistema na base de dados
         end;
      end;
   end;
end;

procedure TBackup_restore.SetBackupFB(const Value: TIBBackupService);
begin
FBackupFB := Value;
end;

procedure TBackup_restore.SetMemoBackup(const Value: TMemo);
begin
  FMemoBackup := Value;
end;

procedure TBackup_restore.SetRestoreFB(const Value: TIBRestoreService);
begin
FRestoreFB := Value;
end;

end.
