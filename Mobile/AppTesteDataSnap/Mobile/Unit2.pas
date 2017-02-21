unit Unit2;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit;

type
  TForm2 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}

uses ClientClassesUnit1, ClientModuleUnit1;

procedure TForm2.Button1Click(Sender: TObject);
var
   vloClient : TServerMethods1Client;
begin
vloClient := TServerMethods1Client.Create(ClientModule1.DSRestConnection1);
try
ShowMessage(vloClient.ReverseString(Edit1.Text));
finally
   FreeAndNil(vloClient);
   end;
end;

end.
