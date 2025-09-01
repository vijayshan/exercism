-module(diamond).

-export([rows/1]).

rows([Head]) when Head >= 65; Head =< 90 ->
    Spaces = (Head - 64) * 2 - 1,
    rows_helper(Head - 1, [create_row(Head, Spaces)], Spaces).

rows_helper(64, List, _Spaces) ->
    List;
rows_helper(Letter, List, Spaces) ->
    NewItem = create_row(Letter, Spaces),
    rows_helper(Letter - 1, [NewItem] ++ List ++ [NewItem], Spaces).

create_row(65, Spaces) ->
    OuterSpaces = (Spaces - 1) div 2,
    NewChar = "A",
    outer(NewChar, OuterSpaces);
create_row(Char, Spaces) ->
    InnerSpaces = (Char - 65) * 2 - 1,
    OuterSpaces = (Spaces - InnerSpaces) div 2 - 1,
    NewChar = [Char],
    BaseString = inner(NewChar, InnerSpaces),
    outer(BaseString, OuterSpaces).

inner(String, Spaces) ->
    case Spaces > 0 of
        true ->
            String ++ string:copies(" ", Spaces) ++ String;
        false ->
            String
    end.

outer(String, Spaces) ->
    case Spaces > 0 of
        true ->
            string:copies(" ", Spaces) ++ String ++ string:copies(" ", Spaces);
        false ->
            String
    end.
