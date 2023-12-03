program Lab1_2;

uses
  Vcl.Forms,
  MainFormUnit1_2 in 'MainFormUnit1_2.pas' {MainForm},
  Vcl.Themes,
  Vcl.Styles,
  AboutTheDeveloperUnit1_2 in 'AboutTheDeveloperUnit1_2.pas' {AboutTheDeveloper},
  InstructionUnit1_2 in 'InstructionUnit1_2.pas' {Instruction};

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
