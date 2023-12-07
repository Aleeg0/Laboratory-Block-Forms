unit AboutTheDeveloperUnit2_2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TAboutTheDeveloperForm = class(TForm)
    Info: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AboutTheDeveloperForm: TAboutTheDeveloperForm;

implementation

{$R *.dfm}

end.
