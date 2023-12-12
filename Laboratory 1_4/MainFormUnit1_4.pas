Unit MainFormUnit1_4;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, System.ImageList,
    Vcl.ImgList, Vcl.Grids, Vcl.StdCtrls, Vcl.Menus;

Type
    TArrayOfInt = Array Of Integer;

    TMainForm = Class(TForm)
        TaskInfo: TLabel;
        SizeInfo: TLabel;
        SizeEdit: TEdit;
        SizeButton: TButton;
        ElementsOfArray: TStringGrid;
        CreateBArrayButton: TButton;
        ImageList1: TImageList;
        ShowListButton: TBitBtn;
        OpenDialog1: TOpenDialog;
        SaveDialog1: TSaveDialog;
        MainMenu1: TMainMenu;
        FileButton: TMenuItem;
        OpenFileButton: TMenuItem;
        SaveFileButton: TMenuItem;
        InstructionButton: TMenuItem;
        AboutTheDeveloperButton: TMenuItem;
        PopupMenu1: TPopupMenu;
        ElementsInfo: TLabel;
        Procedure SizeEditKeyDown(Sender: TObject; Var Key: Word;
            Shift: TShiftState);
        Procedure SizeEditKeyPress(Sender: TObject; Var Key: Char);
        Procedure InstructionButtonClick(Sender: TObject);
        Procedure AboutTheDeveloperButtonClick(Sender: TObject);
        Procedure SizeEditChange(Sender: TObject);
        Procedure ElementsOfArrayKeyDown(Sender: TObject; Var Key: Word;
            Shift: TShiftState);
        Procedure SizeButtonClick(Sender: TObject);
        Procedure ElementsOfArrayKeyPress(Sender: TObject; Var Key: Char);
        Procedure CreateBArrayButtonKeyDown(Sender: TObject; Var Key: Word;
            Shift: TShiftState);
        Procedure CreateBArrayButtonClick(Sender: TObject);
        Procedure ShowListButtonClick(Sender: TObject);
        Procedure OpenFileButtonClick(Sender: TObject);
        Procedure SaveFileButtonClick(Sender: TObject);
        Procedure FormCloseQuery(Sender: TObject; Var CanClose: Boolean);
        Procedure ElementsOfArrayKeyUp(Sender: TObject; Var Key: Word;
            Shift: TShiftState);
    Private
        Size: Integer;
        Arr: TArrayOfInt;
        IsFileSaved: Boolean;
        IsArrayFilled: Boolean;
        WasChanges: Boolean;
    Public
        { Public declarations }
    End;

Var
    MainForm: TMainForm;

Implementation

{$R *.dfm}

Uses InstructionUnit1_4, AboutTheDeveloperUnit1_4, BackEndUnit1_4,
    OutputArrayBUnit1_4;

Procedure TMainForm.AboutTheDeveloperButtonClick(Sender: TObject);
Begin
    AboutTheDeveloper.Show;
End;

Procedure TMainForm.InstructionButtonClick(Sender: TObject);
Begin
    InstructionForm.Show;
End;

Procedure TMainForm.OpenFileButtonClick(Sender: TObject);
Var
    FileReader: TFileReader;
    I: Integer;
Begin
    If OpenDialog1.Execute() Then
    Begin
        FileReader := TFileReader.Create;
        FileReader.SetFileName(OpenDialog1.FileName);
        If FileReader.IsFileGood() Then
        Begin
            Size := FileReader.InputSize();
            If FileReader.GetStatus() Then
            Begin
                SizeEdit.Text := IntToStr(Size);
                SizeButton.Click;
                Arr := FileReader.InputArray(Size);
                If FileReader.GetStatus() Then
                Begin
                    For I := 1 To Size Do
                        ElementsOfArray.Cells[I, 1] := IntToStr(Arr[I - 1]);
                    CreateBArrayButton.Enabled := True;
                End
                Else
                    MessageBox(MainForm.Handle,
                        'Элементы массива введены неправильно! Проверьте данные.',
                        'Ой-йой', MB_ICONERROR)
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
            SizeEdit.Text := '';
            SizeButton.Enabled := False;
            ElementsOfArray.Enabled := False;
            ElementsOfArray.Visible := False;
        End;
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
            FileWriter.OutputArray(Transformator.GetTransformatedArray(), Size);
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

Procedure TMainForm.ShowListButtonClick(Sender: TObject);
Begin
    Application.CreateForm(TOutputArrayB, OutputArrayB);
    OutputArrayB.ShowModal;
    OutputArrayB.Destroy;
    OutputArrayB := Nil;
End;

Procedure TMainForm.SizeButtonClick(Sender: TObject);
Const
    MAX_SIZE: Integer = 1000;
    MIN_SIZE: Integer = 0;
Var
    I: Integer;
Begin
    // creating Grid
    Size := StrToInt(SizeEdit.Text);
    If (MIN_SIZE < Size) And (Size < MAX_SIZE) Then
    Begin
        ElementsOfArray.RowCount := 2;
        ElementsOfArray.ColCount := Size + 1;
        ElementsOfArray.FixedCols := 1;
        ElementsOfArray.FixedRows := 1;
        ElementsOfArray.Cells[0, 0] := '№';
        ElementsOfArray.Cells[0, 1] := 'Элемент';
        For I := 1 To Size Do
            ElementsOfArray.Cells[I, 0] := IntToStr(I);
        If Arr <> Nil Then
            Arr := Nil;
        SetLength(Arr, Size);
        ElementsOfArray.Enabled := True;
        ElementsInfo.Visible := True;
        ElementsOfArray.Visible := True;
    End
    Else
        MessageBox(MainForm.Handle,
            'Размер не соответствует границам! Проверьте данные.', 'Ой-йой',
            MB_ICONERROR);

End;

Procedure TMainForm.SizeEditChange(Sender: TObject);
Var
    I, J: Integer;
Begin
    SizeButton.Enabled := Not String.IsNullOrEmpty(SizeEdit.Text);
    If Not SizeButton.Enabled Then
    Begin
        ElementsOfArray.Enabled := False;
    End;
    If WasChanges Then
    Begin
        // Очистка всех ячеек StringGrid
        For I := 1 To ElementsOfArray.RowCount Do
        Begin
            For J := 1 To ElementsOfArray.ColCount Do
            Begin
                ElementsOfArray.Cells[J - 1, I - 1] := '';
            End;
        End;
        IsArrayFilled := False;
        ElementsInfo.Visible := False;
        ElementsOfArray.Visible := False;
        CreateBArrayButton.Enabled := False;
        ShowListButton.Enabled := False;
        SaveFileButton.Enabled := False;
    End;
    WasChanges := True;
End;

Procedure TMainForm.SizeEditKeyDown(Sender: TObject; Var Key: Word;
    Shift: TShiftState);
Begin
    If (SizeButton.Enabled) And (SizeEdit.SelLength = 0) And
        ((Key = VK_DOWN) Or (Key = VK_RETURN)) Then
        ActiveControl := SizeButton;
    If (SizeButton.Enabled) And (SizeEdit.SelStart = Length(SizeEdit.Text)) And
        ((Key = VK_RIGHT)) Then
        ActiveControl := SizeButton;
    If (ShowListButton.Enabled) And ((Key = VK_UP) Or (Key = VK_LEFT)) Then
        ActiveControl := ShowListButton;
    TEdit(Sender).ReadOnly := (Key = VK_INSERT) And
        ((SsShift In Shift) Or (SsCtrl In Shift)) Or (Key = VK_DELETE);
End;

Procedure TMainForm.SizeEditKeyPress(Sender: TObject; Var Key: Char);
Const
    GOOD_KEYS: Set Of Char = ['1' .. '9', #08];
    MAX_DIGITS: Integer = 1;
Var
    SizeEdit: TEdit;
    TempKey: Char;
Begin
    SizeEdit := TEdit(Sender);
    If (Length(SizeEdit.Text) = 0) And Not(Key In GOOD_KEYS) Then
        Key := #0;
    If (Length(SizeEdit.Text) > 0) And
        Not((Key In GOOD_KEYS) Or (Key = '0')) Then
        Key := #0;
    If (Length(SizeEdit.Text) > 1) And (SizeEdit.SelStart = 1) And
        (SizeEdit.Text[2] = '0') And (Key = #08) Then
        Key := #0;
    // for backspace
    If (Length(SizeEdit.Text) > 1) And
        (Length(SizeEdit.Text) <> SizeEdit.SelLength) And
        (SizeEdit.SelLength <> 0) And (SizeEdit.SelStart = 0) And
        (SizeEdit.Text[SizeEdit.SelLength + 1] = '0') And
        Not(Key In ['1' .. '9']) Then
        Key := #0;
    If (SizeEdit.SelStart = 0) And (Key = '0') Then
        Key := #0;
    // Key := 0;
    If (Length(SizeEdit.Text) > MAX_DIGITS) And (Key <> #08) And
        (SizeEdit.SelLength = 0) Then
        Key := #0;
End;

Procedure TMainForm.CreateBArrayButtonClick(Sender: TObject);
Begin
    If Transformator = Nil Then
        Transformator := TArrayTransformator.Create;
    Transformator.SetUsersArray(Arr);
    Transformator.Transformation();
    ShowListButton.Enabled := True;
    SaveFileButton.Enabled := True;
    IsFileSaved := False;
End;

Procedure TMainForm.CreateBArrayButtonKeyDown(Sender: TObject; Var Key: Word;
    Shift: TShiftState);
Begin
    If (ShowListButton.Enabled) And ((Key = VK_DOWN) Or (Key = VK_RETURN)) Then
        ActiveControl := ShowListButton;
    If (Key = VK_UP) Then
        ActiveControl := ElementsOfArray;
End;

Procedure TMainForm.ElementsOfArrayKeyDown(Sender: TObject; Var Key: Word;
    Shift: TShiftState);
Begin
    If Key = VK_UP Then
        ActiveControl := SizeButton;
    If (CreateBArrayButton.Enabled) And (Key = VK_DOWN) Then
        ActiveControl := CreateBArrayButton
    Else If Not(CreateBArrayButton.Enabled) And (Key = VK_DOWN) Then
        ActiveControl := SizeEdit;
    If (CreateBArrayButton.Enabled) And (IsArrayFilled) And
        (Key = VK_RETURN) Then
        ActiveControl := CreateBArrayButton;
End;

Procedure TMainForm.ElementsOfArrayKeyPress(Sender: TObject; Var Key: Char);
Const
    GOOD_KEYS: Set Of Char = ['0' .. '9'];
    MAX_DIGITS: Integer = 4;
Var
    ArrGrid: TStringGrid;
    TempNumber: String;
Begin
    ArrGrid := TStringGrid(Sender);
    TempNumber := ArrGrid.Cells[ArrGrid.Col, 1];
    If (Length(TempNumber) = 1) And (TempNumber = '0') And (Key <> #08) Then
        Key := #0;
    If (Key = #08) And (Length(ArrGrid.Cells[ArrGrid.Col, 1]) <> 0) Then
    Begin
        Delete(TempNumber, Length(TempNumber), 1);
        ArrGrid.Cells[ArrGrid.Col, 1] := TempNumber;
    End;
    If (Key <> #0) And (Length(TempNumber) = 0) And (Key = '-') Then
        ArrGrid.Cells[ArrGrid.Col, 1] := ArrGrid.Cells[ArrGrid.Col, 1] + Key;
    If (Length(TempNumber) = 1) And (TempNumber = '-') And (Key = '0') Then
        Key := #0;
    If (Key <> #0) And (Pos('-', TempNumber) = 0) And (Key In GOOD_KEYS) And
        (Length(TempNumber) < MAX_DIGITS) Then
        ArrGrid.Cells[ArrGrid.Col, 1] := ArrGrid.Cells[ArrGrid.Col, 1] + Key;
    If (Key <> #0) And (Pos('-', TempNumber) = 1) And (Key In GOOD_KEYS) And
        (Length(TempNumber) < MAX_DIGITS + 1) Then
        ArrGrid.Cells[ArrGrid.Col, 1] := ArrGrid.Cells[ArrGrid.Col, 1] + Key;
    If (Key <> #0) And (Pos('-', TempNumber) = 1) And (Key = '0') Then
        Key := #0;
    // Раскомментировать для извращенцов!!!
    // if (Length(ArrGrid.Cells[ArrGrid.Col,1]) = 0) And (Key = #08) And (1 < ArrGrid.Col) then
    // ArrGrid.Col := ArrGrid.Col - 1;
    If (Key = #13) And (ArrGrid.Col < ArrGrid.ColCount - 1) Then
        ArrGrid.Col := ArrGrid.Col + 1;

End;

Procedure TMainForm.ElementsOfArrayKeyUp(Sender: TObject; Var Key: Word;
    Shift: TShiftState);
Var
    Counter, I: Integer;
Begin
    Counter := 0;
    For I := 1 To Size Do
    Begin
        If (Length(ElementsOfArray.Cells[I, 1]) <> 0) And
            (ElementsOfArray.Cells[I, 1] <> '-') Then
        Begin
            Arr[I - 1] := StrToInt(ElementsOfArray.Cells[I, 1]);
            Inc(Counter);
        End;
    End;
    If Counter = Size Then
        IsArrayFilled := True
    Else
        IsArrayFilled := False;
    CreateBArrayButton.Enabled := IsArrayFilled;
End;

Procedure TMainForm.FormCloseQuery(Sender: TObject; Var CanClose: Boolean);
Var
    ExitCode: Integer;
Begin
    If Not ShowListButton.Enabled Or IsFileSaved Then
        CanClose := MessageBox(MainForm.Handle,
            'Вы действительно хотите выйти?', 'Выход',
            MB_ICONQUESTION + MB_YESNO) = ID_YES
    Else If ShowListButton.Enabled Then
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

End.
