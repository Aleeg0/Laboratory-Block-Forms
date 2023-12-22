Unit BackendUnit2_4;

Interface

Uses System.SysUtils;

Type
    TMatrix = Array Of Array Of Integer;

    TSumSearcher = Class
    Private
        Matrix: TMatrix;
        Size: Integer;
        Sum: Integer;
    Public
        Constructor Create(Size: Integer);
        Procedure SetElemtentOfMatrix(Number, I, J: Integer);
        Procedure FindSum();
        Function GetSum(): Integer;
    End;

    TFileReader = Class
    Private
        FileName: String;
        InFile: TextFile;
        Status: Boolean;
        Function IsFileTxt(): Boolean;
        Function IsFileReadable(): Boolean;
    Public
        Function GetStatus(): Boolean;
        Procedure SetFileName(FileName: String);
        Function InputOrderOfMatrix(): Integer;
        Function InputElementsOfMatrix(Const OrderOfMatrix: Integer): TMatrix;
        Function IsFileGood(): Boolean;
    End;

    TFileWriter = Class
    Private
        OutFile: TextFile;
        FileName: String;
        Status: Boolean;
        Function IsFileTxt(): Boolean;
        Function IsFileWritable(): Boolean;
    Public
        Procedure SetFileName(FileName: String);
        Function GetStatus(): Boolean;
        Procedure OutputSum(BestSum : Integer);
        Function IsFileGood(): Boolean;
    End;

Var
    SumSearcher: TSumSearcher;

Implementation

{ TFIndBestSum }

Constructor TSumSearcher.Create(Size: Integer);
Begin
    Self.Size := Size;
    SetLength(Matrix, Self.Size, Self.Size);
End;

Procedure TSumSearcher.FindSum();
Var
    I: Integer;
    J: Integer;
    K: Integer;
    Center: Integer;
    Step: Integer;
Begin
    I := 0;
    J := 0;
    Sum := 0;
    Center := Size Div 2;
    Step := Size;
    While (I < Center) Do
    Begin
        J := I;
        For K := 1 To Step Do
        Begin
            Sum := Sum + Matrix[I][J];
            Inc(J);
        End;
        Inc(I);
        Step := Step - 2;
    End;
    If Step = -1 Then
        Step := Step + 2;
    While (I < Size) Do
    Begin
        J := Size - I - 1;
        For K := 1 To Step Do
        Begin
            Sum := Sum + Matrix[I][J];
            Inc(J);
        End;
        Inc(I);
        Step := Step + 2;
    End;
End;

Function TSumSearcher.GetSum(): Integer;
Begin
    GetSum := Sum;
End;

Procedure TSumSearcher.SetElemtentOfMatrix(Number, I, J: Integer);
Begin
    Matrix[I][J] := Number;
End;

{ TFileReader }

Function TFileReader.GetStatus: Boolean;
Begin
    GetStatus := Status;
End;

Function TFileReader.InputElementsOfMatrix(Const OrderOfMatrix
    : Integer): TMatrix;
Const
    MIN_NUMBER: Integer = -9999;
    MAX_NUMBER: Integer = 9999;
Var
    IsCorrect: Boolean;
    Element, I, J: Integer;
    Matrix: TMatrix;
Begin
    SetLength(Matrix, OrderOfMatrix, OrderOfMatrix);
    IsCorrect := False;
    Reset(InFile);
    Read(InFile, Matrix[0][0]);
    For I := 1 To OrderOfMatrix Do
    Begin
        For J := 1 To OrderOfMatrix Do
        Begin
            If Status Then
            Begin
                Try
                    Read(InFile, Element);
                Except
                    Status := False;
                End;
                If Status And
                    ((Element < MIN_NUMBER) Or (MAX_NUMBER < Element)) Then
                    Status := False
                Else If Status Then
                    Matrix[I - 1, J - 1] := Element;
            End;
        End;
    End;
    CloseFile(InFile);
    InputElementsOfMatrix := Matrix;
End;

Function TFileReader.InputOrderOfMatrix: Integer;
Const
    MIN_SIZE: Integer = 3;
    MAX_SIZE: Integer = 99;
Var
    OrderOfMatrix: Integer;
Begin
    OrderOfMatrix := 0;
    Reset(InFile);
    Try
        Read(InFile, OrderOfMatrix);
    Except
        Status := False;
    End;
    If (OrderOfMatrix < MIN_SIZE) Or (MAX_SIZE < OrderOfMatrix) Then
    Begin
        Status := False;
    End;
    CloseFile(InFile);
    InputOrderOfMatrix := OrderOfMatrix;
End;

Function TFileReader.IsFileGood: Boolean;
Begin
    Status := False;
    If Not FileExists(FileName) Or Not IsFileTxt() Or Not IsFileReadable() Then
        Status := False
    Else
        Status := True;
    IsFileGood := Status;
End;

Function TFileReader.IsFileReadable: Boolean;
Begin
    Try
        Reset(InFile);
        Status := True;
        CloseFile(InFile);
    Except
        Status := False;
    End;
    IsFileReadable := Status;
End;

Function TFileReader.IsFileTxt: Boolean;
Var
    FileType: String;
Begin
    FileType := FileName.Substring(FileName.Length - 4);
    If FileType = '.txt' Then
        Status := True
    Else
        Status := False;
    IsFileTxt := Status;
End;

Procedure TFileReader.SetFileName(FileName: String);
Begin
    Self.FileName := FileName;
    Assign(InFile, Self.FileName);
End;

{ TFileWriter }

Function TFileWriter.GetStatus: Boolean;
Begin
    GetStatus := Status;
End;

Function TFileWriter.IsFileGood(): Boolean;
Begin
    Status := False;
    If Not FileExists(FileName) Or Not IsFileTxt() Or IsFileWritable() Then
        Status := False
    Else
        Status := True;
    IsFileGood := Status;
End;

Function TFileWriter.IsFileTxt: Boolean;
Var
    FileType: String;
Begin
    FileType := FileName.Substring(FileName.Length - 4);
    If FileType = '.txt' Then
        Status := True
    Else
        Status := False;
    IsFileTxt := Status;
End;

Function TFileWriter.IsFileWritable: Boolean;
Begin
    Try
        ReWrite(OutFile);
        Status := True;
        CloseFile(OutFile);
    Except
        Status := False;
    End;
    IsFileWritable := Status;
End;

Procedure TFileWriter.OutputSum(BestSum : Integer);
Begin
    Try
        Rewrite(OutFile);
        Writeln(OutFile, 'Cумма равна: ',BestSum , '.');
        Status := True;
    Except
        Status := False;
    End;
    CloseFile(OutFile);
End;

Procedure TFileWriter.SetFileName(FileName: String);
Begin
    Self.FileName := FileName;
    Assign(OutFile, Self.FileName);
End;

End.
