unit _login;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, pngimage, jpeg, ExtCtrls  ,_registerForm;

type
  TLogin = class(TForm)
    Background: TImage;
    TransperantBackground: TImage;
    Title: TLabel;
    Username: TButtonedEdit;
    Password: TButtonedEdit;
    btnLogin: TButton;
    btnRegister: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Image2: TImage;
    procedure btnLoginClick(Sender: TObject);
    procedure btnRegisterClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    regOn: bool;
  end;

var
  Login: TLogin;

implementation

{$R *.dfm}

uses _home , LoginManager;

procedure TLogin.btnLoginClick(Sender: TObject);
begin
  // --- Step 1: Validate Credentials (Example Logic) ---
  if LoginFunction(username.Text, password.Text ) then
  begin

    // --- Step 3: Show the Home Page Form ---
    home.Show;
    login.Hide;
    
    // --- Step 4: Close the Login Form ---
    // The preferred way to close the Login form is to use Hide, then Close.
    // However, if the Login form is the MAIN form of the application, 
    // using Close will shut down the whole app unless you Show the next form first.
    // In this pattern, simply using FreeAndNil(Self) or Close is common.
    // We'll use Close.

     // This closes the Login form.
           // Since MainForm is now visible, the application stays running.
  end;
end;

procedure TLogin.btnRegisterClick(Sender: TObject);

begin

  if not Register.Visible then
  begin
     Register.ShowModal;
     regOn := true;
  end;
  
end;

end.
