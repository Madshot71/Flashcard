unit _admin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, StdCtrls, pngimage , Generics.Collections;

type
  TAdmin = class(TForm)
    Background: TImage;
    TransperantBackground: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Shape1: TShape;
    Image1: TImage;
    ScrollBox1: TScrollBox;
    btnDeleteGroup: TButton;
    btnExit: TButton;
    btnGroupPrefab: TButton;
    CBCards: TComboBox;
    btnDeleteCard: TButton;
    procedure FormShow(Sender: TObject);
    procedure btnDeleteGroupClick(Sender: TObject);
    procedure btnDeleteCardClick(Sender: TObject);
    procedure btnGroupPrefabClick(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
    procedure DeleteCard(group , name : string);
    procedure DeleteGroup(name : string);
    procedure CreateButtons();
    function MakeButton(name : string ; Prefab : TButton): TButton;
    procedure Refresh();
  end;

  TSlot = class
    name : string;
    button : TButton;
    Constructor Create(name : string; button : TButton);
  end;

var
  Admin: TAdmin;
  LastClicked : TButton;
  GroupSlots : TObjectList<TSlot>;

implementation

{$R *.dfm}

uses FlashCardManager , _home;

constructor TSlot.Create(name : string ; button : Tbutton);
begin
  self.name := name;
  self.button := button;
end;

procedure TAdmin.DeleteCard(group , name : string);
var
  I : Integer;
  X : Integer;
  cardGroup : TFlashCardGroup;

begin
    for I := 0 to manager.Subject.Count - 1 do
    begin
      if manager.Subject[i].subjectName = group then
      begin
        CardGroup := manager.Subject[i];
      end;
    end;

    if cardGroup = nil then
    begin
      exit;
    end;

    for X := 0 to cardGroup.Cards.Count - 1 do
    begin
      if cardGroup.Cards[X].Definition = name then
      begin
        cardGroup.Cards.Delete(X);
      end;
    end;
end;

procedure TAdmin.DeleteGroup(name : string);
begin
   if manager.RemoveGroup(name) then
   begin
     ShowMessage('Group Deleted');
   end;
end;

procedure TAdmin.FormShow(Sender: TObject);
begin
  Admin.Refresh;
end;

procedure TAdmin.btnDeleteCardClick(Sender: TObject);
begin
  if CBCards.Text = 'Card' then
  begin
    ShowMessage('Card field is Empty');
    exit;
  end;
  manager.RemoveCard(lastClicked.Caption , CBCards.Text);
end;

procedure TAdmin.btnDeleteGroupClick(Sender: TObject);
begin
    if lastClicked = nil  then
    begin
      ShowMessage('No Group selected');
      exit;
    end;
    manager.RemoveGroup(lastClicked.Caption);
end;

procedure TAdmin.btnGroupPrefabClick(Sender: TObject);
var
 I , X : Integer;

begin
  LastClicked := Sender as TButton;

  for I := 0 to manager.Subject.Count - 1 do
  begin
     if manager.Subject[i].subjectName = LastClicked.Caption then
     begin
        for X := 0 to manager.Subject[I].Cards.Count - 1 do
        begin
           CBCards.Items.Add(manager.Subject[i].Cards[X].Definition);
        end;
     end;
  end;
end;


procedure TAdmin.CreateButtons();
var
 I , X : Integer;
 tmpSlot : TSlot;
 group , name : string;
begin
  for I := 0 to Manager.Subject.Count - 1 do
  begin
    group := manager.Subject[i].subjectName;

    tmpSlot := TSlot.Create(group ,Admin.MakeButton(group , admin.btnGroupPrefab));
    GroupSlots.Add(tmpSlot);
  end;
end;

procedure TAdmin.Refresh();
var
 tmpSlot : TSlot;
begin
  for tmpSlot in GroupSlots do
  begin
    tmpSlot.button.Destroy;
  end;
  GroupSlots.Clear;
  admin.CBCards.Clear;

  admin.CreateButtons;
end;

function TAdmin.MakeButton(name : string; Prefab : TButton): TButton;
var
  tmp : TButton;
begin
  tmp := TButton.Create(self);
  tmp.Parent := Prefab.Parent;
  tmp.Align := Prefab.Align;
  tmp.Width := Prefab.Width;
  tmp.Height := Prefab.Height;

  tmp.Visible := true;
  tmp.Font := Prefab.Font;
  tmp.OnClick := Prefab.OnClick;
  tmp.Caption := name;
end;


initialization
  GroupSlots := TObjectList<TSlot>.Create;

end.
