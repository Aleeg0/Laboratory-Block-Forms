unit AboutTheDeveloperUnit1_3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TAboutTheDeveloper = class(TForm)
    Info: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AboutTheDeveloper: TAboutTheDeveloper;

implementation

{$R *.dfm}

end.
