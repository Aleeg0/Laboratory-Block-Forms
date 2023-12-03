program Lab1_4;

uses
  Vcl.Forms,
  MainFormUnit1_4 in 'MainFormUnit1_4.pas' {MainForm},
  Vcl.Themes,
  Vcl.Styles,
  InstructionUnit1_4 in 'InstructionUnit1_4.pas' {InstructionForm},
  AboutTheDeveloperUnit1_4 in 'AboutTheDeveloperUnit1_4.pas' {AboutTheDeveloper},
  BackEndUnit1_4 in 'BackEndUnit1_4.pas',
  OutputArrayBUnit1_4 in 'OutputArrayBUnit1_4.pas' {OutputArrayB};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Tablet Dark');
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TInstructionForm, InstructionForm);
  Application.CreateForm(TAboutTheDeveloper, AboutTheDeveloper);
  Application.Run;
end.
