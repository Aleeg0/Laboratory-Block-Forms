program Lab2_3;

uses
  Vcl.Forms,
  MainFormUnit2_3 in 'MainFormUnit2_3.pas' {MainForm},
  Vcl.Themes,
  Vcl.Styles,
  InstructionUnit2_3 in 'InstructionUnit2_3.pas' {InstructionForm},
  AboutTheDeveloperUnit2_3 in 'AboutTheDeveloperUnit2_3.pas' {AboutTheDeveloperForm},
  ExitUnit2_3 in 'ExitUnit2_3.pas' {ExitForm},
  BackendUnit2_3 in 'BackendUnit2_3.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Tablet Dark');
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TInstructionForm, InstructionForm);
  Application.CreateForm(TAboutTheDeveloperForm, AboutTheDeveloperForm);
  Application.CreateForm(TExitForm, ExitForm);
  Application.Run;
end.
