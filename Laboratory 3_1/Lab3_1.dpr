Program Lab3_1;

Uses
    Vcl.Forms,
    AboutTheDeveloperUnit3_1
        In 'AboutTheDeveloperUnit3_1.pas' {AboutTheDeveloperForm} ,
    ExitUnit3_1 In 'ExitUnit3_1.pas' {ExitForm} ,
    InstructionUnit3_1 In 'InstructionUnit3_1.pas' {InstructionForm} ,
    MainFormUnit3_1 In 'MainFormUnit3_1.pas' {MainForm} ,
    Vcl.Themes,
    Vcl.Styles,
    BackendUnit3_1 In 'BackendUnit3_1.pas';

{$R *.res}

Begin
    Application.Initialize;
    Application.MainFormOnTaskbar := True;
    TStyleManager.TrySetStyle('Tablet Dark');
    Application.CreateForm(TMainForm, MainForm);
    Application.CreateForm(TAboutTheDeveloperForm, AboutTheDeveloperForm);
    Application.CreateForm(TInstructionForm, InstructionForm);
    Application.Run;

End.
