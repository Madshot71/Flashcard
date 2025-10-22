unit _home;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, pngimage, jpeg, ExtCtrls, Buttons ;

type
  THome = class(TForm)
    Background: TImage;
    TransperantBackground: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Image1: TImage;
    ScrollBox1: TScrollBox;
    Label3: TLabel;
    SbtnFlashcard: TSpeedButton;
    GroupBox1: TGroupBox;
    Label4: TLabel;
    btnAdd: TButton;
    LbNumberofCards: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GroupBox1Click(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

type
  TSubject = record
  end;

  type
  TFlashCard = record
    Username: string;
    Score: Integer;
  end;

var
  Home: THome;
  mainOn: bool;
  SelectedSubject : string;

implementation

{$R *.dfm}

uses _login , _card , _addCard , FlashCardManager;

procedure THome.btnAddClick(Sender: TObject);
begin
  if not AddCard.Visible then
  begin
    SelectedSubject :=  btnAdd.Name;
    AddCard.ShowModal;
    LbNumberofCards.Caption := manager.GetGroup(btnAdd.Name).cards.Count;
  end;
end;

procedure THome.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if not login.Visible then
  begin
    application.Terminate;
  end;
end;


procedure THome.GroupBox1Click(Sender: TObject);
begin
  card.Show;
  hide;
end;

end.
