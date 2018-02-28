unit uFuncoes;

interface

uses
  System.Types, Winapi.Windows, Vcl.Dialogs, IniFiles, Grids, DBGrids,
  uDMServer, IdStackWindows, System.SysUtils, Vcl.Forms,
  FireDAC.Comp.Client, FireDAC.Phys.IBWrapper;

Type TConfigINI = record
   psCaminhoDB : String;
   psPorta     : String;
end;

Type TFuncoes = class(TObject)
  private
     class var FPorta, FConexaoBD: String;
     class function fncRecuperaNomeComputador: String;
     class function fncRecuperaNomedoUsuario: String;

  public
     class procedure pcdCarregaInformacoes;
     class procedure GravaIni(psCaminhoBD, psPorta: string);
     class function LerConfigIni: TConfigINI;
     class procedure AutoSizeDBGrid(const xDBGrid: TDBGrid);
     class function getIP: String;
end;


implementation

{ TFuncoes }


class function TFuncoes.fncRecuperaNomeComputador: String;
var
   Computer: PChar;
   CSize: DWORD;
   vlResult: String;
begin
Computer := #0;
CSize    := MAX_COMPUTERNAME_LENGTH + 1;
try
GetMem(Computer,CSize);

if GetComputerName(Computer,CSize ) then
   vlResult := Computer;

finally
   Result := vlResult;
   FreeMem(Computer);
   end;
end;

class function TFuncoes.getIP: String;
var
  IdStackWin: TIdStackWindows;
begin
try
IdStackWin := TIdStackWindows.Create;
try
Result := IdStackWin.LocalAddresses.Text;
finally
   IdStackWin.Free;
   end;
Except
  on e :exception do
     result := e.Message;
   end;
end;

class function TFuncoes.fncRecuperaNomedoUsuario: String;
var
   Computer: PChar;
   CSize: DWORD;
   vlResult: String;
begin
Computer := #0;
CSize    := MAX_COMPUTERNAME_LENGTH + 1;
try
GetMem(Computer,CSize);

if GetUserName(Computer,CSize ) then
   vlResult := Computer;

finally
   Result := vlResult;
   FreeMem(Computer);
   end;
end;

class procedure TFuncoes.pcdCarregaInformacoes;
begin
DMServer.FDInformacoes.Close;
DMServer.FDInformacoes.Open;

DMServer.FDInformacoes.Append;
DMServer.FDInformacoesInformacao.AsString := 'Nome do Computador: ';
DMServer.FDInformacoesValor.AsString      := fncRecuperaNomeComputador;
DMServer.FDInformacoes.Post;

DMServer.FDInformacoes.Append;
DMServer.FDInformacoesInformacao.AsString := 'Nome do Usuário: ';
DMServer.FDInformacoesValor.AsString      := fncRecuperaNomedoUsuario;
DMServer.FDInformacoes.Post;

DMServer.FDInformacoes.Append;
DMServer.FDInformacoesInformacao.AsString := 'Porta Configurada: ';
DMServer.FDInformacoesValor.AsString      := FPorta;
DMServer.FDInformacoes.Post;

DMServer.FDInformacoes.Append;
DMServer.FDInformacoesInformacao.AsString := 'Caminho do Banco: ';
DMServer.FDInformacoesValor.AsString      := FConexaoBD;
DMServer.FDInformacoes.Post;

DMServer.FDInformacoes.Append;
DMServer.FDInformacoesInformacao.AsString := 'Banco de Dados: ';
if DMServer.FDConexao.Connected then
   DMServer.FDInformacoesValor.AsString   := 'Conectado'
else
   DMServer.FDInformacoesValor.AsString   := 'Desconectado';
DMServer.FDInformacoes.Post;
end;

class procedure TFuncoes.GravaIni(psCaminhoBD, psPorta: string);
var
  ArqIni: TIniFile;
begin
ArqIni := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'ConfigServer.ini');
try
ArqIni.WriteString('Config', 'CaminhoBD', psCaminhoBD);
ArqIni.WriteString('Config', 'Porta', psPorta);
finally
   ArqIni.Free;
   end;
end;

class function TFuncoes.LerConfigIni: TConfigINI;
var
  ArqIni: TIniFile;
  voConfigINI : TConfigINI;
begin
ArqIni := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'ConfigServer.ini');
try
voConfigINI.psCaminhoDB := ArqIni.ReadString('Config', 'CaminhoBD', '');
voConfigINI.psPorta     := ArqIni.ReadString('Config', 'Porta', '');

FPorta     := voConfigINI.psPorta;
FConexaoBD := voConfigINI.psCaminhoDB;

finally
   ArqIni.Free;
   Result := voConfigINI;
   end;
end;

class procedure TFuncoes.AutoSizeDBGrid(const xDBGrid: TDBGrid);
var
  I, TotalWidht, VarWidth, QtdTotalColuna : Integer;
  xColumn : TColumn;
begin
// Largura total de todas as colunas antes de redimensionar
TotalWidht := 0;
// Como dividir todo o espaço extra na grade
VarWidth := 0;
// Quantas colunas devem ser auto-redimensionamento
QtdTotalColuna := 0;

for I := 0 to -1 + xDBGrid.Columns.Count do
   begin
   TotalWidht := TotalWidht + xDBGrid.Columns[I].Width;
   if xDBGrid.Columns[I].Field.Tag <> 0 then
      Inc(QtdTotalColuna);
   end;

// Adiciona 1px para a linha de separador de coluna
if dgColLines in xDBGrid.Options then
   TotalWidht := TotalWidht + xDBGrid.Columns.Count;

// Adiciona a largura da coluna indicadora
if dgIndicator in xDBGrid.Options then
   TotalWidht := TotalWidht + IndicatorWidth;

// width vale "Left"
VarWidth :=  xDBGrid.ClientWidth - TotalWidht;

// Da mesma forma distribuir VarWidth para todas as colunas auto-resizable
if QtdTotalColuna > 0 then
   VarWidth := varWidth div QtdTotalColuna;

for I := 0 to -1 + xDBGrid.Columns.Count do
   begin
   xColumn := xDBGrid.Columns[I];
   if xColumn.Field.Tag <> 0 then
      begin
      xColumn.Width := xColumn.Width + VarWidth;
      if xColumn.Width < xColumn.Field.Tag then
         xColumn.Width := xColumn.Field.Tag;
      end;
   end;
end;


end.
