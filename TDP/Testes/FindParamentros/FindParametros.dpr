program FindParametros;

uses
  Vcl.Forms,
  uFindParametros in 'Forms\uFindParametros.pas' {FFindParametros},
  uProcessa in 'Forms\uProcessa.pas' {FProcessa},
  uMemoParametros in 'Forms\uMemoParametros.pas' {FMemoParametros};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFFindParametros, FFindParametros);
  Application.CreateForm(TFProcessa, FProcessa);
  Application.CreateForm(TFMemoParametros, FMemoParametros);
  Application.Run;
end.
