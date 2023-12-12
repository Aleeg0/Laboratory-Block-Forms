Unit BackendUnit3_1;

Interface

Uses System.SysUtils;

Type
    TNumberSearcher = Class
    Private
        UserString: String;
        Number: String;
    Public
        Procedure SetUserString(UserString: String);
        Procedure FindNumberInString();
        Function WasNumber(): Boolean;
        Function GetNumber(): String;
    End;

    TFileReader = Class
    Private
        FileName: String;
        InFile: TextFile;
        FileStatus: Boolean;
        Function IsFileTxt(): Boolean;
        Function IsFileReadable(): Boolean;
    Public
        Constructor Create(FileName: String);
        Function GetStatus(): Boolean;
        Function InputString(): String;
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
        Procedure OutputNumber(Number: String);
        Function IsFileGood(): Boolean;
    End;

Var
    NumberSearcher: TNumberSearcher;

Implementation

{ TNumberSearcher }

Procedure TNumberSearcher.FindNumberInString;
Var
    IsNumber, WasNumber: Boolean;
    I, Size: Integer;
Begin
    IsNumber := False;
    WasNumber := False;
    Number := '';
    Size := Length(UserString);
    For I := 1 To Size Do
    Begin
        If (Not WasNumber) And
            ((UserString[I] = '+') Or (UserString[I] = '-')) Then
        Begin
            IsNumber := True;
            Number := '';
            Number := Number + UserString[I];
        End
        Else If (IsNumber) And (47 < Ord(UserString[I])) And
            (Ord(UserString[I]) < 58) Then
        Begin
            Number := Number + UserString[I];
            WasNumber := True;
        End
        Else If IsNumber And WasNumber Then
        Begin
            IsNumber := False;
        End
        Else If Not WasNumber Then
            IsNumber := False;
    End;
    If Not WasNumber Then
        Number := '';
End;

Function TNumberSearcher.GetNumber: String;
Begin
    GetNumber := Number;
End;

Procedure TNumberSearcher.SetUserString(UserString: String);
Begin
    Self.UserString := UserString;
End;

Function TNumberSearcher.WasNumber: Boolean;
Begin
    If Number = '' Then
        WasNumber := False
    Else
        WasNumber := True;
End;

{ TFileReader }

Function TFileReader.IsFileReadable(): Boolean;
Begin
    Try
        Reset(InFile);
        FileStatus := True;
    Except
        FileStatus := False;
    End;
    CloseFile(InFile);
    IsFileReadable := FileStatus;
End;

Function TFileReader.IsFileTxt: Boolean;
Var
    FileType: String;
Begin
    FileType := FileName.Substring(FileName.Length - 4);
    If FileType = '.txt' Then
        FileStatus := True
    Else
        FileStatus := False;
    IsFileTxt := FileStatus;
End;

Function TFileReader.IsFileGood(): Boolean;
Begin
    FileStatus := False;
    If Not FileExists(FileName) And IsFileTxt() And IsFileReadable() Then
        FileStatus := True;
    IsFileGood := FileStatus;
End;

Constructor TFileReader.Create(FileName: String);
Begin
    Self.FileName := FileName;
    Assign(InFile, Self.FileName);
End;

Function TFileReader.GetStatus: Boolean;
Begin
    GetStatus := FileStatus;
End;

Function TFileReader.InputString: String;
Var
    InputtedString: String;
Begin
    Reset(InFile);
    If Not Eof(InFile) Then
    Begin
        Read(InFile, InputtedString);
        FileStatus := True;
    End
    Else
        FileStatus := False;
    CloseFile(InFile);
    InputString := InputtedString;
End;

{ TFileWriter }

Function TFileWriter.GetStatus: Boolean;
Begin
    GetStatus := Status;
End;

Function TFileWriter.IsFileGood(): Boolean;
Begin
    Status := False;
    If Not FileExists(FileName) Or Not(IsFileTxt() Or IsFileWritable()) Then
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
        Reset(OutFile);
        Status := True;
    Except
        Status := False;
    End;
    CloseFile(OutFile);
    IsFileWritable := Status;
End;

Procedure TFileWriter.OutputNumber(Number : String);
Begin
    Try
        Rewrite(OutFile);
        if NumberSearcher.WasNumber() then
            Writeln(OutFile, 'Число: ', Number , '.')
        else
            Writeln(OutFile, 'Число не было найденно в данной строке!');
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
