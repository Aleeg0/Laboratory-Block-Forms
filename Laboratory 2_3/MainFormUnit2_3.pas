Unit MainFormUnit2_3;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.ImageList,
    Vcl.ImgList, Vcl.Menus, Vcl.Grids, Vcl.Buttons;

Type
    TMainForm = Class(TForm)
        OpenDialog1: TOpenDialog;
        SaveDialog1: TSaveDialog;
        MainMenu1: TMainMenu;
        FileButton: TMenuItem;
        OpenFileButton: TMenuItem;
        SaveFileButton: TMenuItem;
        InstructionButton: TMenuItem;
        AboutTheDeveloperButton: TMenuItem;
        PopupMenu1: TPopupMenu;
        ImageList1: TImageList;
        TaskInfo: TLabel;
        OrderOfMatrixLabel: TLabel;
        OrderOfMatrixEdit: TEdit;
        ElementsOfMatrixInfo: TLabel;
        MaxSumLabel: TLabel;
        OrderOfMatrixButton: TButton;
        ElementsOfMatrix: TStringGrid;
        FindMaxSumButton: TBitBtn;
        Procedure OrderOfMatrixEditKeyDown(Sender: TObject; Var Key: Word;
            Shift: TShiftState);
        Procedure OrderOfMatrixEditKeyPress(Sender: TObject; Var Key: Char);
        Procedure InstructionButtonClick(Sender: TObject);
        Procedure AboutTheDeveloperButtonClick(Sender: TObject);
        Procedure OrderOfMatrixEditChange(Sender: TObject);
        Procedure ElementsOfMatrixKeyUp(Sender: TObject; Var Key: Word;
            Shift: TShiftState);
        Procedure ElementsOfMatrixKeyPress(Sender: TObject; Var Key: Char);
        Procedure ElementsOfMatrixKeyDown(Sender: TObject; Var Key: Word;
            Shift: TShiftState);
        Procedure OrderOfMatrixButtonClick(Sender: TObject);
        Procedure OrderOfMatrixButtonKeyDown(Sender: TObject; Var Key: Word;
            Shift: TShiftState);
        Procedure FindMaxSumButtonClick(Sender: TObject);
        Procedure FindMaxSumButtonKeyDown(Sender: TObject; Var Key: Word;
            Shift: TShiftState);
        Procedure OpenFileButtonClick(Sender: TObject);
        Procedure SaveFileButtonClick(Sender: TObject);
        Procedure FormCloseQuery(Sender: TObject; Var CanClose: Boolean);
    Private
        WasOrderOfMatrixChanged: Boolean;
        IsFileSaved: Boolean;
        IsFindButtonPressed: Boolean;
        OrderOfMatrix: Integer;
    Public
        { Public declarations }
    End;

Var
    MainForm: TMainForm;

Implementation

Uses AboutTheDeveloperUnit2_3, InstructionUnit2_3, ExitUnit2_3, BackendUnit2_3;

{$R *.dfm}

Procedure TMainForm.AboutTheDeveloperButtonClick(Sender: TObject);
Begin
    AboutTheDeveloperForm.Show;
End;

Procedure TMainForm.ElementsOfMatrixKeyDown(Sender: TObject; Var Key: Word;
    Shift: TShiftState);
Var
    Grid: TStringGrid;
Begin
    IsFindButtonPressed := False;
    Grid := TStringGrid(Sender);
    // move down if FindTriangleButton Enable
    If FindMaxSumButton.Enabled And (Grid.Col = Grid.ColCount - 1) And
        (Grid.Row = Grid.RowCount - 1) And
        ((Key = VK_RETURN) Or (Key = VK_RIGHT) Or (Key = VK_DOWN)) Then
        ActiveControl := FindMaxSumButton;
    If FindMaxSumButton.Enabled And (Grid.Row = Grid.RowCount - 1) And
        (Key = VK_DOWN) Then
        ActiveControl := FindMaxSumButton;
    // move down if FindTriangleButton Not Enable
    If Not FindMaxSumButton.Enabled And (Grid.Col = Grid.ColCount - 1) And
        (Grid.Row = Grid.RowCount - 1) And
        ((Key = VK_RETURN) Or (Key = VK_RIGHT) Or (Key = VK_DOWN)) Then
        ActiveControl := OrderOfMatrixEdit;
    If Not FindMaxSumButton.Enabled And (Grid.Row = Grid.RowCount - 1) And
        (Key = VK_DOWN) Then
        ActiveControl := OrderOfMatrixEdit;

    // move up
    If (Grid.Col = 1) And (Grid.Row = 1) And
        ((Key = VK_LEFT) Or (Key = VK_UP)) Then
        ActiveControl := OrderOfMatrixButton;
End;

Procedure TMainForm.ElementsOfMatrixKeyPress(Sender: TObject; Var Key: Char);
Const
    GOOD_KEYS: Set Of Char = ['0' .. '9'];
    MAX_DIGITS: Integer = 3;
Var
    ElementsGrid: TStringGrid;
    TempNumber: String;
Begin
    ElementsGrid := TStringGrid(Sender);
    TempNumber := ElementsGrid.Cells[ElementsGrid.Col, ElementsGrid.Row];
    If (Key = #08) And
        (Length(ElementsGrid.Cells[ElementsGrid.Col, ElementsGrid.Row])
        <> 0) Then
    Begin
        Delete(TempNumber, Length(TempNumber), 1);
        ElementsGrid.Cells[ElementsGrid.Col, ElementsGrid.Row] := TempNumber;
    End;
    // Ограничение символов
    If (Pos('-', TempNumber) = 0) And (Length(TempNumber) > MAX_DIGITS) Then
        Key := #0;
    If (Pos('-', TempNumber) <> 0) And (Length(TempNumber) > MAX_DIGITS + 1) Then
        Key := #0;
    // первый символ
    If (Length(TempNumber) = 0) And ((Key In GOOD_KEYS) Or (Key = '-')) Then
        ElementsGrid.Cells[ElementsGrid.Col, ElementsGrid.Row] :=
            ElementsGrid.Cells[ElementsGrid.Col, ElementsGrid.Row] + Key;
    // второй символ
    if (Pos('0', TempNumber) = 1) then
        key := #0;
    If (Length(TempNumber) = 1) And (Pos('-', TempNumber) = 0) And
        ((Key In GOOD_KEYS) Or (Key = '0')) Then
        ElementsGrid.Cells[ElementsGrid.Col, ElementsGrid.Row] :=
            ElementsGrid.Cells[ElementsGrid.Col, ElementsGrid.Row] + Key;
    If (Length(TempNumber) = 1) And (Pos('-', TempNumber) <> 0) And (Key <> '0') And
        (Key In GOOD_KEYS) Then
        ElementsGrid.Cells[ElementsGrid.Col, ElementsGrid.Row] :=
            ElementsGrid.Cells[ElementsGrid.Col, ElementsGrid.Row] + Key;
    // отрицательные числа
    If (Pos('-', TempNumber) <> 0) And (Key = '-') Then
        Key := #0;
    If (Length(TempNumber) = 1) And (Pos('-', TempNumber) <> 0) And
        (Key = '0') Then
        Key := #0;
    // остальный символы
    If (Length(TempNumber) > 1) And ((Key In GOOD_KEYS) Or (Key = '0')) Then
        ElementsGrid.Cells[ElementsGrid.Col, ElementsGrid.Row] :=
            ElementsGrid.Cells[ElementsGrid.Col, ElementsGrid.Row] + Key;
    // change possition of actionBox
    If (Key = #13) And (ElementsGrid.Col = (ElementsGrid.ColCount - 1)) And
        (ElementsGrid.Row < ElementsGrid.RowCount - 1) Then
    Begin
        ElementsGrid.Row := ElementsGrid.Row + 1;
        ElementsGrid.Col := 1;
    End
    Else If (Key = #13) And (ElementsGrid.Col < ElementsGrid.ColCount - 1) Then
        ElementsGrid.Col := ElementsGrid.Col + 1;
End;

Procedure TMainForm.ElementsOfMatrixKeyUp(Sender: TObject; Var Key: Word;
    Shift: TShiftState);
Var
    Counter, I, J: Integer;
Begin
    Counter := 0;
    For I := 1 To OrderOfMatrix Do
    Begin
        For J := 1 To OrderOfMatrix Do
        Begin
            If (Length(ElementsOfMatrix.Cells[I, J]) <> 0) And
                (ElementsOfMatrix.Cells[I, J] <> '-') Then
            Begin
                SumSearcher.SetElemtentOfMatrix
                    (StrToInt(ElementsOfMatrix.Cells[I, J]), I - 1, J - 1);
                Inc(Counter);
            End;
        End;
    End;
    If Counter = (OrderOfMatrix * OrderOfMatrix) Then
        FindMaxSumButton.Enabled := True
    Else
        FindMaxSumButton.Enabled := False;
End;

Procedure TMainForm.FindMaxSumButtonClick(Sender: TObject);
Begin
    IsFindButtonPressed := True;
    SumSearcher.FindBestSum();
    MaxSumLabel.Caption := 'Наибольшая сумма равна: ' +
        IntToStr(SumSearcher.GetBestSum()) + #46;
    SaveFileButton.Enabled := True;
    IsFileSaved := False;
End;

Procedure TMainForm.FindMaxSumButtonKeyDown(Sender: TObject; Var Key: Word;
    Shift: TShiftState);
Begin
    If (Key = VK_UP) Or (Key = VK_LEFT) Then
        ActiveControl := ElementsOfMatrix;
    If (Key = VK_DOWN) Or (Key = VK_RIGHT) Then
        ActiveControl := OrderOfMatrixEdit;
End;

Procedure TMainForm.FormCloseQuery(Sender: TObject; Var CanClose: Boolean);
Begin
    If Not IsFindButtonPressed Or IsFileSaved Then
    Begin
        Application.CreateForm(TExitForm, ExitForm);
        ExitForm.ShowModal;
        CanClose := ExitForm.GetStatus();
        ExitForm.Destroy();
    End
    Else If IsFindButtonPressed Then
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

Procedure TMainForm.InstructionButtonClick(Sender: TObject);
Begin
    InstructionForm.Show;
End;

Procedure TMainForm.OpenFileButtonClick(Sender: TObject);
Var
    I, J: Integer;
    FileReader: TFileReader;
    Matrix: TMatrix;
Begin
    If OpenDialog1.Execute() Then
    Begin
        FileReader := TFileReader.Create;
        FileReader.SetFileName(OpenDialog1.FileName);
        If FileReader.IsFileGood() Then
        Begin
            OrderOfMatrix := FileReader.InputOrderOfMatrix();
            If FileReader.GetStatus() Then
            Begin
                OrderOfMatrixEdit.Text := IntToStr(OrderOfMatrix);
                OrderOfMatrixButton.Click;
                If SumSearcher <> Nil Then
                    SumSearcher.Destroy();
                SumSearcher := TSumSearcher.Create(OrderOfMatrix);
                Matrix := FileReader.InputElementsOfMatrix(OrderOfMatrix);
                If FileReader.GetStatus() Then
                Begin
                    For I := 1 To OrderOfMatrix Do
                        For J := 1 To OrderOfMatrix Do
                        Begin
                            SumSearcher.SetElemtentOfMatrix
                                (Matrix[I - 1][J - 1], I - 1, J - 1);
                            ElementsOfMatrix.Cells[J, I] :=
                                FloatToStr(Matrix[I - 1][J - 1]);
                        End;
                    FindMaxSumButton.Enabled := True;
                End
                Else
                    MessageBox(MainForm.Handle,
                        'Элементы матрицы введены неправильно! Проверьте данные.',
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
        If Not FileReader.GetStatus() Then
        Begin
            OrderOfMatrixEdit.Text := '';
            ElementsOfMatrix.Visible := False;
            ElementsOfMatrix.Enabled := False;
        End;
        FileReader.Destroy;
        FileReader := Nil;
    End;
End;

Procedure TMainForm.OrderOfMatrixButtonClick(Sender: TObject);
Const
    MIN_SIZE: Integer = 1;
Var
    I, J: Integer;
Begin
    OrderOfMatrix := StrToInt(OrderOfMatrixEdit.Text);
    If MIN_SIZE < OrderOfMatrix Then
    Begin
        // creating Grid
        If SumSearcher <> Nil Then
            SumSearcher.Destroy();
        SumSearcher := TSumSearcher.Create(OrderOfMatrix);
        ElementsOfMatrix.RowCount := OrderOfMatrix + 1;
        ElementsOfMatrix.ColCount := OrderOfMatrix + 1;
        ElementsOfMatrix.FixedCols := 1;
        ElementsOfMatrix.FixedRows := 1;
        ElementsOfMatrix.Cells[0, 0] := '№ элемент';
        For I := 1 To OrderOfMatrix Do
        Begin
            ElementsOfMatrix.Cells[0, I] := IntToStr(I);
            For J := 1 To OrderOfMatrix Do
                ElementsOfMatrix.Cells[J, 0] := IntToStr(J);
        End;
        ElementsOfMatrix.Enabled := True;
        ElementsOfMatrix.Visible := True;
        ElementsOfMatrixInfo.Visible := True;
    End
    Else
        MessageBox(MainForm.Handle, 'Размер матрицы не соответствует границам!',
            'Ой-йой', MB_ICONERROR)
End;

Procedure TMainForm.OrderOfMatrixButtonKeyDown(Sender: TObject; Var Key: Word;
    Shift: TShiftState);
Begin
    If (Key = VK_LEFT) Or (Key = VK_UP) Then
        ActiveControl := OrderOfMatrixEdit;
    If (Key = VK_RIGHT) Or (Key = VK_DOWN) Then
        // ActiveControl := ElementsOfMatrix;
End;

Procedure TMainForm.OrderOfMatrixEditChange(Sender: TObject);
Var
    I, J: Integer;
Begin
    OrderOfMatrixButton.Enabled := Not String.IsNullOrEmpty
        (OrderOfMatrixEdit.Text);
    If Not OrderOfMatrixButton.Enabled Then
    Begin
        ElementsOfMatrix.Enabled := False;
    End;
    If WasOrderOfMatrixChanged Then
    Begin
        MaxSumLabel.Caption := '';
        ElementsOfMatrix.Visible := False;
        ElementsOfMatrixInfo.Visible := False;
        FindMaxSumButton.Enabled := False;
        SaveFileButton.Enabled := False;
        // Очистка всех ячеек StringGrid
        For I := 1 To ElementsOfMatrix.RowCount Do
        Begin
            For J := 1 To ElementsOfMatrix.ColCount Do
            Begin
                ElementsOfMatrix.Cells[J - 1, I - 1] := '';
            End;
        End;
    End;
    WasOrderOfMatrixChanged := True;
End;

Procedure TMainForm.OrderOfMatrixEditKeyDown(Sender: TObject; Var Key: Word;
    Shift: TShiftState);
Var
    CurEdit: TEdit;
Begin
    CurEdit := TEdit(Sender);
    If (OrderOfMatrixButton.Enabled) And (CurEdit.SelLength = 0) And
        ((Key = VK_DOWN) Or (Key = VK_RETURN)) Then
        ActiveControl := OrderOfMatrixButton;
    If (OrderOfMatrixButton.Enabled) And
        (Length(CurEdit.Text) = CurEdit.SelStart) And (Key = VK_RIGHT) Then
        ActiveControl := OrderOfMatrixButton;
    If (FindMaxSumButton.Enabled) And (CurEdit.SelLength = 0) And
        (CurEdit.SelStart = 0) And (Key = VK_LEFT) Then
        ActiveControl := FindMaxSumButton;
    If (FindMaxSumButton.Enabled) And (Key = VK_UP) Then
        ActiveControl := FindMaxSumButton;
    TEdit(Sender).ReadOnly := (Key = VK_INSERT) And
        ((SsShift In Shift) Or (SsCtrl In Shift)) Or (Key = VK_DELETE);
End;

Procedure TMainForm.OrderOfMatrixEditKeyPress(Sender: TObject; Var Key: Char);
Const
    GOOD_KEYS: Set Of Char = ['1' .. '9', #08];
    MAX_DIGITS: Integer = 1;
Var
    Edit: TEdit;
    TempKey: Char;
Begin
    Edit := TEdit(Sender);
    If (Length(Edit.Text) = 0) And Not(Key In GOOD_KEYS) Then
        Key := #0;
    If (Length(Edit.Text) > 0) And Not((Key In GOOD_KEYS) Or (Key = '0')) Then
        Key := #0;
    // for backspace
    If (Length(Edit.Text) > 1) And (Edit.SelStart = 1) And (Edit.Text[2] = '0')
        And (Key = #08) Then
        Key := #0;
    If (Length(Edit.Text) > 1) And (Length(Edit.Text) <> Edit.SelLength) And
        (Edit.SelLength <> 0) And (Edit.SelStart = 0) And
        (Edit.Text[Edit.SelLength + 1] = '0') And Not(Key In ['1' .. '9']) Then
        Key := #0;
    // Key := 0;
    If (Edit.SelStart = 0) And (Key = '0') Then
        Key := #0;
    If (Length(Edit.Text) > MAX_DIGITS) And (Key <> #08) And
        (Edit.SelLength = 0) Then
        Key := #0;
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
            FileWriter.OutputBestSum(SumSearcher.GetBestSum());
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

End.
