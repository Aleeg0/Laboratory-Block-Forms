Unit BackendUnit2_1;

Interface

Uses
    System.SysUtils;

Const
    SIDES: Integer = 3;

Type
    // designed for storing triangles
    // first index is trinagle
    // second index is side of 'first index' triangle
    // second indexes:
    // [triangle][0] = A side of trinagle
    // [triangle][1] = B side of trinagle
    // [triangle][2] = C side of trinagle
    TArrayOfTriangles = Array Of Array Of Real;

    TTrianglesStore = Class
    Private
        Triangles: TArrayOfTriangles;
        NumberOfTriangles: Integer;
        MaxSquare: Real;
        MaxSquareIndex: Integer;
        Function SquareOfTriangle(A, B, C: Real): Real;
        Function IsTriangleExist(Var A, B, C: Real): Boolean;
    Public
        Constructor Create(NumberOfTriangles: Integer);
        Procedure SetNumberOfTriangles(NumberOfTriangles: Integer);
        Procedure SetSidesOfTriangle(IndexOfTriangle: Integer; A, B, C: Real);
        Procedure SetTrinagles(Trinagles : TArrayOfTriangles);
        // function return index of Triangle wich does not exist
        // otherwise -1 if all triangles exist
        Function FindBadTriangle(): Integer;
        Procedure FindMaxSquareTriangle();
        Function GetMaxSquareTrinagle(): Real;
        Function GetMaxSquareTriangleIndex(): Integer;
        Destructor Destroy;
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
        Function InputNumberOfTriangles(): Integer;
        Function InputTriangles(Const NumberOfTriangles: Integer)
            : TArrayOfTriangles;
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
        // Procedure OutputArray(Arr: TArrayOfInt; Const SIZE: Integer);
        Procedure OutputSquare();
        Function IsFileGood(): Boolean;
    End;

Var
    TrianglesStore: TTrianglesStore;

Implementation

{ TrianglesStore }

Constructor TTrianglesStore.Create(NumberOfTriangles: Integer);
Begin
    Self.NumberOfTriangles := NumberOfTriangles;
    SetLength(Triangles, NumberOfTriangles, SIDES);
End;

Destructor TTrianglesStore.Destroy;
Begin
    If Triangles <> Nil Then
        Triangles := Nil;
End;

Procedure TTrianglesStore.FindMaxSquareTriangle;
Var
    I, J: Integer;
    TempSquare: Real;
Begin
    MaxSquareIndex := 0;
    MaxSquare := SquareOfTriangle(Triangles[MaxSquareIndex][0],
        Triangles[MaxSquareIndex][1], Triangles[MaxSquareIndex][2]);
    For I := 2 To NumberOfTriangles Do
    Begin
        TempSquare := SquareOfTriangle(Triangles[I - 1][0], Triangles[I - 1][1],
            Triangles[I - 1][2]);
        If TempSquare > MaxSquare Then
        Begin
            MaxSquare := TempSquare;
            MaxSquareIndex := I - 1;
        End;
    End;
End;

Function TTrianglesStore.GetMaxSquareTriangleIndex: Integer;
Begin
    GetMaxSquareTriangleIndex := MaxSquareIndex;
End;

Function TTrianglesStore.GetMaxSquareTrinagle: Real;
Begin
    GetMaxSquareTrinagle := MaxSquare;
End;

Function TTrianglesStore.FindBadTriangle: Integer;
Var
    BadTriangleIndex, I: Integer;

Begin
    BadTriangleIndex := -1;
    For I := 1 To NumberOfTriangles Do
    Begin
        If Not IsTriangleExist(Triangles[I - 1][0], Triangles[I - 1][1],
            Triangles[I - 1][2]) Then
            BadTriangleIndex := I - 1;
    End;
    FindBadTriangle := BadTriangleIndex;
End;

Function TTrianglesStore.IsTriangleExist(Var A, B, C: Real): Boolean;
Begin
    If (A + B > C) And (A + C > B) And (B + C > A) Then
        IsTriangleExist := True
    Else
        IsTriangleExist := False
End;

Procedure TTrianglesStore.SetNumberOfTriangles(NumberOfTriangles: Integer);
Begin
    Self.NumberOfTriangles := NumberOfTriangles;
    SetLength(Triangles, NumberOfTriangles, SIDES);
End;

Procedure TTrianglesStore.SetSidesOfTriangle(IndexOfTriangle: Integer;
    A, B, C: Real);
Begin
    Triangles[IndexOfTriangle][0] := A;
    Triangles[IndexOfTriangle][1] := B;
    Triangles[IndexOfTriangle][2] := C;
End;

procedure TTrianglesStore.SetTrinagles(Trinagles: TArrayOfTriangles);
begin
    Self.Triangles := Trinagles;
end;

Function TTrianglesStore.SquareOfTriangle(A, B, C: Real): Real;
Var
    Square: Real;
    P: Real; // half of perimeter
Begin
    P := (A + B + C) / 2.0;
    Square := Sqrt(P * (P - A) * (P - B) * (P - C));
    SquareOfTriangle := Square;
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
    If Not FileExists(FileName) Or Not(IsFileTxt() Or Not IsFileReadable()) Then
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

Function TFileReader.InputNumberOfTriangles: Integer;
Const
    MIN_SIZE: Integer = 1;
    MAX_SIZE: Integer = 99;
Var
    NumberOfTriangles: Integer;
Begin
    NumberOfTriangles := 0;
    Reset(InFile);
    Try
        Read(InFile, NumberOfTriangles);
    Except
        Status := False;
    End;
    If (NumberOfTriangles < MIN_SIZE) Or (MAX_SIZE < NumberOfTriangles) Then
    Begin
        Status := False;
    End;
    CloseFile(InFile);
    InputNumberOfTriangles := NumberOfTriangles;
End;

Function TFileReader.InputTriangles(Const NumberOfTriangles: Integer)
    : TArrayOfTriangles;
Const
    MIN_NUMBER: Integer = 0;
    MAX_NUMBER: Integer = 9999;
Var
    IsCorrect: Boolean;
    I, J: Integer;
    TempSide: Real;
    Triangles: TArrayOfTriangles;
Begin
    SetLength(Triangles, NumberOfTriangles, SIDES);
    IsCorrect := False;
    Reset(InFile);
    Read(InFile, Triangles[0][0]);
    For I := 1 To NumberOfTriangles Do
    Begin
        For J := 1 To SIDES Do // sides
        Begin
            If Status Then
            Begin
                Try
                    Read(InFile, TempSide);
                Except
                    Status := False;
                End;
                If Status And ((TempSide < MIN_NUMBER) Or
                    (MAX_NUMBER < TempSide)) Then
                    Status := False
                Else If Status Then
                    Triangles[I - 1, J - 1] := TempSide;
            End;
        End;
    End;
    CloseFile(InFile);
    InputTriangles := Triangles;
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

procedure TFileWriter.OutputSquare();
begin
    Try
        Rewrite(OutFile);
        Writeln(OutFile, 'Треугольник под номером ' ,
           TrianglesStore.GetMaxSquareTriangleIndex() + 1,
            ' имеет максимальную площадь: ', FormatFloat('0.###',TrianglesStore.GetMaxSquareTrinagle()), '.');
        Status := True;
    Except
        Status := False;
    End;
    CloseFile(OutFile);
end;

End.
