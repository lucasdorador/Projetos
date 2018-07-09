unit uFuncoes;

interface

uses
  System.SysUtils, Vcl.Dialogs;

type
   TFuncoesData = class(TObject)
   public
      class procedure pcdValidaData(psData: string);
   end;

   TFuncoesHora = class(TObject)
      class procedure pcdValidaHora(psHora: string);
   end;

implementation

{ TFuncoesData }

class procedure TFuncoesData.pcdValidaData(psData: string);
begin
try
StrToDate(psData);
except
   ShowMessage('Data inválida, verifique!');
   Abort;
   end;
end;

{ TFuncoesHora }

class procedure TFuncoesHora.pcdValidaHora(psHora: string);
begin
try
StrToTime(psHora);
except
   ShowMessage('Hora inválida, verifique!');
   Abort;
   end;
end;

end.
