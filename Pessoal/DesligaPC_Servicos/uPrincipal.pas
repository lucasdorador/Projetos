unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.SvcMgr, Vcl.Dialogs,
  IniFiles, Vcl.ExtCtrls, Registry;

type
  TFPrincipal = class(TService)
    TimerDesligar: TTimer;
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure TimerDesligarTimer(Sender: TObject);
    procedure ServiceAfterInstall(Sender: TService);
    procedure ServiceBeforeUninstall(Sender: TService);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
  private
    vlsHoraConfigurada : String;
    procedure gravarLogTXT(psMensagem: String);
    { Private declarations }
  public
    function GetServiceController: TServiceController; override;
    { Public declarations }
  end;

var
  FPrincipal: TFPrincipal;

implementation

{$R *.dfm}

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  FPrincipal.Controller(CtrlCode);
end;

function TFPrincipal.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TFPrincipal.gravarLogTXT(psMensagem: String);
var
   vloTexto:TStringList;
   vlsCaminhoTXT: String;
begin
vloTexto := TStringList.Create;
try
   vlsCaminhoTXT := 'C:\Servicos\LogsTxt\'+FormatDateTime('ddmmyyyy',Date)+'.txt';

   if not DirectoryExists('C:\Servicos\LogsTxt\') then
      ForceDirectories('C:\Servicos\LogsTxt\');

   if FileExists(vlsCaminhoTXT) then
      vloTexto.LoadFromFile(vlsCaminhoTXT);

   vloTexto.Add(DateToStr(Date)+' '+TimeToStr(Time) +' - '+ psMensagem);
   vloTexto.SaveToFile(vlsCaminhoTXT);

finally
   vloTexto.Free;
   end;
end;

procedure TFPrincipal.ServiceAfterInstall(Sender: TService);
var
  regEdit : TRegistry;
begin
regEdit := TRegistry.Create(KEY_READ or KEY_WRITE);
  try
    regEdit.RootKey := HKEY_LOCAL_MACHINE;

    if regEdit.OpenKey('\SYSTEM\CurrentControlSet\Services\' + Name,False) then
    begin
      regEdit.WriteString('Description','Serviço para desligar automaticamente o computador em horário definido');
      regEdit.CloseKey;
    end;

  finally
    FreeAndNil(regEdit);
  end;
end;

procedure TFPrincipal.ServiceBeforeUninstall(Sender: TService);
begin
TimerDesligar.Enabled := False;
end;

procedure TFPrincipal.ServiceStart(Sender: TService; var Started: Boolean);
var
  vloIni: TIniFile;
begin
gravarLogTXT('Serviço iniciado com sucesso!');
try
if FileExists('C:\Servicos\Config.Ini') then
   begin
   vloIni := TIniFile.Create('C:\Servicos\Config.Ini');
   vlsHoraConfigurada := vloIni.ReadString('Config', 'Hora Desligamento', '18:20');
   end
else
   begin
   vloIni := TIniFile.Create('C:\Servicos\Config.Ini');
   vlsHoraConfigurada := '18:20';
   vloIni.WriteString('Config', 'Hora Desligamento', vlsHoraConfigurada);
   end;

finally
   if Assigned(vloIni) then
      FreeAndNil(vloIni);
   end;

TimerDesligar.Interval := 60000;

if (vlsHoraConfigurada) <> '' then
   TimerDesligar.Enabled  := True;
end;

procedure TFPrincipal.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
gravarLogTXT('Serviço parado com sucesso!');
TimerDesligar.Enabled := False;
end;

procedure TFPrincipal.TimerDesligarTimer(Sender: TObject);
begin
if (vlsHoraConfigurada) <> '' then
   BEGIN
   if FormatDateTime('HH:MM', StrToTime(vlsHoraConfigurada)) <=
      FormatDateTime('HH:MM', Now) then
      begin
      TimerDesligar.Enabled := False;
      WinExec('cmd /c shutdown -s -t 60',SW_NORMAL);
      end;
   END;
end;

end.
