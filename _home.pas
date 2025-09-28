unit _home;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, pngimage, jpeg, ExtCtrls, Buttons;

type
  THome = class(TForm)
    Background: TImage;
    TransperantBackground: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Image1: TImage;
    ScrollBox1: TScrollBox;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    Label3: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Home: THome;

implementation

{$R *.dfm}

end.
