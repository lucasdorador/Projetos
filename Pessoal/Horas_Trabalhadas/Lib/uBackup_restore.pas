unit uBackup_restore;

interface

uses
  FireDAC.Phys.FB, FireDAC.Comp.Client;

type
  TBackup_restore = class(TObject)
  private
    FConexao : TFDConnection;
    FBackupFB: TFDFBNBackup;
    FRestoreFB: TFDFBNRestore;
    procedure SetBackupFB(const Value: TFDFBNBackup);
    procedure SetRestoreFB(const Value: TFDFBNRestore);
  public
    constructor Create(poConexao: TFDCOnnection);
    destructor Destroy; override;
    procedure Backup(psCaminhoFDB : String);
    procedure Restore;
  published
    property BackupFB: TFDFBNBackup read FBackupFB write SetBackupFB;
    property RestoreFB: TFDFBNRestore read FRestoreFB write SetRestoreFB;
  end;

implementation

{ TBackup_restore }

procedure TBackup_restore.Backup(psCaminhoFDB : String);
begin
if FBackupFB <> nil then
   begin
   FBackupFB.Database   := FConexao.Params.Database;
   FBackupFB.BackupFile := psCaminhoFDB;
   FBackupFB.Level      := 0;

   FBackupFB.Backup;
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

procedure TBackup_restore.Restore;
begin
if FRestoreFB <> nil then
   begin

   end;
end;

procedure TBackup_restore.SetBackupFB(const Value: TFDFBNBackup);
begin
FBackupFB := Value;
end;

procedure TBackup_restore.SetRestoreFB(const Value: TFDFBNRestore);
begin
FRestoreFB := Value;
end;

end.
