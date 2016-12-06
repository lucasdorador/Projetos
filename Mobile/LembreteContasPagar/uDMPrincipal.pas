unit uDMPrincipal;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, Data.DB, FireDAC.Comp.Client,
  FireDAC.Comp.DataSet, System.IOUtils, FireDAC.FMXUI.Wait, FireDAC.Comp.UI;

type
  TDMPrincipal = class(TDataModule)
    FDConnection1: TFDConnection;
    FDUsuario: TFDQuery;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDUsuarioUsua_Codigo: TFDAutoIncField;
    FDUsuarioUsua_Nome: TWideStringField;
    FDUsuarioUsua_Email: TWideStringField;
    FDUsuarioUsua_Imagem: TBlobField;
    FDUsuarioUsua_Senha: TWideStringField;
    procedure FDConnection1BeforeConnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMPrincipal: TDMPrincipal;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure TDMPrincipal.FDConnection1BeforeConnect(Sender: TObject);
var
   sPath : String;
begin
FDConnection1.Connected := False;
   {$IF DEFINED (ANDROID)}
   FDConnection1.Params.Values['DriverID'] := 'SQLite';
   try
   sPath := TPath.Combine(TPath.GetSharedDocumentsPath, 'LembreteContas.db');
   FDConnection1.Params.Values['Database'] := Trim(sPath);
      except on E: Exception do
         begin
         raise Exception.Create('Erro de conexão com o banco de dados!');
         end;
   {$ENDIF}

   {$IFDEF MSWINDOWS}
   try
   FDConnection1.Params.Values['Database'] := 'F:\Programação\Delphi\XE8\Android\LembreteContasPagar\Banco de Dados\LembreteContas.db';
      except on E: Exception do
         begin
         raise Exception.Create('Erro de conexão com o banco de dados!');
         end;
   {$ENDIF}
   end;
end;

end.
