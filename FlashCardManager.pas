unit FlashCardManager;

interface

uses
  SysUtils, Classes, Contnrs,            // Contnrs is needed for TObjectList/TObjectDictionary
  Generics.Collections,                  // Needed for TDictionary
  IOUtils, Dialogs;                      // Added Dialogs for ShowMessage, IOUtils for TFile.Exists

type
  TFlashCard = class
  public // FIX 1: Added public access specifier
    Definition: string;
    Explanation: string; // FIX 1: Corrected spelling
    constructor Create(ADef: string = ''; AExp: string = '');
  end;

  TFlashCardGroup = class
  public
    subjectName : string;
    Cards : TObjectList<TFlashCard>;
    constructor Create(name : string);
  end;

  TFlashCardManager = class
  public
    // Subject maps string (SubjectName) to a list of cards for that subject
    // The list must own the TFlashCard objects to prevent leaks.
    Subject: TObjectList<TFlashCardGroup>;

    // Helper method for loading logic
    function InternalLoad: boolean;

  public
    constructor Create();
    destructor Destroy; override;

    // Original functions, refactored for better responsibility
    function GetFile: boolean;
    function CardGroupExists(name : string) : boolean;
    function AddCard(Group ,Definition , Explaination : string): boolean;
    function CreateCard(Definition, Explanation: string): TFlashCard;
    function GetGroup(groupName : string): TFlashCardGroup;
    function GetCard(definition : string): boolean;
    function Load: boolean;
    function Save: boolean; // Needs implementation
  end;

var
  UserCards: TextFile;
  Manager: TFlashCardManager; // Better to have a global Manager variable

implementation

uses LoginManager; // Required for 'user' variable

{ TFlashCard }

constructor TFlashCard.Create(ADef: string; AExp: string);
begin
  inherited Create;
  Definition := ADef;
  Explanation := AExp;
end;

{ TFlashCardGroup}
constructor TFlashCardGroup.Create(name : string);
begin
  cards := TObjectList<TFlashCard>.Create;
end;

{ TFlashCardManager }

constructor TFlashCardManager.Create();
begin
  Subject := TObjectList<TFlashCardGroup>.Create;
end;

destructor TFlashCardManager.Destroy;
var
  List : TFlashCardGroup;
begin
  // CRITICAL: Manually free all TObjectList objects stored as values.
  for List in Subject do
    List.cards.Free;

  Subject.Free;
  inherited;
end;

function TFlashCardManager.GetFile(): boolean;
var
  FileName: string;
begin
  // FIX 2: Use a clear file naming convention and check for existence
  FileName := user.StudentID + '.cards.txt';

  Result := False;
  if TFile.Exists(FileName) then
  begin
    AssignFile(UserCards, FileName);
    Result := True;
  end else
  begin
    ShowMessage('Card file not found for user: ' + FileName);
  end;
end;

function TFlashCardManager.CreateCard(Definition, Explanation: string): TFlashCard;
begin
  // This function is simple: just create and return the object
  Result := TFlashCard.Create(Definition, Explanation);
end;

function TFlashCardManager.Load(): boolean;
begin
  Result := False;

  // FIX: Separate file opening/closing from the loading logic
  if not GetFile then Exit;
  try
    Reset(UserCards); // Open the file for reading
    Result := InternalLoad;
  except
    on E: Exception do
    begin
      ShowMessage('Error opening or reading file: ' + E.Message);
    end;
  end;

  CloseFile(UserCards);
end;

function TFlashCardManager.InternalLoad: boolean;
var
  CurrentLn, SubjectName, TempValue: string;
  Card: TFlashCard;
  group: TFlashCardGroup ;
  List : TFlashCardGroup;
begin
  // Clear existing data first
  for List in Subject do
      List.cards.Free;
  Subject.Clear;

  try
    while not Eof(UserCards) do
    begin
      ReadLn(UserCards, CurrentLn);
      CurrentLn := Trim(CurrentLn);

      // 1. Check for the start of a new subject block
      if Pos('SUBJECT :', CurrentLn) = 1 then
      begin
        SubjectName := Trim(Copy(CurrentLn, Length('SUBJECT :') + 1, MaxInt));

        // Get or create the FlashCardGroup for the subject
        if not CardGroupExists(subjectName) then
        begin
            // Create list with True to own TFlashCard objects
            group.Create(subjectName);
            Subject.Add(group);
        end;

        Card := TFlashCard.Create; // Start a new card creation block

        // 2. Loop to read card details until CLOSECARD or EOF
        while not Eof(UserCards) do
        begin
          ReadLn(UserCards, CurrentLn);
          CurrentLn := Trim(CurrentLn);

          if CurrentLn = 'CLOSECARD' then
          begin
            // Finished card: Add to the list and break inner loop
            group.cards.Add(Card);
            break;
          end
          // 3. Handle card field data
          else if Pos('DEFINITION :', CurrentLn) = 1 then
          begin
            TempValue := Trim(Copy(CurrentLn, Length('DEFINITION :') + 1, MaxInt));
            Card.Definition := TempValue;
          end
          else if Pos('EXPLANATION :', CurrentLn) = 1 then
          begin
            TempValue := Trim(Copy(CurrentLn, Length('EXPLANATION :') + 1, MaxInt));
            Card.Explanation := TempValue;
          end;
        end; // End of inner while loop
      end; // End of SUBJECT check
    end; // End of outer while loop (EOF)
    Result := True;
  except
    on E: Exception do
    begin
      ShowMessage('Error during internal load process: ' + E.Message);
      Result := False;
    end;
  end;
end;

function TFlashCardManager.Save(): boolean;
var
I : integer;
X : integer;
group : TFlashCardGroup;
card : TFlashCard;
begin
  for i := 0 to subject.Count - 1 do
  begin
    Rewrite(usercards);
    group := manager.Subject[i];
    WriteLn(usercards , 'SUBJECT :' + group.subjectName);

    for X := 0 to group.cards.Count - 1 do
    begin
      card := group.Cards[x];
      WriteLn(usercards , 'DEFINITION :' + card.Definition);
      WriteLn(usercards , 'EXPLANATION :' + card.Explanation);
      WriteLn(usercards , 'CLOSECARD');
    end;
  end;
  Result := true; // Placeholder
end;

function TFlashCardManager.CardGroupExists(name : string) : boolean;
var
I : integer;
begin
  for I := 0 to Subject.Count - 1 do
  begin
    if Subject[i].subjectName = name then
    begin
      Result := true;
      exit;
    end;
  end;

end;

function TFlashCardManager.AddCard;
var
I : integer;
begin
     if not CardGroupExists(group) then
     begin

       for I := 0 to Subject.Count - 1 do
       begin
          if Subject[i].subjectName = group then
          begin
            subject[i].Cards.Add(CreateCard(Definition , Explaination));
            break;
          end;
       end;
       result := true;
     end;
end;



function TFlashCardManager.GetGroup(groupName : string): TFlashCardGroup;
var
i : integer;
begin
  for I := 0 to manager.Subject.Count - 1 do
  begin
    if manager.Subject[i].subjectName = groupname then
    begin
      manager.Subject[i];
    end;
  end;
end;

function TFlashCardManager.GetCard(definition : string): boolean;
begin

end;

// Global instance creation (optional, but follows your original pattern)
initialization
  Manager := TFlashCardManager.Create;

finalization
  FreeAndNil(Manager);

end.
