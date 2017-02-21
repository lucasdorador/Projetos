unit UFuncoesServer;

interface

uses FireDAC.Comp.Client, System.SysUtils, Data.DB, System.Classes, Vcl.Forms,
 Windows, IDStackWindows;

type
   TFuncoesServer = class
  private

   public
      class Function NomeComputadorTXT: String;
      class function PegaUsuarioWindows: string;
      class function IIf(Expressao: Variant; ParteTRUE, ParteFALSE: Variant): Variant;
      class function getIP : String;
   end;

implementation

class function TFuncoesServer.getIP: String;
var
  IdStackWin: TIdStackWindows;
  //vlResult : TStrings;
begin
try
IdStackWin := TIdStackWindows.Create;
//vlResult := TStrings.Create;
try
Result := IdStackWin.LocalAddresses.Text;
//Result := vlResult.Text;
finally
   IdStackWin.Free;
   end;
Except
  on e :exception do
     result := e.Message;
   end;
end;

class function TFuncoesServer.IIf(Expressao, ParteTRUE,
  ParteFALSE: Variant): Variant;
begin
if Expressao then
   Result := ParteTRUE
else
   Result := ParteFALSE;
end;

class Function TFuncoesServer.NomeComputadorTXT: String;
var
ARQTXT: TextFile;
Texto: String;
TAMANHOVAR: Integer;
begin
If FileExists(ExtractFilePath(Application.ExeName)+'CONFLPT.TXT') then
   begin
   ASSIGNFILE(ARQTXT,'CONFLPT.TXT');
   RESET(ARQTXT);
   WHILE NOT EOF(ARQTXT) DO
      BEGIN
      TEXTO:='';
      READLN(ARQTXT,TEXTO);
      IF COPY(TEXTO,1,15)='NOMECOMPUTADOR=' THEN
         BEGIN
         TEXTO:=TRIM(TEXTO);
         TAMANHOVAR:=(LENGTH(TEXTO)-15);
         Result:=COPY(TEXTO,16,TAMANHOVAR);
         Break;
         END;
      END;
   CLOSEFILE(ARQTXT);
   end
else
   Result := '';
end;

class Function TFuncoesServer.PegaUsuarioWindows: string;
Var
   PegaUsuarioWindows: DWord;
Begin
PegaUsuarioWindows := 50;
SetLength(Result, PegaUsuarioWindows);
GetUserName(pChar(Result), PegaUsuarioWindows);
SetLength(Result, StrLen(pChar(Result)));
End;

end.
