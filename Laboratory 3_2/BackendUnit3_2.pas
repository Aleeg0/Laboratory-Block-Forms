Unit BackendUnit3_2;

Interface

Uses System.SysUtils;

Const
    COUNT_SYMBOLS: Integer = 255;
    KEY_SYMBOLS: Set Of Char = ['[', ']', '{', '}', '(', ')', '+', '-', '*',
        '/', '%', '<', '>', '=', ':', '^'];

Type
    TSetOfChar = Set Of Char;

    TSymbolsSearcher = Class
    Private
        UserString: String;
        Symbols: TSetOfChar;
    Public
        Procedure SetUserString(UserString: String);
        Procedure FindSymbolsInString();
        Function WasSymbols(): Boolean;
        Function GetSymbols(): TSetOfChar;
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
        Procedure OutputSymbols(Symbols: TSetOfChar);
        Function IsFileGood(): Boolean;
    End;

Var
    SymbolsSearcher: TSymbolsSearcher;

Implementation

{ TNumberSearcher }

Procedure TSymbolsSearcher.FindSymbolsInString();
Var
    I, Size, CurCode: Integer;
    CurChar: Char;
Begin
    Symbols := [];
    Size := Length(UserString);
    For I := 1 To Size Do
    Begin
        CurChar := UserString[I];
        CurCode := Ord(CurChar);
        If (CurChar In KEY_SYMBOLS) Then
            Symbols := Symbols + [CurChar]
            // 48 - code of '0'
            // 57 - code of '9'
        Else If (47 < CurCode) And (CurCode < 58) Then
        Begin
            Dec(CurCode, 48);
            If Curcode Mod 2 = 0 Then
                Symbols := Symbols + [CurChar];
        End;
    End;
End;

Function TSymbolsSearcher.GetSymbols(): TSetOfChar;
Begin
    GetSymbols := Symbols;
End;

Procedure TSymbolsSearcher.SetUserString(UserString: String);
Begin
    Self.UserString := UserString;
End;

Function TSymbolsSearcher.WasSymbols: Boolean;
Begin
    If Symbols = [] Then
        WasSymbols := False
    Else
        WasSymbols := True;
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
    If FileExists(FileName) And IsFileTxt() And IsFileReadable() Then
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
    If Not FileExists(FileName) Or Not IsFileTxt() Or Not IsFileWritable() Then
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
        Rewrite(OutFile);
        Status := True;
    Except
        Status := False;
    End;
    CloseFile(OutFile);
    IsFileWritable := Status;
End;

Procedure TFileWriter.OutputSymbols(Symbols: TSetOfChar);
Var
    I: Integer;
Begin
    Rewrite(OutFile);
    If Symbols <> [] Then
    Begin
        Writeln(OutFile, 'Программа нашла такие символы: ');
        For I := 0 To COUNT_SYMBOLS Do
            If Chr(I) In Symbols Then
                Write(OutFile, Chr(I), ', ');
        Writeln(OutFile);
    End
    Else
        Writeln(OutFile, 'Программа не нашла символы.');
    CloseFile(OutFile);
End;

Procedure TFileWriter.SetFileName(FileName: String);
Begin
    Self.FileName := FileName;
    Assign(OutFile, Self.FileName);
End;

End.
