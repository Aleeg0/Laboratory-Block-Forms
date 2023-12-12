unit InstructionUnit3_3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TInstruction = class(TForm)
    Info: TLabel;
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Instruction: TInstruction;

implementation

{$R *.dfm}



procedure TInstruction.FormCreate(Sender: TObject);
begin
    Info.Caption :=
        '1. Введите строку состоящую из букв, цифр и символов.' + #13#10 +
        '2. Нажмите кнопку ''создать множество'', чтобы программа нашла'+ #13#10 +
        '    смиволы в данной строке.' + #13#10 +
        'Примечания: ' + #13#10 +
        '1) Программа находит символы арифметических операций, скобки и' + #13#10 +
        '     чётные цифры.' + #13#10 +
        '2) Если используете файл, то он должен быть в формате ''.txt''.';
end;

end.
