unit InstructionUnit2_3;

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
        '1. Введите размер квадратной матрицы (от 2 до 100).' + #13#10 +
        '2. Нажмите кнопку ''подтвердить'' после того, как введёте размер матрицы.' + #13#10 +
        '3. Введите каждый элемент матрицы ( -10^5 < элемент матрицы < 10^5)' +#13#10 +
        '    в соответствующую ячейку.' + #13#10 +
        '4. Нажмите кнопку ''найти наибольшую сумму'', чтобы программа нашла'+ #13#10 +
        '    треугольник наибольшую суммую.' + #13#10 +
        'Примечание: Если используете файл, то он должен быть в формате ''.txt''.';
end;

end.
