Unit MainFomrUnit2_2;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
    System.ImageList, Vcl.ImgList, Vcl.Menus;

Type
    TMainForm = Class(TForm)
        TaskInfo: TLabel;
        KEdit: TEdit;
        KInfo: TLabel;
        FindNumbersButton: TBitBtn;
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
        AnswerLabel: TLabel;
        Procedure InstructionButtonClick(Sender: TObject);
        Procedure AboutTheDeveloperButtonClick(Sender: TObject);
        Procedure KEditKeyPress(Sender: TObject; Var Key: Char);
        Procedure KEditKeyDown(Sender: TObject; Var Key: Word;
            Shift: TShiftState);
        Procedure KEditChange(Sender: TObject);
        Procedure OpenFileButtonClick(Sender: TObject);
        Procedure SaveFileButtonClick(Sender: TObject);
        Procedure FindNumbersButtonClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    Private
        IsFileSaved: Boolean;
    Public
        { Public declarations }
    End;

Var
    MainForm: TMainForm;

Implementation

Uses AboutTheDeveloperUnit2_2, InstructionUnit2_2, BackendUnit2_2;

{$R *.dfm}

Procedure TMainForm.AboutTheDeveloperButtonClick(Sender: TObject);
Begin
    AboutTheDeveloperForm.Show();
End;

Procedure TMainForm.FindNumbersButtonClick(Sender: TObject);
Var
    Numbers: TArrayOfInt;
    I: Integer;
Begin
    SearcherNumbers := TSearcherNumbers.Create();
    SearcherNumbers.SetK(StrToInt(KEdit.Text));
    SearcherNumbers.FindNumbers();
    Numbers := SearcherNumbers.GetNumbers();
    if Numbers[0] > 0 then
    Begin
    AnswerLabel.Caption := 'Числа: ';
    For I := 1 To Numbers[0] Do
        AnswerLabel.Caption := AnswerLabel.Caption + IntToStr(Numbers[I]) + ' ';
    End
    else
        AnswerLabel.Caption := 'Таких чисел не сущетсвует.';
    SaveFileButton.Enabled := True;
End;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
     If Not FindNumbersButton.Enabled Or IsFileSaved Then
        CanClose := MessageBox(MainForm.Handle,
            'Вы действительно хотите выйти?', 'Выход',
            MB_ICONQUESTION + MB_YESNO) = ID_YES
    Else If FindNumbersButton.Enabled Then
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
end;

Procedure TMainForm.InstructionButtonClick(Sender: TObject);
Begin
    InstructionForm.Show();
End;

Procedure TMainForm.KEditChange(Sender: TObject);
Begin
    AnswerLabel.Caption := '';
    FindNumbersButton.Enabled := Not String.IsNullOrEmpty(KEdit.Text);
End;

Procedure TMainForm.KEditKeyDown(Sender: TObject; Var Key: Word;
    Shift: TShiftState);
Begin
    if (FindNumbersButton.Enabled) And (KEdit.SelLength = 0) And (KEdit.SelStart = Length(KEdit.Text)) And (Key = VK_RIGHT) then
        ActiveControl := FindNumbersButton;
    if (FindNumbersButton.Enabled) And (KEdit.SelLength = 0) And (KEdit.SelStart = 0) And (Key = VK_LEFT) then
        ActiveControl := FindNumbersButton;
    If (FindNumbersButton.Enabled) And ((Key = VK_DOWN) Or
        (Key = VK_RETURN)) Then
        ActiveControl := FindNumbersButton;
    TEdit(Sender).ReadOnly := (Key = VK_INSERT) And
        ((SsShift In Shift) Or (SsCtrl In Shift)) Or (Key = VK_DELETE);
End;

Procedure TMainForm.KEditKeyPress(Sender: TObject; Var Key: Char);
Const
    GOOD_KEYS: Set Of Char = ['1' .. '9', #08];
    MAX_DIGITS: Integer = 6;
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
        (TrianglesEdit.Text[TrianglesEdit.SelLength + 1] = '0') And
        Not(Key In ['1' .. '9']) Then
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
    K: Integer;
Begin
    If OpenDialog1.Execute() Then
    Begin
        FileReader := TFileReader.Create();
        FileReader.SetFileName(OpenDialog1.FileName);
        If FileReader.IsFileGood() Then
        Begin
            K := FileReader.InputK();
            If Not FileReader.GetStatus() Then
                MessageBox(MainForm.Handle,
                    'Число К неправильное или не соответствует границам! Проверьте данные.',
                    'Ой-йой', MB_ICONERROR)
            else
                KEdit.Text := IntToStr(K);
        End
            Else
        MessageBox(MainForm.Handle, 'Файл закрыт для чтения или не текстовый! ',
            'Ошибка', MB_ICONERROR);
        FileReader.Destroy();
        FileReader := Nil;
    End
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
            FileWriter.OutputNumbers();
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
