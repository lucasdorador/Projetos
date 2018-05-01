unit uCarregaBPL;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.IniFiles;

type
  TFCarregaBPL = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    vgEmpresa, vgUsuario, vgAlias, vgCaminhoExe, vgNomeBPL : String;
    procedure CarregaBPL(vBPL: String);
    function fncGetOnlyNameBPL(vCaminho: String): String;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FCarregaBPL: TFCarregaBPL;

implementation

{$R *.dfm}

procedure TFCarregaBPL.CarregaBPL(vBPL: String);
type
   //cria��o classse de fun��o que est� na bpl. Esta fun��o deve existir na BPL com esta exata descri�ao
   TfncExecutaBPL = function (vEmpresa, vUsuario, vAlias, vCaminhoExe : String): String; stdcall;
var
   vlHandle: THandle;
   fncExecutaBPL: TfncExecutaBPL;
   vlRetorno: String;
   VlBRetorno:Boolean;
   vlNameBPL: String;
begin
vlRetorno := '';
vlNameBPL := fncGetOnlyNameBPL(vBPL);

if not FileExists(vBPL) then
   begin
   ShowMessage('BPL: ' + vgNomeBPL + ' n�o localizada no diret�rio "' + ExtractFilePath(vBPL) + '", copie ela para o diret�rio indicado ou entre em contato com a TDP Sistemas de Informa��o!');
   Abort;
   end;

vlHandle:=LoadPackage(vBPL); //lendo bpl e capturando o identificador num�rico �nico desta bpl, criado pelo windows
if vlHandle > 0 then // se vari�vel maior que zero, bpl encontrada
   begin
   @fncExecutaBPL                       := GetProcAddress(vlHandle, 'fncExecutaBPL'); //recupera o endere�o de fun��es exportadas, no caso a fun��o fncExecutaBPL que est� na bpl
   if Assigned(fncExecutaBPL) then //valida de existe fun��o
      begin
      Try
      vlRetorno := fncExecutaBPL(vgEmpresa,    //Empresa Logada
                                 vgUsuario,    //Usu�rio
                                 vgAlias,      //Alias
                                 vgCaminhoExe); // Caminho do aplicativo
      Except
         //ShowMessage('Fun��o de chamada da BPL (fncExecutaBPL) n�o encontrada na BPL '+vlNameBPL+' !');
         on E:Exception do
            begin
            if e.ClassName <> 'EAbort' then
               ShowMessage('Ocorreu o seguinte erro '+#13+e.Message+#13+'na fun��o (fncExecutaBPL) da BPL '+vlNameBPL+' !');
            end;
         End;
      end
   else
      begin
      ShowMessage('Fun��o fncExecutaBPL_Parametros n�o encontrada na BPL '+vlNameBPL+' !');
      end;
   end
else
   begin
   ShowMessage('BPL: ' + vBPL + ' n�o encontrada no diret�rio, por favor verifique!');
   end;
end;

function TFCarregaBPL.fncGetOnlyNameBPL(vCaminho: String): String;
var
i,vTot : Integer;
TextoFinal : String;

begin
TextoFinal := '';
For i := Length(vCaminho) downto 1  do
   begin
   if Copy(vCaminho,i,1) <> '\' then
      TextoFinal:=Copy(vCaminho,i,1) + TextoFinal
   else
      Break;
   end;
Result := TextoFinal;
end;

procedure TFCarregaBPL.FormCreate(Sender: TObject);
var
  ArqIni: TIniFile;
begin
Try
ArqIni := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'CarregaBPL.ini');
   try
      Try
      vgEmpresa       := ArqIni.ReadString('DADOS BPL', 'Empresa', '');
      vgUsuario       := ArqIni.ReadString('DADOS BPL', 'Usuario', '');
      vgAlias         := ArqIni.ReadString('DADOS BPL', 'Alias', '');
      vgCaminhoExe    := ArqIni.ReadString('DADOS BPL', 'CaminhoExe', '');
      vgNomeBPL       := ArqIni.ReadString('DADOS BPL', 'NomedaBPL', '');
      Except
         end;
   finally
      ArqIni.Free;
      end;
except
   on E:Exception do
      begin
      ShowMessage('Houve um erro para encontar o arquivo CarregaBPL.ini com a seguinte mensagem: ' + e.Message);
      end;
   end;
end;

procedure TFCarregaBPL.FormShow(Sender: TObject);
begin
try
try
   if Trim(vgCaminhoExe) = '' then
      vgCaminhoExe := ExtractFilePath(Application.ExeName);

   CarregaBPL(vgCaminhoExe + 'Bpl\' + vgNomeBPL);
except
   on E:Exception do
      begin
      if e.ClassName <> 'EAbort' then
         ShowMessage('Houve um erro para abrir a bpl ' + vgNomeBPL + ' com a seguinte mensagem: ' + e.Message + ' na classe: ' +e.ClassName);
      end;
   end;
finally
   Application.Terminate;
   end;
end;

end.
