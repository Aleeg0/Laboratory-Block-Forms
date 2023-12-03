Unit OutputAnswerUnit1_3;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids;

Type
    TOutputAnswerUnit = Class(TForm)
        StepsOfCalculations: TStringGrid;
        Procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Var
    OutputAnswerUnit: TOutputAnswerUnit;

Implementation

{$R *.dfm}

Uses BackendUnit1_3;

procedure TOutputAnswerUnit.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
    self.Close;
end;

Procedure TOutputAnswerUnit.FormCreate(Sender: TObject);
Var
    Size: Integer;
    I: Integer;
    TempStr: String;
    ArrayOfSteps: TDoubleArrayOfReal;
Begin
    Size := Equation.GetSteps();
    ArrayOfSteps := Equation.GetArrayOfSteps();
    StepsOfCalculations.ColCount := 3;
    StepsOfCalculations.RowCount := Size + 1;
    StepsOfCalculations.FixedCols := 1;
    StepsofCalculations.FixedRows := 1;
    StepsOfCalculations.Cells[0, 0] := 'иру';
    StepsOfCalculations.Cells[1, 0] := 'X - 1';
    StepsOfCalculations.Cells[2, 0] := 'X';
    For I := 1 To Size Do
    Begin
        TempStr := '';
        StepsOfCalculations.Cells[0, I] := IntToStr(I);
        Str(ArrayOFSteps[0, I - 1]: 11: 5, TempStr);
        StepsOfCalculations.Cells[1, I] := TempStr;
        TempStr := '';
        Str(ArrayOFSteps[1, I - 1]: 11: 5, TempStr);
        StepsOfCalculations.Cells[2, I] := TempStr;
    End;
End;
End.
