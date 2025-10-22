unit _admin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, StdCtrls, pngimage;

type
  TAdmin = class(TForm)
    Background: TImage;
    TransperantBackground: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Shape1: TShape;
    Image1: TImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Admin: TAdmin;

implementation

{$R *.dfm}

end.
