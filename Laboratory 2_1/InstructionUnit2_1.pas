Unit InstructionUnit2_1;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

Type
    TInstructionForm = Class(TForm)
        Info: TLabel;
        Procedure FormCreate(Sender: TObject);
    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Var
    InstructionForm: TInstructionForm;

Implementation

{$R *.dfm}

Procedure TInstructionForm.FormCreate(Sender: TObject);
Begin
    Info.Caption :=
        '1. Введите количество треугольников (0 < кол. треугольников < 100).' + #13#10 +
        '2. Нажмите кнопку ''подтвердить'' после того, как введёте кол. треугольников.' + #13#10 +
        '3. Введите каждую сторону треугольника ( 0 < сторона треугольника < 10^5)' +#13#10 +
        '    в соответствующую ячейку.' + #13#10 +
        '4. Нажмите кнопку ''найти треугольник'', чтобы программа нашла'+ #13#10 +
        '    треугольник максимальной площадью.' + #13#10 +
        'Примечание: Если используете файл, то он должен быть в формате ''.txt''.';
End;

End.
