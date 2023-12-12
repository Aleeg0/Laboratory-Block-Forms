Unit MainFormUnit3_3;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, System.ImageList,
    Vcl.ImgList, Vcl.Grids, Vcl.StdCtrls, Vcl.Menus;

Type
    TMainForm = Class(TForm)
        TaskInfo: TLabel;
        SizeInfo: TLabel;
        SizeEdit: TEdit;
        SizeButton: TButton;
        ElementsOfArray: TStringGrid;
        ImageList1: TImageList;
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
    SortArrayButton: TBitBtn;
    ShowListButton: TBitBtn;
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
        Procedure SortArrayButtonClick(Sender: TObject);
        Procedure ShowListButtonClick(Sender: TObject);
        Procedure OpenFileButtonClick(Sender: TObject);
        Procedure SaveFileButtonClick(Sender: TObject);

        Procedure ElementsOfArrayKeyUp(Sender: TObject; Var Key: Word;
            Shift: TShiftState);
    procedure SortArrayButtonKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    Private
        Size: Integer;
        IsFileSaved: Boolean;
        IsArrayFilled: Boolean;
        IsSortButtonPressed : Boolean;
        WasChanges: Boolean;
    Public
        { Public declarations }
    End;

Var
    MainForm: TMainForm;

Implementation

{$R *.dfm}

Uses InstructionUnit3_3, AboutTheDeveloperUnit3_3, BackendUnit3_3,
    OutputSortedArrayUnit3_3, ExitUnit3_3;

Procedure TMainForm.AboutTheDeveloperButtonClick(Sender: TObject);
Begin
    AboutTheDeveloper.Show;
End;

Procedure TMainForm.InstructionButtonClick(Sender: TObject);
Begin
    Instruction.Show;
End;

Procedure TMainForm.OpenFileButtonClick(Sender: TObject);
Var
    FileReader: TFileReader;
    I: Integer;
    Arr : TArray;
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
                    Begin
                        ElementsOfArray.Cells[I, 1] := IntToStr(Arr[I - 1]);
                        ArraySorter.SetElementByIndex(Arr[I - 1], I - 1);
                    End;
                    SortArrayButton.Enabled := True;
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
            FileWriter.OutputArray(ArraySorter.GetSortedArray(), Size);
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
    Application.CreateForm(TOutputSortedArray, OutputSortedArray);
    OutputSortedArray.ShowModal;
    OutputSortedArray.Destroy;
    OutputSortedArray := Nil;
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
        if ArraySorter <> nil then
            ArraySorter.Destroy();
        ArraySorter := TArraySorter.Create(Size);
        ElementsOfArray.RowCount := 2;
        ElementsOfArray.ColCount := Size + 1;
        ElementsOfArray.FixedCols := 1;
        ElementsOfArray.FixedRows := 1;
        ElementsOfArray.Cells[0, 0] := '№';
        ElementsOfArray.Cells[0, 1] := 'Элемент';
        For I := 1 To Size Do
            ElementsOfArray.Cells[I, 0] := IntToStr(I);
        ElementsOfArray.Enabled := True;
        ElementsInfo.Visible := True;
        ElementsOfArray.Visible := True;
        SortArrayButton.Visible := True;
        ShowListButton.Visible := True;
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
        SortArrayButton.Visible := False;
        ShowListButton.Visible := False;
        SortArrayButton.Enabled := False;
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

Procedure TMainForm.SortArrayButtonClick(Sender: TObject);
Begin
    ArraySorter.MergeSort(0,Size);
    ShowListButton.Enabled := True;
    SaveFileButton.Enabled := True;
    IsFileSaved := False;
    IsSortButtonPressed := True;
End;


procedure TMainForm.SortArrayButtonKeyDown(Sender: TObject; var Key: Word;
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
    ShowListButton.Enabled := False;
    IsSortButtonPressed := False;
    SaveFileButton.Enabled := False;
    IsFileSaved := False;
    If Key = VK_UP Then
        ActiveControl := SizeButton;
    If (SortArrayButton.Enabled) And (Key = VK_DOWN) Then
        ActiveControl := SortArrayButton
    Else If Not(SortArrayButton.Enabled) And (Key = VK_DOWN) Then
        ActiveControl := SizeEdit;
    If (SortArrayButton.Enabled) And (IsArrayFilled) And
        (Key = VK_RETURN) Then
        ActiveControl := SortArrayButton;
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
            ArraySorter.SetElementByIndex(StrToInt(ElementsOfArray.Cells[I, 1]), I - 1);
            Inc(Counter);
        End;
    End;
    If Counter = Size Then
        IsArrayFilled := True
    Else
        IsArrayFilled := False;
    SortArrayButton.Enabled := IsArrayFilled;
End;



procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
Begin
    If Not IsSortButtonPressed Or IsFileSaved Then
    Begin
        Application.CreateForm(TExitForm, ExitForm);
        ExitForm.ShowModal;
        CanClose := ExitForm.GetStatus();
        ExitForm.Destroy();
    End
    Else If IsSortButtonPressed Then
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
