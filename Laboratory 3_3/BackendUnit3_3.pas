Unit BackendUnit3_3;

Interface

Uses System.SysUtils;

Type
    TArray = Array Of Integer;

    TArraySorter = Class
    Private
        UserArray: TArray;
        SortedArray: TArray;
        Size: Integer;
        Function Min(First, Second: Integer): Integer;
        Procedure Merge(Var Arr: TArray; Beg1, End1, Beg2, End2: Integer);
    Public
        Constructor Create(Size: Integer);
        Procedure SetElementByIndex(Element, I: Integer);
        Function GetSize(): Integer;
        Procedure MergeSort(First, Last: Integer);
        Function GetSortedArray(): TArray;

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
        Function InputSize(): Integer;
        Function InputArray(Const SIZE: Integer): TArray;
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
        Procedure OutputArray(Arr: TArray; Const SIZE: Integer);
        Function IsFileGood(): Boolean;
    End;

Var
    ArraySorter: TArraySorter;

Implementation

{ TArraySorting }

Constructor TArraySorter.Create(Size: Integer);
Begin
    Self.Size := Size;
    SetLength(UserArray, Size);
End;

Function TArraySorter.GetSize: Integer;
Begin
    GetSize := Size;
End;

Function TArraySorter.GetSortedArray: TArray;
Begin
    GetSortedArray := SortedArray;
End;

Procedure TArraySorter.Merge(Var Arr: TArray; Beg1, End1, Beg2, End2: Integer);
Var
    I, Left, Right, Size: Integer;
    CopyArr: TArray;
Begin
    Left := 0;
    Right := Beg2 - Beg1;
    Size := End2 - Beg1 + 1;
    SetLength(CopyArr, Size);
    For I := 1 To Size Do
        CopyArr[I - 1] := Arr[Beg1 + I - 1];
    I := Beg1;
    While (I < Beg1 + Size) Do
    Begin
        If (Left + Beg1 > End1) Then
        Begin
            Arr[I] := CopyArr[Right];
            Inc(Right);
        End
        Else If (Right + Beg1 > End2) Then
        Begin
            Arr[I] := CopyArr[Left];
            Inc(Left);
        End
        Else If (CopyArr[Left] < CopyArr[Right]) Then
        Begin
            Arr[I] := CopyArr[Left];
            Inc(Left);
        End
        Else
        Begin
            Arr[I] := CopyArr[Right];
            Inc(Right);
        End;
        Inc(I);
    End;

End;

Procedure TArraySorter.MergeSort(First, Last: Integer);
Var
    Step, J: Integer;
Begin
    Step := 1;
    SortedArray := Copy(UserArray);
    While (Step < Last) Do
    Begin
        J := First;
        While (J < Last - Step) Do
        Begin
            Merge(SortedArray, J, J + Step - 1, J + Step,
                Min(J + Step * 2 - 1, Last - 1));
            J := J + Step * 2;
        End;
        Step := Step * 2;
    End;
End;

Function TArraySorter.Min(First, Second: Integer): Integer;
Var
    MinNumber: Integer;
Begin
    If First < Second Then
        MinNumber := First
    Else
        MinNumber := Second;
    Min := MinNumber;
End;

Procedure TArraySorter.SetElementByIndex(Element, I: Integer);
Begin
    UserArray[I] := Element;
End;

{ TFileReader }

Function TFileReader.GetStatus: Boolean;
Begin
    GetStatus := Status;
End;

Function TFileReader.IsFileTxt(): Boolean;
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

Function TFileReader.IsFileReadable(): Boolean;
Begin
    Try
        Reset(InFile);
        Status := True;
    Except
        Status := False;
    End;
    CloseFile(InFile);
    IsFileReadable := Status;
End;

Function TFileReader.IsFileGood(): Boolean;
Begin
    Status := False;
    If Not FileExists(FileName) And Not(IsFileTxt() Or IsFileReadable()) Then
        Status := False
    Else
        Status := True;
    IsFileGood := Status;
End;

Procedure TFileReader.SetFileName(FileName: String);
Begin
    Self.FileName := FileName;
    Assign(InFile, Self.FileName);
End;

Function TFileReader.InputSize: Integer;
Const
    MIN_SIZE: Integer = 1;
    MAX_SIZE: Integer = 99;
Var
    Size: Integer;
Begin
    Size := 0;
    Reset(InFile);
    Try
        Read(InFile, Size);
    Except
        Status := False;
    End;
    If (Size < MIN_SIZE) Or (MAX_SIZE < Size) Then
    Begin
        Status := False;
    End;
    CloseFile(InFile);
    InputSize := Size;
End;

Function TFileReader.InputArray(Const SIZE: Integer): TArray;
Const
    MIN_NUMBER: Integer = -99999;
    MAX_NUMBER: Integer = 99999;
Var
    IsCorrect: Boolean;
    Arr: TArray;
    TempNumber, I: Integer;
Begin
    SetLength(Arr, SIZE);
    IsCorrect := False;
    Reset(InFile);
    Read(InFile, Arr[0]);
    For I := 1 To SIZE Do
    Begin
        If Status Then
        Begin
            Try
                Read(InFile, TempNumber);
            Except
                Status := False;
            End;
            If Status And ((TempNumber < MIN_NUMBER) Or
                (MAX_NUMBER < TempNumber)) Then
                Status := False
            Else If Status Then
                Arr[I - 1] := TempNumber;

        End;
    End;
    CloseFile(InFile);
    InputArray := Arr;
End;

{ TFileWriter }

Function TFileWriter.GetStatus: Boolean;
Begin
    GetStatus := Status;
End;

Function TFileWriter.IsFileTxt(): Boolean;
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

Function TFileWriter.IsFileWritable(): Boolean;
Begin
    Try
        Reset(OutFile);
        Status := True;
    Except
        Status := False;
    End;
    CloseFile(OutFile);
    IsFileWritable := Status;
End;

Function TFileWriter.IsFileGood(): Boolean;
Begin
    Status := False;
    If Not FileExists(FileName) And Not(IsFileTxt() Or IsFileWritable()) Then
        Status := False
    Else
        Status := True;
    IsFileGood := Status;
End;

Procedure TFileWriter.SetFileName(FileName: String);
Begin
    Self.FileName := FileName;
    Assign(OutFile, Self.FileName);
End;

Procedure TFileWriter.OutputArray(Arr: TArray; Const SIZE: Integer);
Var
    I: Integer;
Begin
    Try
        Rewrite(OutFile);
        Writeln(OutFile, 'Изменённый массив:');
        For I := 1 To SIZE Do
            Write(OutFile, Arr[I - 1], ' ');
        Writeln(OutFile);
        Status := True;
    Except
        Status := False;
    End;
    CloseFile(OutFile);
End;

End.
