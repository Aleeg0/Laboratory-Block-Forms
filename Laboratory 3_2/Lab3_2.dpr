Program Lab3_2;

Uses
    Vcl.Forms,
    Vcl.Themes,
    Vcl.Styles,
    AboutTheDeveloperUnit3_2
        In 'AboutTheDeveloperUnit3_2.pas' {AboutTheDeveloperForm} ,
    BackendUnit3_2 In 'BackendUnit3_2.pas',
    ExitUnit3_2 In 'ExitUnit3_2.pas' {ExitForm} ,
    InstructionUnit3_2 In 'InstructionUnit3_2.pas' {InstructionForm} ,
    MainFormUnit3_2 In 'MainFormUnit3_2.pas' {MainForm};

{$R *.res}

Begin
    Application.Initialize;
    Application.MainFormOnTaskbar := True;
    TStyleManager.TrySetStyle('Tablet Dark');
    Application.CreateForm(TMainForm, MainForm);
    Application.CreateForm(TAboutTheDeveloperForm, AboutTheDeveloperForm);
    Application.CreateForm(TExitForm, ExitForm);
    Application.CreateForm(TInstructionForm, InstructionForm);
    Application.Run;

End.
