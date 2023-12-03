unit InstructionUnit1_3;

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
    Info.Caption := '1. Уберите галочку, если хотите ввести свой eps > 0.' + #13#10 +
                    '1a. Если убрали галочку, введите эпсилон.' + #13#10 +
                    '2. Введите X (0 < X < 10^6).' + #13#10 +
                    '3. Нажмите кнопку ' + #39 + 'Расчитать' + #39 + ', чтобы программа нашла X.' + #13#10+
                    '4. Нажмите кнопку ' + #39 + 'Посмотреть ответ' + #39 + ', чтобы увидеть пошаговое решение.' + #13#10+
                    'Примечание: Если используете файл, то он должен быть в формате ' +
                    #39 + '.txt' + #39 + #46 + #13#10 +
                    'Так же для корректного подсчета в тексте данные должны быть в таком порядке "X eps".' + #13#10 +
                    'Например: 10 0.001' + #13#10 +
                    'Но если вы используете eps по умолчанию, то в файл пишется только X.' + #13#10 +
                    'Например: 5' + #13#10;
end;

end.
