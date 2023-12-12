program Project1;

uses
  Vcl.Forms,
  MainUnit1_1 in 'MainUnit1_1.pas' {MainForm},
  Vcl.Themes,
  Vcl.Styles,
  AboutDeveloperUnit1_1 in 'AboutDeveloperUnit1_1.pas' {AboutTheDeveloper},
  InstructionUnit1_1 in 'InstructionUnit1_1.pas' {Instruction};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Windows10 Dark');
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TAboutTheDeveloper, AboutTheDeveloper);
  Application.CreateForm(TInstruction, Instruction);
  Application.Run;
end.
