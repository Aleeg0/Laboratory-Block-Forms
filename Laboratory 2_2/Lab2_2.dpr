program Lab2_2;

uses
  Vcl.Forms,
  MainFomrUnit2_2 in 'MainFomrUnit2_2.pas' {MainForm},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Tablet Dark');
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
