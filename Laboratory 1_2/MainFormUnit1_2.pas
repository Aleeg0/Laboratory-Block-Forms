Unit MainFormUnit1_2;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
    Vcl.Imaging.Pngimage, Vcl.Menus;

Type
    TMainForm = Class(TForm)
        TaskInfo: TLabel;
        TaskImage: TImage;
        SIzeInfo: TLabel;
        SizeEdit: TEdit;
        Sum: TLabel;
        Button1: TButton;
        MainMenu1: TMainMenu;
        FileButton: TMenuItem;
        OpenFileButton: TMenuItem;
        SaveFileButton: TMenuItem;
        InstructionButton: TMenuItem;
        AboutTheDeveloperButton: TMenuItem;
        PopupMenu1: TPopupMenu;
        OpenDialog1: TOpenDialog;
        SaveDialog1: TSaveDialog;
        Procedure SizeEditKeyDown(Sender: TObject; Var Key: Word;
            Shift: TShiftState);
        Procedure SizeEditKeyPress(Sender: TObject; Var Key: Char);
        Procedure SizeEditChange(Sender: TObject);
        Procedure Button1Click(Sender: TObject);
        Procedure InstructionButtonClick(Sender: TObject);
        Procedure AboutTheDeveloperButtonClick(Sender: TObject);
        Procedure OpenFileButtonClick(Sender: TObject);
        Procedure SaveFileButtonClick(Sender: TObject);
        Procedure FormCloseQuery(Sender: TObject; Var CanClose: Boolean);
    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Var
    MainForm: TMainForm;

Implementation

{$R *.dfm}

Uses AboutTheDeveloperUnit1_2, InstructionUnit1_2;

Procedure TMainForm.AboutTheDeveloperButtonClick(Sender: TObject);
Begin
    AboutTheDeveloper.Show;
End;

Procedure TMainForm.Button1Click(Sender: TObject);
Var
    Low, High: Integer;
    NumberInLoop: Int64;
Begin
    High := StrToInt(SizeEdit.Text);
    NumberInLoop := 1;
    For Low := 1 To High Do
    Begin
        NumberInLoop := NumberInLoop * (-2);
    End;
    Sum.Caption := 'Сумма равна ' + IntToStr(NumberInLoop) + #46;
    SaveFileButton.Enabled := True;
End;

Procedure TMainForm.FormCloseQuery(Sender: TObject; Var CanClose: Boolean);
Begin
    CanClose := MessageBox(MainForm.Handle, 'Вы действительно хотите выйти?',
        'Выход', MB_ICONQUESTION + MB_YESNO) = ID_YES;
End;

Procedure TMainForm.InstructionButtonClick(Sender: TObject);
Begin
    Instruction.Show;
End;

Procedure TMainForm.OpenFileButtonClick(Sender: TObject);
Const
    MAX_NUM_VALUE: Integer = 60;
Var
    InFile: TextFile;
    Num: Integer;
Begin
    If OpenDialog1.Execute Then
    Begin
        AssignFile(InFile, OpenDialog1.FileName);
        Try
            ReSet(InFile);
            Try
                Read(InFile, Num);
                If (0 < Num) And (Num < MAX_NUM_VALUE) Then
                    SizeEdit.Text := IntToStr(Num)
                Else
                    MessageBox(MainForm.Handle,
                        'Число не соответствует границам! Проверьте данные.',
                        'Ой-йой', MB_ICONERROR);
            Except
                MessageBox(MainForm.Handle,
                    'Ошибка чтения из файла! Проверьте данные.', 'Ой-йой',
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
Begin
    If SaveDialog1.Execute Then
    Begin
        AssignFile(OutFile, SaveDialog1.FileName);
        Try
            ReWrite(OutFile);
            Try
                Write(OutFile, Sum.Caption);
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

Procedure TMainForm.SizeEditChange(Sender: TObject);
Var
    Size: Integer;
Begin
    Button1.Enabled := Not String.IsNullOrEmpty(SizeEdit.Text);
End;

Procedure TMainForm.SizeEditKeyDown(Sender: TObject; Var Key: Word;
    Shift: TShiftState);
Begin
    If (Button1.Enabled) And ((Key = VK_RETURN) Or (Key = VK_DOWN)) Then
        ActiveControl := Button1;
    TEdit(Sender).ReadOnly := (Key = VK_INSERT) And
        ((SsShift In Shift) Or (SsCtrl In Shift)) Or (Key = VK_DELETE);
End;

Procedure TMainForm.SizeEditKeyPress(Sender: TObject; Var Key: Char);
Const
    GOOD_KEYS: Set Of Char = ['1' .. '9', #08];
    MAX_DIGITS: Integer = 1;
Var
    Edit: TEdit;
    TempKey: Char;
Begin
    Edit := TEdit(Sender);
    If (Length(Edit.Text) = 0) And Not(Key In ['1' .. '5'] ) Then
        Key := #0;
    If (Length(Edit.Text) > 0) And
        Not((Key In GOOD_KEYS) Or (Key = '0')) Then
        Key := #0;
    // for backspace
    If (Length(Edit.Text) > 1) And (Edit.SelStart = 1) And
        (Edit.Text[2] = '0') And (Key = #08) Then
        Key := #0;
    If (Length(Edit.Text) > 1) And
        (Length(Edit.Text) <> Edit.SelLength) And
        (Edit.SelLength <> 0) And (Edit.SelStart = 0) And
        (Edit.Text[Edit.SelLength + 1] = '0') And Not(Key in ['1'..'5']) Then
        Key := #0;
    // Key := 0;
    If (Edit.SelStart = 0) And (Key = '0') Then
        Key := #0;
    If (Length(Edit.Text) > MAX_DIGITS) And (Key <> #08) And
        (Edit.SelLength = 0) Then
        Key := #0;
    // доп для данного задания
    If (Length(Edit.Text) > 1) And
        (Edit.SelLength <> 0) And (Edit.SelStart = 0) And Not(Key in ['1'..'5',#08]) Then
        Key := #0;
End;

End.
