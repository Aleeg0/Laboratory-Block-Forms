program Lab2_1;

uses
  Vcl.Forms,
  MainFormUnit2_1 in 'MainFormUnit2_1.pas' {MainForm},
  Vcl.Themes,
  Vcl.Styles,
  AboutTheDeveloperUnit2_1 in 'AboutTheDeveloperUnit2_1.pas' {AboutTheDeveloperForm},
  InstructionUnit2_1 in 'InstructionUnit2_1.pas' {InstructionForm},
  BackendUnit2_1 in 'BackendUnit2_1.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Tablet Dark');
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TAboutTheDeveloperForm, AboutTheDeveloperForm);
  Application.CreateForm(TInstructionForm, InstructionForm);
  Application.Run;
end.
