Unit MainFormUnit1_3;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.ImageList, Vcl.ImgList,
    Vcl.StdCtrls, Vcl.Menus, Vcl.Buttons;

Type
    TMainForm = Class(TForm)
        TaskInfo: TLabel;
        OpenDialog1: TOpenDialog;
        SaveDialog1: TSaveDialog;
        MainMenu1: TMainMenu;
        FileButton: TMenuItem;
        OpenFileButton: TMenuItem;
        SaveFileButton: TMenuItem;
        InstructionButton: TMenuItem;
        AboutTheDeveloperButton: TMenuItem;
        PopupMenu1: TPopupMenu;
        IsUserEps: TCheckBox;
        EpsEdit: TEdit;
        XEdit: TEdit;
        XInfo: TLabel;
        BitBtn1: TBitBtn;
        ImageList1: TImageList;
        ShowListButton: TBitBtn;
        AnswerLabel: TLabel;
        Procedure XEditKeyDown(Sender: TObject; Var Key: Word;
            Shift: TShiftState);
        Procedure XEditKeyPress(Sender: TObject; Var Key: Char);
        Procedure IsUserEpsKeyDown(Sender: TObject; Var Key: Word;
            Shift: TShiftState);
        Procedure IsUserEpsClick(Sender: TObject);
        Procedure EpsEditKeyDown(Sender: TObject; Var Key: Word;
            Shift: TShiftState);
        Procedure InstructionButtonClick(Sender: TObject);
        Procedure AboutTheDeveloperButtonClick(Sender: TObject);
        Procedure EpsEditKeyPress(Sender: TObject; Var Key: Char);
        Procedure XEditChange(Sender: TObject);
        Procedure BitBtn1Click(Sender: TObject);
        Procedure ShowListButtonClick(Sender: TObject);
        Procedure FormCloseQuery(Sender: TObject; Var CanClose: Boolean);
        Procedure OpenFileButtonClick(Sender: TObject);
        Procedure SaveFileButtonClick(Sender: TObject);
    Private
        IsFileSaved: Boolean;
    Public
        { Public declarations }
    End;

Var
    MainForm: TMainForm;

Implementation

{$R *.dfm}

Uses AboutTheDeveloperUnit1_3, InstructionUnit1_3, OutputAnswerUnit1_3,
    BackendUnit1_3;

Procedure TMainForm.AboutTheDeveloperButtonClick(Sender: TObject);
Begin
    AboutTheDeveloper.Show;
End;

Procedure TMainForm.BitBtn1Click(Sender: TObject);
Var
    Eps: Real;
    IsEpsCorrect: Boolean;
Begin
    IsEpsCorrect := False;
    If Not IsUserEps.Checked Then
    Begin
        Eps := StrToFloat(EpsEdit.Text);
        If Eps = 0.0 Then
            MessageBox(MainForm.Handle,
                'Epsilon слишком мал! Попробуйте еще раз.', 'Ой-йой',
                MB_ICONEXCLAMATION)
        Else
            IsEpsCorrect := True;
    End
    Else
    Begin
        Eps := 0.001;
        IsEpsCorrect := True;
    End;
    If IsEpsCorrect Then
    Begin
        If Equation = Nil Then
            Equation := TEquation.Create;
        Equation.SetParametersOfEquation(StrToFloat(XEdit.Text), Eps);
        If Equation.IsEquationSolvable() Then
        Begin
            Equation.SolveTheEquation();
            AnswerLabel.Caption := FloatToStr(Equation.GetAnswer());
            IsFileSaved := False;
            SaveFileButton.Enabled := True;
            ShowListButton.Enabled := True;
        End
        Else
            MessageBox(MainForm.Handle,
                'Система не смогла найти решение исходя из данного X! Введите другой X.',
                'Ой-йой', MB_OK);
    End;
End;

Procedure TMainForm.EpsEditKeyDown(Sender: TObject; Var Key: Word;
    Shift: TShiftState);
Begin
    If Key = VK_UP Then
        ActiveControl := IsUserEps;
    If (Key = VK_RETURN) Or (Key = VK_DOWN) Then
        ActiveControl := XEdit;
    TEdit(Sender).ReadOnly := (Key = VK_INSERT) And
        ((SsShift In Shift) Or (SsCtrl In Shift));
End;

Procedure TMainForm.EpsEditKeyPress(Sender: TObject; Var Key: Char);
Const
    MAX_DIGITS: Integer = 15;
    GOOD_KEYS: Set Of Char = ['0' .. '9', #08];
Var
    EpsEdit: TEdit;
Begin
    EpsEdit := TEdit(Sender);
    If (Length(EpsEdit.Text) = 0) And Not(Key = '0') Then
        Key := #0;
    If (Length(EpsEdit.Text) = 1) And (Key <> #44) And (Key <> #08) Then
        Key := #0;
    If (Length(EpsEdit.Text) > 1) And (Not(Key In GOOD_KEYS)) Then
        Key := #0;
    If (Key = #44) And (Pos(',', EpsEdit.Text) <> 0) Then
        Key := #0;
    If (Length(EpsEdit.Text) > 2) And (Pos('0,', EpsEdit.Text) <> 1) And
        (Key <> #08) Then
        Key := #0;
    if ((EpsEdit.SelStart = 1 ) Or (EpsEdit.SelStart = 2)) And (Key = #08) then
        Key := #0;
    If (EpsEdit.SelLength = Length(EpsEdit.Text)) And (EpsEdit.SelLength <> 0)
        And (Key <> #08) Then
        Key := #0;
    If (EpsEdit.SelLength <> Length(EpsEdit.Text)) And
        (EpsEdit.SelLength <> 0) Then
        Key := #0;
    If (Length(EpsEdit.Text) > MAX_DIGITS) And (Key <> #08) And
        (EpsEdit.SelLength = 0) Then
        Key := #0;
        //проверка нулей
    If (Length(EpsEdit.Text) > 0) And (EpsEdit.SelStart = 0) And
         (Key = '0') then
         key := #0;
    if (Length(EpsEdit.Text) > 1) And (EpsEdit.SelStart = 1) And (EpsEdit.Text[2] = '0') And (Key = #08) then
        Key := #0;
    if (Length(EpsEdit.Text) > 1) And (EpsEdit.SelLength <> 0) And (Length(EpsEdit.Text) <> EpsEdit.SelLength) And (EpsEdit.SelStart = 0) And (EpsEdit.Text[EpsEdit.SelLength + 1] = '0')  then
        Key := #0;
    // запятые
    If (Length(EpsEdit.Text) > 0) And (EpsEdit.SelLength = 0) And (EpsEdit.SelStart = 0)
        And ((Key = '0') or (Key = ',')) Then
        Key := #0;
    If (Length(EpsEdit.Text) = 1) And (EpsEdit.SelLength = 0) And (EpsEdit.Text = '0')
        And (Key <> ',') And (Key <> #08) Then
        Key := #0;

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

Procedure TMainForm.InstructionButtonClick(Sender: TObject);
Begin
    Instruction.Show;;
End;

Procedure TMainForm.IsUserEpsClick(Sender: TObject);
Begin
    EpsEdit.Enabled := Not IsUserEps.Checked;
    If IsUserEps.Checked Then
        EpsEdit.Text := '0,001';
End;

Procedure TMainForm.IsUserEpsKeyDown(Sender: TObject; Var Key: Word;
    Shift: TShiftState);
Var
    CheckBox: TCheckBox;
Begin
    CheckBox := TCheckBox(Sender);
    If Key = VK_Return Then
        CheckBox.Checked := Not CheckBox.Checked;
End;

Procedure TMainForm.OpenFileButtonClick(Sender: TObject);
Const
    MIN_X_VALUE: Real = 0.0;
    MAX_X_VALUE: Real = 100000000.0;
    MIN_EPS_VALUE: Real = 1E-15;
    MAX_EPS_VALUE: Real = 1E-2;
Var
    InFile: TextFile;
    X, Eps: Real;
Begin
    If OpenDialog1.Execute Then
    Begin
        Eps := 0.001;
        AssignFile(InFile, OpenDialog1.FileName);
        Try
            ReSet(InFile);
            Try
                Read(InFile, X);
                If Not IsUserEps.Checked Then
                Begin
                    Read(InFile, Eps);
                End;
                If ((MIN_X_VALUE < X) And (X < MAX_X_VALUE)) And
                    ((MIN_EPS_VALUE < Eps) And (Eps < MAX_EPS_VALUE)) Then
                Begin
                    XEdit.Text := FloatToStr(X);
                    If Not IsUserEps.Checked Then
                        EpsEdit.Text := FloatToStr(Eps);
                End
                Else
                    MessageBox(MainForm.Handle,
                        'Число(а) не соответствует границам! Проверьте данные.',
                        'Ой-йой', MB_ICONERROR)
            Except
                MessageBox(MainForm.Handle,
                    'Ошибка чтения из файла. Проверьте данные!', 'Ой-йой',
                    MB_ICONERROR);
            End;
            CloseFile(InFile);
        Except
            MessageBox(MainForm.Handle, 'Файл закрыт для чтения или не текстовый!', 'Ошибка',
                MB_ICONERROR);
        End;
    End;
End;

Procedure TMainForm.SaveFileButtonClick(Sender: TObject);
Var
    OutFile: TextFile;
    Size, I: Integer;
    Answer: Real;
    ArrayOfSteps: TDoubleArrayOfReal;
Begin
    If SaveDialog1.Execute Then
    Begin
        AssignFile(OutFile, SaveDialog1.FileName);
        Try
            ReWrite(OutFile);
            Try
                Answer := Equation.GetAnswer();
                Write(OutFile, 'Ответ равен ', Answer:8, #46, #13#10, #13#10,
                    'Пошаговое решение:', #13#10);
                Write(OutFile, #9, 'N', #9, '|     X - 1', #9, '|', #9,
                    'X', #13#10);
                Write(OutFile,
                    '-------------------------------------------------',
                    #13#10);
                Size := Equation.GetSteps();
                ArrayOfSteps := Equation.GetArrayOfSteps();
                For I := 1 To Size Do
                Begin
                    Write(OutFile, I:9, '|':8, ArrayOfSteps[0][I - 1]:11:5, #9,
                        '|', ArrayOfSteps[1][I - 1]:11:5, #13#10);
                End;
                IsFileSaved := True;
            Except
                MessageBox(MainForm.Handle, 'Упс.. Что-то пошло не так!',
                    'Ой-йой', MB_ICONERROR);
            End;
            CloseFile(OutFile);
        Except
            MessageBox(MainForm.Handle, 'Файл закрыт для записи или не текстовый!', 'Ошибка',
                MB_ICONERROR);
        End;
    End;

End;

Procedure TMainForm.ShowListButtonClick(Sender: TObject);
Begin
    Application.CreateForm(TOutputAnswerUnit, OutputAnswerUnit);
    OutputAnswerUnit.ShowModal;
    OutputAnswerUnit.Destroy;
    OutputAnswerUnit := Nil;
End;

Procedure TMainForm.XEditChange(Sender: TObject);
Begin
    If IsUserEps.Checked Then
        BitBtn1.Enabled := Not String.IsNullOrEmpty(XEdit.Text);
    If Not IsUserEps.Checked Then
        BitBtn1.Enabled := Not String.IsNullOrEmpty(XEdit.Text) And
            Not String.IsNullOrEmpty(EpsEdit.Text);
End;

Procedure TMainForm.XEditKeyDown(Sender: TObject; Var Key: Word;
    Shift: TShiftState);

Begin
    If (Key = VK_UP) Then
    Begin
        If Not(IsUserEps.Checked) Then
            ActiveControl := EpsEdit
        Else
            ActiveControl := IsUserEps;

    End;
    If (BitBtn1.Enabled) And ((Key = VK_RETURN) Or (Key = VK_DOWN)) Then
        ActiveControl := BitBtn1;
    If Not(BitBtn1.Enabled) And (Key = VK_DOWN) Then
        ActiveControl := IsUserEps;
    TEdit(Sender).ReadOnly := (Key = VK_INSERT) And
        ((SsShift In Shift) Or (SsCtrl In Shift)) Or (Key = VK_DELETE);
End;

Procedure TMainForm.XEditKeyPress(Sender: TObject; Var Key: Char);
Const
    GOOD_KEYS: Set Of Char = ['0' .. '9', #08];
    MAX_DIGITS: Integer = 10;
Var
    Edit: TEdit;
    TempKey: Char;
Begin
    Edit := TEdit(Sender);
    // new Code
    If (Length(Edit.Text) = 0) And Not(Key In GOOD_KEYS) Then
        Key := #0;
    If (Length(Edit.Text) > 0) And (Not((Key In GOOD_KEYS) Or (Key = #44))) Then
        Key := #0;
    If (Key = #44) And (Pos(',', Edit.Text) <> 0) Then
        Key := #0;
    If (Edit.SelLength <> 0) And Not(Key In GOOD_KEYS) Then
        Key := #0;
    If (Length(Edit.Text) > MAX_DIGITS) And (Key <> #08) And
        (Edit.SelLength = 0) Then
        Key := #0;
    If (Pos(',', Edit.Text) <> 0) And Not(Key In GOOD_KEYS) Then
        Key := #0;
    If (Pos('0,', Edit.Text) = 1) And Not(Key In GOOD_KEYS) Then
        Key := #0;
    //проверка нулей
    If (Length(Edit.Text) > 0) And (Edit.SelStart = 0) And
         (Key = '0') then
         key := #0;
    if (Length(Edit.Text) > 1) And (Edit.SelStart = 1) And (Edit.Text[2] = '0') And (Key = #08) then
        Key := #0;
    if (Length(Edit.Text) > 1) And (Edit.SelLength <> 0) And (Length(Edit.Text) <> Edit.SelLength) And (Edit.SelStart = 0) And (Edit.Text[Edit.SelLength + 1] = '0') And Not(Key In ['1'..'9']) then
        Key := #0;
    // запятые
    If (Length(Edit.Text) > 0) And (Edit.SelLength = 0) And (Edit.SelStart = 0)
        And ((Key = '0') or (Key = ',')) Then
        Key := #0;
    If (Length(Edit.Text) = 1) And (Edit.SelLength = 0) And (Edit.Text = '0')
        And (Key <> ',') And (Key <> #08) Then
        Key := #0;
End;

End.
