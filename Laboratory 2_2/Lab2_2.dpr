program Lab2_2;

uses
  Vcl.Forms,
  MainFomrUnit2_2 in 'MainFomrUnit2_2.pas' {MainForm},
  Vcl.Themes,
  Vcl.Styles,
  InstructionUnit2_2 in 'InstructionUnit2_2.pas' {InstructionForm},
  AboutTheDeveloperUnit2_2 in 'AboutTheDeveloperUnit2_2.pas' {AboutTheDeveloperForm},
  BackendUnit2_2 in 'BackendUnit2_2.pas',
  ExitUnit2_2 in 'ExitUnit2_2.pas' {ExitForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Tablet Dark');
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TInstructionForm, InstructionForm);
  Application.CreateForm(TAboutTheDeveloperForm, AboutTheDeveloperForm);
  Application.Run;
end.
