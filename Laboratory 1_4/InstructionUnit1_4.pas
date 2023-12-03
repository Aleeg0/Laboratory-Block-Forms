unit InstructionUnit1_4;

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
    Info.Caption := '1. ������� ���������� ��������� ������� a (0 < size < 999).' + #13#10 +
                    '2. ������� ������ ����������� ����� ����, ��� ������ size.' + #13#10 +
                    '3. ������� ������ ������� ������� � ��������������� ������.' + #13#10 +
                    '3. ������� ������ ''������� ������ b'', ����� ��������� ����� X.' + #13#10+
                    '4. ������� ������ ''���������� ������ b'', ����� ������� ��������� �������.' + #13#10+
                    '����������: ���� ����������� ����, �� �� ������ ���� � ������� ''.txt''.';
end;

end.
