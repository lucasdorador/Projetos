unit uFuncoes;

interface

uses
  System.SysUtils, Vcl.Dialogs;

type
   TFuncoesData = class(TObject)
   public
      class procedure pcdValidaData(psData: string);
      class function fncDiaSemana(Data: TDateTime): String;
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

class function TFuncoesData.fncDiaSemana(Data:TDateTime): String;
var
  NoDia : Integer;
  DiaDaSemana : array [1..7] of String[13];
begin
Result          := '';
DiaDasemana [1] := 'Dom';
DiaDasemana [2] := 'Seg';
DiaDasemana [3] := 'Ter';
DiaDasemana [4] := 'Qua';
DiaDasemana [5] := 'Qui';
DiaDasemana [6] := 'Sex';
DiaDasemana [7] := 'Sab';
NoDia           := DayOfWeek(Data);
Result          := DiaDasemana[NoDia];
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
