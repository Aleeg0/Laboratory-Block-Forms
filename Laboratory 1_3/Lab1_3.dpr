program Lab1_3;

uses
  Vcl.Forms,
  MainFormUnit1_3 in 'MainFormUnit1_3.pas' {MainForm},
  Vcl.Themes,
  Vcl.Styles,
  AboutTheDeveloperUnit1_3 in 'AboutTheDeveloperUnit1_3.pas' {AboutTheDeveloper},
  InstructionUnit1_3 in 'InstructionUnit1_3.pas' {Instruction},
  OutputAnswerUnit1_3 in 'OutputAnswerUnit1_3.pas' {OutputAnswerUnit},
  BackendUnit1_3 in 'BackendUnit1_3.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Tablet Dark');
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TAboutTheDeveloper, AboutTheDeveloper);
  Application.CreateForm(TInstruction, Instruction);
  Application.Run;
end.
