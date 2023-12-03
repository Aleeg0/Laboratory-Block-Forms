Unit BackendUnit1_3;

Interface

Type
    TDoubleArrayOfReal = Array Of Array Of Real;

Type
    TEquation = Class
    Private
        XLast: Real;
        X: Real;
        Eps: Real;
        Answer: Real;
        CountOfSteps: Integer;
        ArrayOfSteps: TDoubleArrayOfReal;
    Public
        Constructor Create();
        Procedure SetParametersOfEquation(XLast, Eps: Real);
        Procedure SolveTheEquation();
        Function GetArrayOfSteps(): TDoubleArrayOfReal;
        Function GetSteps(): Integer;
        Function GetAnswer(): Real;
        Function IsEquationSolvable(): Boolean;
    End;

Var
    Equation: TEquation;

Implementation

{ TEquation }

Uses OutputAnswerUnit1_3, System.SysUtils;

Constructor TEquation.Create();
Begin
    CountOfSteps := 0;
    X := 0;
    Eps := 0;
    Xlast := 0;
End;

Function TEquation.GetAnswer: Real;
Begin
    GetAnswer := Answer;
End;

Function TEquation.GetArrayOfSteps: TDoubleArrayOfReal;
Begin
    GetArrayOfSteps := ArrayOfSteps;
End;

Function TEquation.GetSteps(): Integer;
Var
    I: Integer;
    Size: Integer;
Begin
    GetSteps := CountOfSteps;
End;

Function TEquation.IsEquationSolvable(): Boolean;
Begin
    If XLast = 0 Then
        IsEquationSolvable := False
    Else
    Begin
        If 100 / (859 * XLast) > 1 Then
            IsEquationSolvable := False
        Else
            IsEquationSolvable := True;
    End;
End;

Procedure TEquation.SetParametersOfEquation(XLast, Eps: Real);
Begin
    Self.XLast := XLast;
    Self.Eps := Eps;
End;

Procedure TEquation.SolveTheEquation;
Var
    IsFinded: Boolean;
    XLastCopy: Real;
    I: Integer;
Begin
    CountOfSteps := 0;
    XLastCopy := XLast;
    IsFinded := False;
    While IsFinded = False Do
    Begin
        X := (Ln(7.662 * XLast) + 5) / 8.59;
        If Abs(X - XLast) < Eps Then
            IsFinded := True
        Else
            XLast := X;
        Inc(CountOfSteps);
    End;
    // writting answer
    Xlast := XLastCopy;
    SetLength(ArrayOfSteps, 2, CountOfSteps);
    For I := 1 To CountOfSteps Do
    Begin
        ArrayOfSteps[0][I - 1] := Xlast;
        ArrayOfSteps[1][I - 1] := (Ln(7.662 * XLast) + 5) / 8.59;
        XLast := X;
    End;
    Answer := ArrayOfSteps[0][CountOfSteps - 1];
End;

End.
