Program Lab3_1;

uses
  Vcl.Forms,
  AboutTheDeveloperUnit3_1 in 'AboutTheDeveloperUnit3_1.pas' {AboutTheDeveloperForm},
  ExitUnit3_1 in 'ExitUnit3_1.pas' {ExitForm},
  InstructionUnit3_1 in 'InstructionUnit3_1.pas' {InstructionForm},
  MainFormUnit3_1 in 'MainFormUnit3_1.pas' {MainForm},
  Vcl.Themes,
  Vcl.Styles,
  BackendUnit3_1 in 'BackendUnit3_1.pas';

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
