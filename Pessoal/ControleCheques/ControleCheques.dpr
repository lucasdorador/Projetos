program ControleCheques;

uses
  Vcl.Forms,
  uControleCheques in 'uControleCheques.pas' {FControleCheques};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFControleCheques, FControleCheques);
  Application.Run;
end.
