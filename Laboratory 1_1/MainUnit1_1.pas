Unit MainUnit1_1;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus, Vcl.ExtDlgs,
    Vcl.CustomizeDlg;

Type
    TMainForm = Class(TForm)
        MainMenu1: TMainMenu;
        InstructionButton: TMenuItem;
        AboutTheDeveloperButton: TMenuItem;
        Task: TLabel;
        InfoNum1: TLabel;
        Num1Edit: TEdit;
        InfoNum2: TLabel;
        Num2Edit: TEdit;
        Button1: TButton;
        Answer: TLabel;
        AnswerInfo: TLabel;
        FileButton: TMenuItem;
        Open: TMenuItem;
        Save: TMenuItem;
        OpenDialog1: TOpenDialog;
        SaveDialog1: TSaveDialog;
        PopupMenu1: TPopupMenu;
        Procedure Button1Click(Sender: TObject);
        Procedure InstructionButtonClick(Sender: TObject);
        Procedure NumEditKeyPress(Sender: TObject; Var Key: Char);
        Procedure NumEditChange(Sender: TObject);
        Procedure FormCloseQuery(Sender: TObject; Var CanClose: Boolean);
        Procedure OpenClick(Sender: TObject);
        Procedure Num1EditKeyDown(Sender: TObject; Var Key: Word;
            Shift: TShiftState);
        Procedure Num2EditKeyDown(Sender: TObject; Var Key: Word;
            Shift: TShiftState);
        Procedure SaveClick(Sender: TObject);
        Procedure AboutTheDeveloperButtonClick(Sender: TObject);
        Function FormHelp(Command: Word; Data: NativeInt;
            Var CallHelp: Boolean): Boolean;
    Private
        Num1: Real;
        Num2: Real;
        ArithmeticAvg: Real;
        GeometricAvg: Real;

    Public
        { Public declarations }
    End;

Var
    MainForm: TMainForm;

Implementation

{$R *.dfm}

Uses AboutDeveloperUnit1_1, InstructionUnit1_1;

Procedure TMainForm.AboutTheDeveloperButtonClick(Sender: TObject);
Begin
    AboutTheDeveloper.Show;
End;

Procedure TMainForm.Button1Click(Sender: TObject);
Begin
    Num1 := StrToFloat(Num1Edit.Text);
    Num2 := StrToFloat(Num2Edit.Text);
    ArithmeticAvg := (Num1 + Num2) / 2;
    GeometricAvg := Sqrt(Num1 * Num2);
    Answer.Caption := 'Среднее арифметическое: ' + FloatToStr(ArithmeticAvg) +
        #13#10 + 'Среднее геометрическое: ' + FloatToStr(GeometricAvg) + #13#10;
    If ArithmeticAvg = GeometricAvg Then
        Answer.Caption := Answer.Caption +
            'Среднее арифметическое = Среднее геометрическое'
    Else
        Answer.Caption := Answer.Caption +
            'Среднее арифметическое > Среднее геометрическое';
    Save.Enabled := True;
End;

Procedure TMainForm.FormCloseQuery(Sender: TObject; Var CanClose: Boolean);
Begin
    CanClose := MessageBox(MainForm.Handle, 'Вы действительно хотите выйти?',
        'Выход', MB_ICONQUESTION + MB_YESNO) = ID_YES;
End;

Function TMainForm.FormHelp(Command: Word; Data: NativeInt;
    Var CallHelp: Boolean): Boolean;
Begin
    CallHelp := False;
End;

Procedure TMainForm.InstructionButtonClick(Sender: TObject);
Begin
    Instruction.Show;
End;

Procedure TMainForm.Num1EditKeyDown(Sender: TObject; Var Key: Word;
    Shift: TShiftState);
Var
    KeyInput: Char;
    CurEdit: TEdit;
Begin
    CurEdit := TEdit(Sender);
    If (Key = VK_DOWN) Or (Key = VK_RETURN) Then
        ActiveControl := Num2Edit;
    If (Button1.Enabled) And (Key = VK_UP) Then
        ActiveControl := Button1;
    CurEdit.ReadOnly := ((SsShift In Shift) Or (SsCtrl In Shift));
        // for delete
    If (Key = VK_DELETE) And (Length(CurEdit.Text) > 1) And
        (CurEdit.SelStart = 0) And (CurEdit.Text[2] = '0') And
        Not(CurEdit.SelLength = Length(CurEdit.Text)) Then
        Key := 0;
End;

Procedure TMainForm.Num2EditKeyDown(Sender: TObject; Var Key: Word;
    Shift: TShiftState);
Var
    CurEdit: TEdit;
Begin
    CurEdit := TEdit(Sender);
    If Key = VK_UP Then
        ActiveControl := Num1Edit;
    If (Button1.Enabled) And ((Key = VK_RETURN) Or (Key = VK_DOWN)) Then
        ActiveControl := Button1;
    CurEdit.ReadOnly := (Key = VK_INSERT) And
        ((SsShift In Shift) Or (SsCtrl In Shift));
    // for delete
    If (Key = VK_DELETE) And (Length(CurEdit.Text) > 1) And
        (CurEdit.SelStart = 0) And (CurEdit.Text[2] = '0') And
        Not(CurEdit.SelLength = Length(CurEdit.Text)) Then
        Key := 0;
End;

Procedure TMainForm.NumEditChange(Sender: TObject);
Begin
    Button1.Enabled := Not String.IsNullOrEmpty(Num1Edit.Text) And
        Not String.IsNullOrEmpty(Num2Edit.Text);
End;

Procedure TMainForm.NumEditKeyPress(Sender: TObject; Var Key: Char);
Const
    GOOD_KEYS: Set Of Char = ['1' .. '9', #08];
    MAX_DIGITS: Integer = 8;
Var
    Edit: TEdit;
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

Procedure TMainForm.OpenClick(Sender: TObject);
Const
    MAX_NUM_VALUE: Real = 1000000000;
Var
    InFile: TextFile;
    Num: Real;
Begin
    If OpenDialog1.Execute Then
    Begin
        AssignFile(InFile, OpenDialog1.FileName);
        Try
            ReSet(InFile);
            Try
                Read(InFile, Num);
                If (0.0 < Num) And (Num < MAX_NUM_VALUE) Then
                Begin
                    Num1Edit.Text := FloatToStr(Num);
                    Read(InFile, Num);
                    If (0.0 < Num) And (Num < MAX_NUM_VALUE) Then
                        Num2Edit.Text := FloatToStr(Num)
                    Else
                        MessageBox(MainForm.Handle,
                            'Число не соответствует границам! Проверьте данные.',
                            'Ошибка', MB_ICONERROR)
                End
                Else
                    MessageBox(MainForm.Handle,
                        'Число не соответствует границам! Проверьте данные.',
                        'Ошибка', MB_ICONERROR);

            Except
                MessageBox(MainForm.Handle,
                    'Ошибка чтения из файла! Проверьте данные.', 'Ошибка',
                    MB_ICONERROR);
            End;
            CloseFile(InFile);
        Except
            MessageBox(MainForm.Handle,
                'Файл закрыт для чтения или не текстовый!', 'Ошибка',
                MB_ICONERROR);
        End;
    End;
End;

Procedure TMainForm.SaveClick(Sender: TObject);
Var
    OutFile: TextFile;
Begin
    If SaveDialog1.Execute Then
    Begin
        If FileExists(SaveDialog1.FileName) Then
        Begin
            AssignFile(OutFile, SaveDialog1.FileName);
            Try
                ReWrite(OutFile);
                Try
                    Write(OutFile, Answer.Caption);
                Except
                    MessageBox(MainForm.Handle, 'Упс.. Что-то пошло не так!',
                        'Ошибка', MB_ICONERROR);
                End;
                CloseFile(OutFile);
            Except
                MessageBox(MainForm.Handle,
                    'Файл закрыт для записи или не текстовый!', 'Ошибка',
                    MB_ICONERROR);
            End;
        End
        Else
            MessageBox(MainForm.Handle, 'Введен не существующий файл!',
                'Ой-йой', MB_ICONERROR);
    End;

End;

End.
