unit InstructionUnit2_2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TInstructionForm = class(TForm)
    Info: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  InstructionForm: TInstructionForm;

implementation

{$R *.dfm}

procedure TInstructionForm.FormCreate(Sender: TObject);
begin
    Info.Caption :=
        '1. Введите K (Натуральное число от 1 до 10^7 - 1).' + #13#10 +
        '2. Нажмите кнопку ''найти натуральные числа'' после того, как введёте K.' + #13#10 +
        'Примечание: Если используете файл, то он должен быть в формате ''.txt''.';
end;

end.
