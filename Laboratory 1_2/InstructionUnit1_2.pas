unit InstructionUnit1_2;

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
    Info.Caption := '1. Введите первое число Натуральное число n ( 0 < n < 60).' + #13#10 +
                    '2. Нажмите на кнопку расчитать, чтобы получить сумму.' + #13#10 +
                    'Примечание: Если используете файл, то он должен быть в формате '+
                    #39 + '.txt' + #39  + #46 + #13#10;
end;

end.
