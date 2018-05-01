program CarregaBPL;

uses
  Vcl.Forms,
  uCarregaBPL in 'uCarregaBPL.pas' {FCarregaBPL};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFCarregaBPL, FCarregaBPL);
  Application.Run;
end.
