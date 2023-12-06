Unit MainFormUnit2_1;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.ImageList, Vcl.ImgList,
    Vcl.Buttons, Vcl.Menus, Vcl.Grids, Vcl.StdCtrls;

Type
    TMainForm = Class(TForm)
        TaskInfo: TLabel;
        NumberOfTrianglesInfo: TLabel;
        NumberOfTrianglesEdit: TEdit;
        NumberOfTrianglesButton: TButton;
        SidesOfTrianglesInfo: TLabel;
        SidesOfTriangles: TStringGrid;
        OpenDialog1: TOpenDialog;
        SaveDialog1: TSaveDialog;
        MainMenu1: TMainMenu;
        FileButton: TMenuItem;
        OpenFileButton: TMenuItem;
        SaveFileButton: TMenuItem;
        InstructionButton: TMenuItem;
        AboutTheDeveloperButton: TMenuItem;
        PopupMenu1: TPopupMenu;
        FindTriangleButton: TBitBtn;
        ImageList1: TImageList;
        MaxTriangleLabel: TLabel;
        Procedure InstructionButtonClick(Sender: TObject);
        Procedure AboutTheDeveloperButtonClick(Sender: TObject);
        Procedure NumberOfTrianglesEditKeyDown(Sender: TObject; Var Key: Word;
            Shift: TShiftState);
        Procedure NumberOfTrianglesEditKeyPress(Sender: TObject; Var Key: Char);
        Procedure NumberOfTrianglesEditChange(Sender: TObject);
        Procedure NumberOfTrianglesButtonClick(Sender: TObject);
        Procedure FormCreate(Sender: TObject);
        Procedure SidesOfTrianglesKeyDown(Sender: TObject; Var Key: Word;
            Shift: TShiftState);
        Procedure SidesOfTrianglesKeyPress(Sender: TObject; Var Key: Char);
        Procedure SidesOfTrianglesKeyUp(Sender: TObject; Var Key: Word;
            Shift: TShiftState);
        Procedure FindTriangleButtonClick(Sender: TObject);
        Procedure OpenFileButtonClick(Sender: TObject);
        Procedure SaveFileButtonClick(Sender: TObject);
        Procedure FormCloseQuery(Sender: TObject; Var CanClose: Boolean);
    Private
        NumberOfTriangles: Integer;
        WasChanged: Boolean;
        IsGridFill: Boolean;
        IsFileSaved: Boolean;
    Public
        { Public declarations }
    End;

Var
    MainForm: TMainForm;

Implementation

{$R *.dfm}

Uses InstructionUnit2_1, AboutTheDeveloperUnit2_1, BackendUnit2_1;

Procedure TMainForm.AboutTheDeveloperButtonClick(Sender: TObject);
Begin
    AboutTheDeveloperForm.Show;
End;

Procedure TMainForm.FindTriangleButtonClick(Sender: TObject);
Var
    I, BadIndex: Integer;
Begin
    BadIndex := TrianglesStore.FindBadTriangle();
    If (BadIndex = -1) Then
    Begin
        TrianglesStore.FindMaxSquareTriangle();
        MaxTriangleLabel.Caption := 'Треугольник под номером ' +
            IntToStr(TrianglesStore.GetMaxSquareTriangleIndex() + 1) +
            ' имеет максимальную площадь: ' + FormatFloat('0.###',
            TrianglesStore.GetMaxSquareTrinagle()) + '.';
        SaveFileButton.Enabled := True;
        IsFileSaved := False;
    End
    Else
    Begin
        MessageBox(MainForm.Handle,
            PChar('Треугольник под номером ' + IntToStr(BadIndex + 1) +
            ' не существует.'), 'ой-йой', MB_ICONEXCLAMATION);
    End;
End;

Procedure TMainForm.FormCloseQuery(Sender: TObject; Var CanClose: Boolean);
Begin
    If Not FindTriangleButton.Enabled Or IsFileSaved Then
        CanClose := MessageBox(MainForm.Handle,
            'Вы действительно хотите выйти?', 'Выход',
            MB_ICONQUESTION + MB_YESNO) = ID_YES
    Else If FindTriangleButton.Enabled Then
    Begin
        Repeat
            ExitCode := MessageBox(MainForm.Handle,
                'Сохранить данные в файл перед выходом?', 'Подверждение',
                MB_ICONQUESTION + MB_YESNOCANCEL);
            If ExitCode = ID_YES Then
            Begin
                SaveFileButtonClick(MainForm);
                CanClose := True;
            End
            Else If ExitCode = ID_NO Then
                CanClose := True
            Else
                CanClose := False;
        Until IsFileSaved Or (ExitCode = ID_NO) Or (ExitCode = ID_CANCEL);
    End;
End;

Procedure TMainForm.FormCreate(Sender: TObject);
Begin
    // for correct display
    SidesOfTriangles.ColWidths[0] := 100;
End;

Procedure TMainForm.InstructionButtonClick(Sender: TObject);
Begin
    InstructionForm.Show;
End;

Procedure TMainForm.NumberOfTrianglesButtonClick(Sender: TObject);
Const
    MAX_SIZE: Integer = 1000;
    MIN_SIZE: Integer = 0;
Var
    I: Integer;
Begin
    NumberOfTriangles := StrToInt(NumberOfTrianglesEdit.Text);
    If (MIN_SIZE < NumberOfTriangles) And (NumberOfTriangles < MAX_SIZE) Then
    Begin
        If TrianglesStore <> Nil Then
            TrianglesStore.Destroy();
        TrianglesStore := TTrianglesStore.Create(NumberOfTriangles);
        // creating Grid
        SidesOfTriangles.RowCount := NumberOfTriangles + 1;
        SidesOfTriangles.ColCount := 4;
        SidesOfTriangles.FixedCols := 1;
        SidesOfTriangles.FixedRows := 1;
        SidesOfTriangles.Cells[0, 0] := '№ треугольника';
        SidesOfTriangles.Cells[1, 0] := '1 сторона';
        SidesOfTriangles.Cells[2, 0] := '2 сторона';
        SidesOfTriangles.Cells[3, 0] := '3 сторона';
        For I := 1 To NumberOfTriangles Do
            SidesOfTriangles.Cells[0, I] := IntToStr(I);
        SidesOfTriangles.Enabled := True;
        SidesOfTriangles.Visible := True;
        SidesOfTrianglesInfo.Visible := True;
    End
    Else
        MessageBox(MainForm.Handle,
            'Количество не соответствует границам! Проверьте данные.', 'Ой-йой',
            MB_ICONERROR);
End;

Procedure TMainForm.NumberOfTrianglesEditChange(Sender: TObject);
Var
    I, J: Integer;
Begin
    NumberOfTrianglesButton.Enabled := Not String.IsNullOrEmpty
        (NumberOfTrianglesEdit.Text);
    If Not NumberOfTrianglesButton.Enabled Then
    Begin
        SidesOfTriangles.Enabled := False;

    End;
    If WasChanged Then
    Begin
        SidesOfTriangles.Visible := False;
        SidesOfTrianglesInfo.Visible := False;
        FindTriangleButton.Enabled := False;
        // Очистка всех ячеек StringGrid
        For I := 1 To SidesOfTriangles.RowCount Do
        Begin
            For J := 1 To SidesOfTriangles.ColCount Do
            Begin
                SidesOfTriangles.Cells[J - 1, I - 1] := '';
            End;
        End;
    End;
    WasChanged := True;
End;

Procedure TMainForm.NumberOfTrianglesEditKeyDown(Sender: TObject; Var Key: Word;
    Shift: TShiftState);
Var
    CurEdit: TEdit;
Begin
    CurEdit := TEdit(Sender);
    If (NumberOfTrianglesButton.Enabled) And (CurEdit.SelLength = 0) And
        ((Key = VK_DOWN) Or (Key = VK_RETURN)) Then
        ActiveControl := NumberOfTrianglesButton;
    If (NumberOfTrianglesButton.Enabled) And
        (Length(CurEdit.Text) = CurEdit.SelStart) And (Key = VK_RIGHT) Then
        ActiveControl := NumberOfTrianglesButton;
    If (FindTriangleButton.Enabled) And (CurEdit.SelLength = 0) And (CurEdit.SelStart = 0) And (Key = VK_LEFT) Then
        ActiveControl := FindTriangleButton;
    if (FindTriangleButton.Enabled) And (Key = VK_UP) Then
        ActiveControl := FindTriangleButton;
    TEdit(Sender).ReadOnly := (Key = VK_INSERT) And
        ((SsShift In Shift) Or (SsCtrl In Shift)) Or (Key = VK_DELETE);
End;

Procedure TMainForm.NumberOfTrianglesEditKeyPress(Sender: TObject;
    Var Key: Char);
Const
    GOOD_KEYS: Set Of Char = ['1' .. '9', #08];
    MAX_DIGITS: Integer = 2;
Var
    TrianglesEdit: TEdit;
    TempKey: Char;
Begin
    TrianglesEdit := TEdit(Sender);
    If (Length(TrianglesEdit.Text) = 0) And Not(Key In GOOD_KEYS) Then
        Key := #0;
    If (Length(TrianglesEdit.Text) > 0) And
        Not((Key In GOOD_KEYS) Or (Key = '0')) Then
        Key := #0;
    // for backspace
    If (Length(TrianglesEdit.Text) > 1) And (TrianglesEdit.SelStart = 1) And
        (TrianglesEdit.Text[2] = '0') And (Key = #08) Then
        Key := #0;
    If (Length(TrianglesEdit.Text) > 1) And
        (Length(TrianglesEdit.Text) <> TrianglesEdit.SelLength) And
        (TrianglesEdit.SelLength <> 0) And (TrianglesEdit.SelStart = 0) And
        (TrianglesEdit.Text[TrianglesEdit.SelLength + 1] = '0') And Not(Key in ['1'..'9']) Then
        Key := #0;
    // Key := 0;
    If (TrianglesEdit.SelStart = 0) And (Key = '0') Then
        Key := #0;
    If (Length(TrianglesEdit.Text) > MAX_DIGITS) And (Key <> #08) And
        (TrianglesEdit.SelLength = 0) Then
        Key := #0;
End;

Procedure TMainForm.OpenFileButtonClick(Sender: TObject);
Var
    FileReader: TFileReader;
    I, J, BadTriangleIndex: Integer;
    Triangles: TArrayOfTriangles;
Begin
    If OpenDialog1.Execute() Then
    Begin
        FileReader := TFileReader.Create;
        FileReader.SetFileName(OpenDialog1.FileName);
        If FileReader.IsFileGood() Then
        Begin
            NumberOfTriangles := FileReader.InputNumberOfTriangles();
            If FileReader.GetStatus() Then
            Begin
                NumberOfTrianglesEdit.Text := IntToStr(NumberOfTriangles);
                NumberOfTrianglesButton.Click;
                If TrianglesStore <> Nil Then
                    TrianglesStore.Destroy();
                TrianglesStore := TTrianglesStore.Create(NumberOfTriangles);
                Triangles := FileReader.InputTriangles(NumberOfTriangles);
                TrianglesStore.SetTrinagles(Triangles);
                If FileReader.GetStatus() Then
                Begin
                    BadTriangleIndex := TrianglesStore.FindBadTriangle();
                    If (BadTriangleIndex = -1) Then
                    Begin
                        For I := 1 To NumberOfTriangles Do
                            For J := 1 To SIDES Do // count sides of triangle
                                SidesOfTriangles.Cells[J, I] :=
                                    FloatToStr(Triangles[I - 1][J - 1]);
                        FindTriangleButton.Enabled := True;
                    End
                    Else
                        MessageBox(MainForm.Handle,
                            PChar('Треугольник под номером ' +
                            IntToStr(BadTriangleIndex + 1) + ' не существует.'),
                            'ой-йой', MB_ICONEXCLAMATION);
                End
                Else
                    MessageBox(MainForm.Handle,
                        'Стороны треугольников введены неправильно! Проверьте данные.',
                        'Ой-йой', MB_ICONERROR);
            End
            Else
                MessageBox(MainForm.Handle,
                    'Размер введён неправильно или не соответствует границам! Проверьте данные.',
                    'Ой-йой', MB_ICONERROR);
        End
        Else
            MessageBox(MainForm.Handle,
                'Файл закрыт для чтения или не текстовый! ', 'Ошибка',
                MB_ICONERROR);
        FileReader.Destroy;
        FileReader := Nil;
    End;
End;

Procedure TMainForm.SaveFileButtonClick(Sender: TObject);
Var
    FileWriter: TFileWriter;
Begin
    If SaveDialog1.Execute() Then
    Begin
        FileWriter := TFileWriter.Create;
        FileWriter.SetFileName(SaveDialog1.FileName);
        If FileWriter.IsFileGood() Then
        Begin
            FileWriter.OutputSquare();
            If FileWriter.GetStatus() Then
                IsFileSaved := True
            Else
                MessageBox(MainForm.Handle, 'Упс.. Что-то пошло не так!',
                    'Ой-йой', MB_ICONERROR);
        End;
        FileWriter.Destroy;
        FileWriter := Nil;
    End;
End;

Procedure TMainForm.SidesOfTrianglesKeyDown(Sender: TObject; Var Key: Word;
    Shift: TShiftState);
Var
    Grid: TStringGrid;
Begin
    Grid := TStringGrid(Sender);
    // move down if FindTriangleButton Enable
    If FindTriangleButton.Enabled And (Grid.Col = Grid.ColCount - 1) And
        (Grid.Row = Grid.RowCount - 1) And
        ((Key = VK_RETURN) Or (Key = VK_RIGHT) Or (Key = VK_DOWN)) Then
        ActiveControl := FindTriangleButton;
    If FindTriangleButton.Enabled And (Grid.Row = Grid.RowCount - 1) And
        (Key = VK_DOWN) Then
        ActiveControl := FindTriangleButton;
    // move down if FindTriangleButton Not Enable
    If Not FindTriangleButton.Enabled And (Grid.Col = Grid.ColCount - 1) And
        (Grid.Row = Grid.RowCount - 1) And
        ((Key = VK_RETURN) Or (Key = VK_RIGHT) Or (Key = VK_DOWN)) Then
        ActiveControl := NumberOfTrianglesEdit;
    If Not FindTriangleButton.Enabled And (Grid.Row = Grid.RowCount - 1) And
        (Key = VK_DOWN) Then
        ActiveControl := NumberOfTrianglesEdit;

    // move up
    If (Grid.Col = 1) And (Grid.Row = 1) And
        ((Key = VK_LEFT) Or (Key = VK_UP)) Then
        ActiveControl := NumberOfTrianglesButton;
End;

Procedure TMainForm.SidesOfTrianglesKeyPress(Sender: TObject; Var Key: Char);
Const
    GOOD_KEYS: Set Of Char = ['1' .. '9'];
    MAX_DIGITS: Integer = 3;
Var
    ArrGrid: TStringGrid;
    TempNumber: String;
Begin
    ArrGrid := TStringGrid(Sender);
    TempNumber := ArrGrid.Cells[ArrGrid.Col, ArrGrid.Row];
    If (Key = #08) And (Length(ArrGrid.Cells[ArrGrid.Col, ArrGrid.Row])
        <> 0) Then
    Begin
        Delete(TempNumber, Length(TempNumber), 1);
        ArrGrid.Cells[ArrGrid.Col, ArrGrid.Row] := TempNumber;
    End;
    // Ограничение символов
    If (Length(TempNumber) > MAX_DIGITS) Then
        Key := #0;
    // первый символ
    If (Length(TempNumber) = 0) And (Key In GOOD_KEYS) Then
        ArrGrid.Cells[ArrGrid.Col, ArrGrid.Row] :=
            ArrGrid.Cells[ArrGrid.Col, ArrGrid.Row] + Key;
    // второй символ
    If (Length(TempNumber) = 1) And ((Key In GOOD_KEYS) Or (Key = ',') Or
        (Key = '0')) Then
        ArrGrid.Cells[ArrGrid.Col, ArrGrid.Row] :=
            ArrGrid.Cells[ArrGrid.Col, ArrGrid.Row] + Key;
    // остальный символы
    If (Length(TempNumber) > 1) And ((Key In GOOD_KEYS) Or (Key = ',') Or
        (Key = '0')) Then
        ArrGrid.Cells[ArrGrid.Col, ArrGrid.Row] :=
            ArrGrid.Cells[ArrGrid.Col, ArrGrid.Row] + Key;
    If (Pos(',', TempNumber) <> 0) And (Key = ',') Then
        Key := #0;
    { If (Key <> #0) And (Length(TempNumber) > 0) And (Key In GOOD_KEYS) Or
      (Key = '0') Or (Key = '-') Then
      ArrGrid.Cells[ArrGrid.Col, ArrGrid.Row] :=
      ArrGrid.Cells[ArrGrid.Col, ArrGrid.Row] + Key; }
    // change possition of actionBox
    If (Key = #13) And (ArrGrid.Col = (ArrGrid.ColCount - 1)) And
        (ArrGrid.Row < ArrGrid.RowCount - 1) Then
    Begin
        ArrGrid.Row := ArrGrid.Row + 1;
        ArrGrid.Col := 1;
    End
    Else If (Key = #13) And (ArrGrid.Col < ArrGrid.ColCount - 1) Then
        ArrGrid.Col := ArrGrid.Col + 1;
End;

Procedure TMainForm.SidesOfTrianglesKeyUp(Sender: TObject; Var Key: Word;
    Shift: TShiftState);
Var
    CountOfExistsTriangles, I, J: Integer;
    CountInputSides: Integer;
    A, B, C: Real;
Begin
    CountOfExistsTriangles := 0;

    For I := 1 To NumberOfTriangles Do
    Begin
        CountInputSides := 0;
        If (Length(SidesOfTriangles.Cells[1, I]) <> 0) Then
        Begin
            A := StrToFloat(SidesOfTriangles.Cells[1, I]);
            Inc(CountInputSides);
        End;
        If (Length(SidesOfTriangles.Cells[2, I]) <> 0) Then
        Begin
            B := StrToFloat(SidesOfTriangles.Cells[2, I]);
            Inc(CountInputSides);
        End;
        If (Length(SidesOfTriangles.Cells[3, I]) <> 0) Then
        Begin
            C := StrToFloat(SidesOfTriangles.Cells[3, I]);
            Inc(CountInputSides);
        End;
        If CountInputSides = 3 Then
        Begin
            Inc(CountOfExistsTriangles);
            TrianglesStore.SetSidesOfTriangle(I - 1, A, B, C);
        End;
    End;
    If CountOfExistsTriangles = NumberOfTriangles Then
        IsGridFill := True
    Else
        IsGridFill := False;
    FindTriangleButton.Enabled := IsGridFill;
End;

End.
