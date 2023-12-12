Unit MainFormUnit3_2;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.ImageList,
    Vcl.ImgList, Vcl.Menus, Vcl.Buttons;

Type
    TMainForm = Class(TForm)
        TaskInfo: TLabel;
        UsersStringEdit: TEdit;
    OutputSetLabel: TLabel;
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
        StringInfoLabel: TLabel;
    CreateSetButton: TBitBtn;
        Procedure InstructionButtonClick(Sender: TObject);
        Procedure AboutTheDeveloperButtonClick(Sender: TObject);
        Procedure UsersStringEditChange(Sender: TObject);
        Procedure CreateSetButtonClick(Sender: TObject);
        Procedure UsersStringEditKeyDown(Sender: TObject; Var Key: Word;
            Shift: TShiftState);
        Procedure OpenFileButtonClick(Sender: TObject);
        Procedure SaveFileButtonClick(Sender: TObject);
        Procedure FormCloseQuery(Sender: TObject; Var CanClose: Boolean);
    procedure UsersStringEditKeyPress(Sender: TObject; var Key: Char);
    Private
        IsFileSaved: Boolean;
        IsFindButtonPressed: Boolean;
    Public
        { Public declarations }
    End;

Var
    MainForm: TMainForm;

Implementation

Uses
    InstructionUnit3_2, ExitUnit3_2, AboutTheDeveloperUnit3_2, BackendUnit3_2;

{$R *.dfm}

Procedure TMainForm.AboutTheDeveloperButtonClick(Sender: TObject);
Begin
    AboutTheDeveloperForm.Show;
End;

Procedure TMainForm.CreateSetButtonClick(Sender: TObject);
Var
    Symbols: TSetOfChar;
    I: Integer;
    TempString : String;
Begin
    IsFindButtonPressed := True;
    SaveFileButton.Enabled := True;
    IsFileSaved := False;
    If SymbolsSearcher = Nil Then
        SymbolsSearcher := TSymbolsSearcher.Create();
    SymbolsSearcher.SetUserString(UsersStringEdit.Text);
    SymbolsSearcher.FindSymbolsInString();
    If SymbolsSearcher.WasSymbols() Then
    Begin
        Symbols := SymbolsSearcher.GetSymbols();
        OutputSetLabel.Caption :=
            'Программа нашла такие символы в данной строке:' + #13#10;
        For I := 0 To COUNT_SYMBOLS Do
            If Chr(I) In Symbols Then
                OutputSetLabel.Caption := OutputSetLabel.Caption +
                    Chr(I) + ', ';
        TempString := OutputSetLabel.Caption;
        Delete(TempString,Length(OutputSetLabel.Caption) - 1,2);
        OutputSetLabel.Caption := TempString + '.';
    End
    Else
        OutputSetLabel.Caption := 'Символы не были найденны в данной строке!';
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
    FileReader: TFileReader;
    UsersString: String;
Begin
    If OpenDialog1.Execute() Then
    Begin
        FileReader := TFileReader.Create(OpenDialog1.FileName);
        If FileReader.IsFileGood() Then
        Begin
            UsersString := FileReader.InputString();
            If FileReader.GetStatus() Then
            Begin
                UsersStringEdit.Text := UsersString;
            End
            Else
                MessageBox(MainForm.Handle,
                    'Похоже у вас в файле пустая строка!', 'Ой-йой',
                    MB_ICONERROR);
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
            FileWriter.OutputSymbols(SymbolsSearcher.GetSymbols());
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

Procedure TMainForm.UsersStringEditChange(Sender: TObject);
Begin
    IsFindButtonPressed := False;
    CreateSetButton.Enabled := Not String.IsNullOrEmpty(UsersStringEdit.Text);
    OutputSetLabel.Caption := '';
    SaveFileButton.Enabled := False;
End;

Procedure TMainForm.UsersStringEditKeyDown(Sender: TObject; Var Key: Word;
    Shift: TShiftState);
Var
    Edit: TEdit;
Begin
    Edit := TEdit(Sender);
    If (CreateSetButton.Enabled) And (Edit.SelLength = 0) And
        (Edit.SelStart = 0) And (Key In [VK_UP, VK_LEFT]) Then
        ActiveControl := CreateSetButton;
    If (CreateSetButton.Enabled) And (Edit.SelLength = 0) And
        (Edit.SelStart = Length(Edit.Text)) And
        (Key In [VK_DOWN, VK_RIGHT]) Then
        ActiveControl := CreateSetButton;
    TEdit(Sender).ReadOnly := ((SsShift In Shift) Or (SsCtrl In Shift));
End;

procedure TMainForm.UsersStringEditKeyPress(Sender: TObject; var Key: Char);
Const
    Max_SYMBOLS : Integer = 30;
begin
    if (Length(TEdit(Sender).Text) > MAX_SYMBOLS) And (Key <> #08) then
        Key := #0;
end;

End.
