Program Lab3_3;

uses
  Vcl.Forms,
  AboutTheDeveloperUnit3_3 in 'AboutTheDeveloperUnit3_3.pas' {AboutTheDeveloper},
  ExitUnit3_3 in 'ExitUnit3_3.pas' {ExitForm},
  InstructionUnit3_3 in 'InstructionUnit3_3.pas' {Instruction},
  MainFormUnit3_3 in 'MainFormUnit3_3.pas' {MainForm},
  Vcl.Themes,
  Vcl.Styles,
  OutputSortedArrayUnit3_3 in 'OutputSortedArrayUnit3_3.pas' {OutputSortedArray},
  BackendUnit3_3 in 'BackendUnit3_3.pas';

{$R *.res}

Begin
    Application.Initialize;
    Application.MainFormOnTaskbar := True;
    TStyleManager.TrySetStyle('Tablet Dark');
    Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TAboutTheDeveloper, AboutTheDeveloper);
  Application.CreateForm(TInstruction, Instruction);
  Application.Run;

End.
