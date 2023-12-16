Unit BackendUnit2_2;

Interface

Uses System.SysUtils;

Type
    TArrayOfInt = Array Of Integer;

    TSearcherNumbers = Class
    Private
        K: Integer;
        MaxNumber: Integer;
        Numbers: TArrayOfInt; // first index has size
        Procedure FindMaxNumber();
        Function DigitsSum(Number: Integer): Integer;
    Public
        Procedure SetK(K: Integer);
        Procedure FindNumbers();
        Function GetNumbers(): TArrayOfInt;

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
        Function InputK(): Integer;
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
        Procedure OutputNumbers();
        Function IsFileGood(): Boolean;
    End;

Var
    SearcherNumbers: TSearcherNumbers;

Implementation

{ TFindNumbers }

Function TSearcherNumbers.DigitsSum(Number: Integer): Integer;
Var
    Sum: Integer;
Begin
    Sum := 0;
    While Number > 0 Do
    Begin
        Sum := Sum + Number Mod 10;
        Number := Number Div 10;
    End;
    DigitsSum := Sum;
End;

Procedure TSearcherNumbers.FindMaxNumber();
Const
    MaxDigit: Integer = 9;
    MaxDigits: Integer = 10;
Var
    CountOfDigits: Integer;
Begin
    MaxNumber := 1;
    CountOfDigits := 1;
    While (CountOfDigits < MaxDigits) And
        ((K * MaxDigit * CountOfDigits) > MaxNumber) Do
    Begin
        MaxNumber := MaxNumber * 10;
        CountOfDigits := CountOFDigits + 1;
    End;
    MaxNumber := MaxNumber Div 10;
End;

Procedure TSearcherNumbers.FindNumbers;
Var
    Number, Counter: Integer;
Begin
    Counter := 0;
    Number := K;
    FindMaxNumber();
    SetLength(Numbers, 1);
    Numbers[0] := 0;
    While Number < MaxNumber Do
    Begin
        If Number = (DigitsSum(Number) * K) Then
        Begin
            Inc(Counter);
            If Numbers[0] < Counter Then
            Begin
                SetLength(Numbers, Numbers[0] + 2);
            End;
            Inc(Numbers[0]);
            Numbers[Counter] := Number;
        End;
        Number := Number + K;
    End;
End;

Function TSearcherNumbers.GetNumbers: TArrayOfInt;
Begin
    GetNumbers := Numbers;
End;

Procedure TSearcherNumbers.SetK(K: Integer);
Begin
    Self.K := K;
End;

// Methods of TFileReader class
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
    If Not FileExists(FileName) Or Not IsFileTxt() Or Not IsFileReadable() Then
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

Function TFileReader.InputK: Integer;
Const
    MIN_SIZE: Integer = 0;
    MAX_SIZE: Integer = 10000000;
Var
    K: Integer;
Begin
    Reset(InFile);
    Try
        Read(InFile, K);
    Except
        Status := False;
    End;
    If Status And (MIN_SIZE < K) And (K < MAX_SIZE) Then
        Status := True
    Else
        Status := False;
    CloseFile(InFile);
    InputK := K;
End;

// Methods of TFileWriter class
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
        ReWrite(OutFile);
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
    If Not FileExists(FileName) Or Not IsFileTxt() Or Not IsFileWritable() Then
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

Procedure TFileWriter.OutputNumbers();
Var
    Numbers: TArrayOfInt;
    I: Integer;
Begin
    Try
        Rewrite(OutFile);
        Numbers := SearcherNumbers.GetNumbers();
        If Numbers[0] > 0 Then
        Begin
            Write(OutFile, 'Числа: ');
            For I := 1 To Numbers[0] Do
            Begin
                if (I mod 5 = 0) then
                    Writeln(OutFile);
                Write(OutFile, Numbers[I], ' ');
            End;
            Writeln(OutFile);
        End
        Else
            Writeln(OutFile, 'Таких чисел не сущетсвует.');
        Status := True;
    Except
        Status := False;
    End;
    CloseFile(OutFile);
End;

End.
