unit uBackupRestore;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, uDMPrincipal,
  uBackup_restore, uFuncoes, Vcl.ComCtrls;

type
  TFBackupRestore = class(TForm)
    pcBackup_Restore: TPageControl;
    tsBackup: TTabSheet;
    tsRestore: TTabSheet;
    MemoBackup: TMemo;
    btnBackup: TBitBtn;
    MemoRestore: TMemo;
    btnRestore: TBitBtn;
    edtCaminhoFBK: TEdit;
    gbCaminhoFBK: TGroupBox;
    btnConsFBK: TBitBtn;
    OpenDialog1: TOpenDialog;
    procedure btnBackupClick(Sender: TObject);
    procedure btnRestoreClick(Sender: TObject);
    procedure btnConsFBKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    poBackupRestore : TBackup_restore;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FBackupRestore: TFBackupRestore;

implementation


{$R *.dfm}

procedure TFBackupRestore.btnBackupClick(Sender: TObject);
begin
if not Assigned(poBackupRestore) then
   poBackupRestore := TBackup_restore.Create(DMPrincipal.FDConnection1);

poBackupRestore.BackupFB := DMPrincipal.BackupFB;
if not DirectoryExists(ExtractFilePath(Application.ExeName) + 'Backup\') then
   ForceDirectories(ExtractFilePath(Application.ExeName) + 'Backup\');

poBackupRestore.MemoBackup := MemoBackup;
poBackupRestore.Backup(ExtractFilePath(Application.ExeName) + 'Backup\' + TFuncoesData.fncDiaSemana(Now) + '_' + FormatDateTime('ddmmyyyy', Now) + FormatDateTime('hhmmzzzz', Now)+ '.fbk');
end;

procedure TFBackupRestore.btnConsFBKClick(Sender: TObject);
begin
if OpenDialog1.Execute then
   edtCaminhoFBK.Text := OpenDialog1.FileName;

end;

procedure TFBackupRestore.btnRestoreClick(Sender: TObject);
begin
if Trim(edtCaminhoFBK.Text) <> '' then
   begin
   if not Assigned(poBackupRestore) then
      poBackupRestore := TBackup_restore.Create(DMPrincipal.FDConnection1);

   poBackupRestore.RestoreFB := DMPrincipal.RestoreFB;
   poBackupRestore.MemoBackup := MemoRestore;
   poBackupRestore.Restore(edtCaminhoFBK.Text);
   end
else
   begin
   ShowMessage('Localize o caminho do FBK para continuar.');
   edtCaminhoFBK.SetFocus;
   end;
end;

procedure TFBackupRestore.FormClose(Sender: TObject; var Action: TCloseAction);
begin
DMPrincipal.FDConnection1.Connected := True;
end;

procedure TFBackupRestore.FormShow(Sender: TObject);
begin
DMPrincipal.FDConnection1.Connected := False;
pcBackup_Restore.ActivePage         := tsBackup;
end;

end.
