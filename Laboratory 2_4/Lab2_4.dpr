Program Lab2_4;

Uses
    Vcl.Forms,
    AboutTheDeveloperUnit2_4
        In 'AboutTheDeveloperUnit2_4.pas' {AboutTheDeveloperForm} ,
    BackendUnit2_4 In 'BackendUnit2_4.pas',
    ExitUnit2_4 In 'ExitUnit2_4.pas' {ExitForm} ,
    MainFormUnit2_4 In 'MainFormUnit2_4.pas' {MainForm} ,
    Vcl.Themes,
    Vcl.Styles,
    InstructionUnit2_4 In 'InstructionUnit2_4.pas' {InstructionForm};

{$R *.res}

Begin
    Application.Initialize;
    Application.MainFormOnTaskbar := True;
    TStyleManager.TrySetStyle('Tablet Dark');
    Application.CreateForm(TMainForm, MainForm);
    Application.CreateForm(TAboutTheDeveloperForm, AboutTheDeveloperForm);
    Application.CreateForm(TInstructionForm, InstructionForm);
    Application.CreateForm(TExitForm, ExitForm);
    Application.Run;

End.
