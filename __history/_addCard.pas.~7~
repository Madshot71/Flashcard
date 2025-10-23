unit _addCard;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs , ExtCtrls , StdCtrls,Buttons, ComCtrls, Menus;

type
  TAddCard = class(TForm)
    Definition: TButtonedEdit;
    Button1: TButton;
    Explaination: TRichEdit;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AddCard: TAddCard;

implementation

{$R *.dfm}

uses FlashCardManager , _home;

procedure TAddCard.Button1Click(Sender: TObject);
begin
  if Definition.Text = '' then
  begin
    ShowMessage('either Definition or Explaination is empty');
  end;

  manager.AddCard(SelectedSubject ,Definition.Text , Explaination.Text);
  ShowMessage('Flash Card Created');
  Close;
end;

end.
