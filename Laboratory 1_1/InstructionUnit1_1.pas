unit InstructionUnit1_1;

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
    Info.Caption := '1. Введите первое число N (0 < N < 10^9).' + #13#10 +
                    '2. Введите второе число M (0 < M < 10^9).' + #13#10 +
                    '3. Нажмите на кнопку расчитать, чтобы получить ответ.' + #13#10 +
                    'Примечание: Если используете файл, то он должен быть в формате '+
                    #39 + '.txt' + #39  + #46 + #13#10;
end;


end.
