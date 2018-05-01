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
   //criação classse de função que está na bpl. Esta função deve existir na BPL com esta exata descriçao
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
   ShowMessage('BPL: ' + vgNomeBPL + ' não localizada no diretório "' + ExtractFilePath(vBPL) + '", copie ela para o diretório indicado ou entre em contato com a TDP Sistemas de Informação!');
   Abort;
   end;

vlHandle:=LoadPackage(vBPL); //lendo bpl e capturando o identificador numérico único desta bpl, criado pelo windows
if vlHandle > 0 then // se variável maior que zero, bpl encontrada
   begin
   @fncExecutaBPL                       := GetProcAddress(vlHandle, 'fncExecutaBPL'); //recupera o endereço de funções exportadas, no caso a função fncExecutaBPL que está na bpl
   if Assigned(fncExecutaBPL) then //valida de existe função
      begin
      Try
      vlRetorno := fncExecutaBPL(vgEmpresa,    //Empresa Logada
                                 vgUsuario,    //Usuário
                                 vgAlias,      //Alias
                                 vgCaminhoExe); // Caminho do aplicativo
      Except
         //ShowMessage('Função de chamada da BPL (fncExecutaBPL) não encontrada na BPL '+vlNameBPL+' !');
         on E:Exception do
            begin
            if e.ClassName <> 'EAbort' then
               ShowMessage('Ocorreu o seguinte erro '+#13+e.Message+#13+'na função (fncExecutaBPL) da BPL '+vlNameBPL+' !');
            end;
         End;
      end
   else
      begin
      ShowMessage('Função fncExecutaBPL_Parametros não encontrada na BPL '+vlNameBPL+' !');
      end;
   end
else
   begin
   ShowMessage('BPL: ' + vBPL + ' não encontrada no diretório, por favor verifique!');
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
