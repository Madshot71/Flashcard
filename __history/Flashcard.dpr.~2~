program Flashcard;

uses
  Forms,
  _login in '_login.pas' {Login},
  _home in '_home.pas' {Home},
  _admin in '_admin.pas' {Admin};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TLogin, Login);
  Application.CreateForm(THome, Home);
  Application.CreateForm(TAdmin, Admin);
  Application.Run;
end.
