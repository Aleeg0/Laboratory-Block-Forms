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
        '1. Введите количество элементов массива (целое число > 0)' + #13#10 +
        '2. Нажмите кнопку ''подтвердить'', чтобы подтвердить размер массива.' + #13#10 +
        '3. Введите элементы массива (целые числа от -10^5 до 10^5).' + #13#10 +
        '4. Нажмите кнопку ''отсортировать массив'', чтобы отсортировать свой массив.' + #13#10 +
        '5. Нажмите кнопку ''посмотреть отсортированный массив'',' + #13#10 +
        '     чтобы увидеть отсортированный массив ' + #13#10 +
        'Примечания: ' + #13#10 +
        'Если используете файл, то он должен быть в формате ''.txt''.';
end;

end.
