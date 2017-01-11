unit uProcessamento;

interface

uses
   FireDAC.Comp.Client, SysUtils, Vcl.Forms, Windows, Vcl.Controls, Data.DB,
   System.Classes, Vcl.CheckLst, UFuncoesFaciliteXE8, uConstantes;

type TProcessamento = class
   public
      class function fncProcessaTrimestre(piTrimestre: Integer; psAno: String; const poConexao: TFDConnection) : Boolean;

end;

implementation

class function TProcessamento.fncProcessaTrimestre(piTrimestre: Integer; psAno: String;
                                                   const poConexao: TFDConnection) : Boolean;
begin



end;

end.
