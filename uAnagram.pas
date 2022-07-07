unit uAnagram;

interface

  type
    TAnagram = class
      Constructor Create(AText : string);
      class function findAnagram(AProposedList : TArray<string>) : TArray<string>; static;
    private
      class var FSortedText : string;
      class var FText : string;
      class function SortedString(AText : string) : string;
    end;

implementation

  uses
    System.Generics.Collections, System.SysUtils;

  class function TAnagram.SortedString(AText: string) : string;
    var
      SubText : TArray<Char>;
    begin
      Result := '';
      if 0 < length(AText) then
        begin
          SubText := AText.ToCharArray;
          TArray.Sort<Char>(SubText);
          for var i := Low(SubText) to High(SubText) do
            Result := Result + SubText[i];
        end;
    end;

  constructor TAnagram.Create(AText : string);
    begin
      FText := AText.ToLower;
      FSortedText := SortedString(AText.ToLower);
    end;

  class function TAnagram.findAnagram(AProposedList : TArray<string>) : TArray<string>;
    var
      TResultList : TArray<string>;
    begin
      SetLength(TResultList, 0);
      for var i := Low(AProposedList) to High(AProposedList) do
        begin
          if AProposedList[i].ToLower <> FText then
            if SortedString(AProposedList[i].ToLower) = FSortedText then
              begin
                SetLength(TResultList, length(TResultList) + 1);
                TResultList[length(TResultList) - 1] := AProposedList[i];
              end;
        end;
      Result := TResultList;
    end;

end.
