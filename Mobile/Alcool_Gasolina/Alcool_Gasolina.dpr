program Alcool_Gasolina;

uses
  System.StartUpCopy,
  FMX.Forms,
  UPrincipal in 'UPrincipal.pas' {Fprincipal},
  UDMPrincipal in 'UDMPrincipal.pas' {DMPrincipal: TDataModule},
  UHistorico in 'UHistorico.pas' {FHistorico};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFprincipal, Fprincipal);
  Application.CreateForm(TDMPrincipal, DMPrincipal);
  Application.CreateForm(TFHistorico, FHistorico);
  Application.Run;
end.
