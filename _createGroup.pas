unit _createGroup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TAddGroup = class(TForm)
    Create: TButton;
    Name: TButtonedEdit;
    Label1: TLabel;
    procedure CreateClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AddGroup: TAddGroup;

implementation

{$R *.dfm}

uses FlashCardManager , _home;

procedure TAddGroup.CreateClick(Sender: TObject);
begin
  if manager.CreateGroup(name.Text) then
  begin
    Refresh;
    close;
  end
end;

end.
