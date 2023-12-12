Unit MainFormUnit3_1;

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
        FoundNumberLabel: TLabel;
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
        FindNumberButton: TBitBtn;
        Procedure InstructionButtonClick(Sender: TObject);
        Procedure AboutTheDeveloperButtonClick(Sender: TObject);
        Procedure UsersStringEditChange(Sender: TObject);
        Procedure FindNumberButtonClick(Sender: TObject);
        Procedure UsersStringEditKeyDown(Sender: TObject; Var Key: Word;
            Shift: TShiftState);
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

Uses
    InstructionUnit3_1, ExitUnit3_1, AboutTheDeveloperUnit3_1, BackendUnit3_1;

{$R *.dfm}

Procedure TMainForm.AboutTheDeveloperButtonClick(Sender: TObject);
Begin
    AboutTheDeveloperForm.Show;
End;

Procedure TMainForm.FindNumberButtonClick(Sender: TObject);
Begin
    SaveFileButton.Enabled := True;
    IsFileSaved := False;
    If NumberSearcher = Nil Then
        NumberSearcher := TNumberSearcher.Create();
    NumberSearcher.SetUserString(UsersStringEdit.Text);
    NumberSearcher.FindNumberInString();
    If NumberSearcher.WasNumber() Then
    Begin
        FoundNumberLabel.Caption := 'Число в строке: ' +
            NumberSearcher.GetNumber() + #46;
    End
    Else
        FoundNumberLabel.Caption := 'Число не было найденно в данной строке!';
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
                MessageBox(MainForm.Handle, 'Похоже у вас в файле пустая строка!',
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
            FileWriter.OutputNumber(NumberSearcher.GetNumber());
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
    FindNumberButton.Enabled := Not String.IsNullOrEmpty(UsersStringEdit.Text);
    FoundNumberLabel.Caption := '';
    SaveFileButton.Enabled := False;
End;

Procedure TMainForm.UsersStringEditKeyDown(Sender: TObject; Var Key: Word;
    Shift: TShiftState);
Var
    Edit: TEdit;
Begin
    Edit := TEdit(Sender);
    If (FindNumberButton.Enabled) And (Edit.SelLength = 0) And
        (Edit.SelStart = 0) And (Key In [VK_UP, VK_LEFT]) Then
        ActiveControl := FindNumberButton;
    If (FindNumberButton.Enabled) And (Edit.SelLength = 0) And
        (Edit.SelStart = Length(Edit.Text)) And
        (Key In [VK_DOWN, VK_RIGHT]) Then
        ActiveControl := FindNumberButton;

End;

End.
