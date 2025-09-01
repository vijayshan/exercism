-module(isogram).

-export([is_isogram/1]).

is_isogram(Phrase) ->
    NewPhrase =
        lists:filter(fun(X) -> (X >= 97) and (X =< 122) end, string:lowercase(Phrase)),
    erlang:display(NewPhrase),
    length(NewPhrase)
    == length(sets:to_list(
                  sets:from_list(NewPhrase))).
