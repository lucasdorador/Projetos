program BackupRestore;

uses
  Vcl.Forms,
  uBackupRestore in 'uBackupRestore.pas' {FBackupRestore},
  uBackup_restore in 'Lib\uBackup_restore.pas',
  uDMBackupRestore in 'uDMBackupRestore.pas' {DMBackupRestore: TDataModule},
  uFuncoes in '..\Horas_Trabalhadas\Lib\uFuncoes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFBackupRestore, FBackupRestore);
  Application.CreateForm(TDMBackupRestore, DMBackupRestore);
  Application.Run;
end.
