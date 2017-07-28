program prjDesligarPC;

uses
  Vcl.Forms,
  uDesligarPC in 'uDesligarPC.pas' {FDesligarPC};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFDesligarPC, FDesligarPC);
  Application.Run;
end.
