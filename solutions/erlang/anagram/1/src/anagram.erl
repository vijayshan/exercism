-module(anagram).

-export([find_anagrams/2]).

find_anagrams(Subject, Candidates) ->
    SubjectMap = map_chars(Subject),
    Items =
        lists:filter(fun(X) -> string:lowercase(X) =/= string:lowercase(Subject) end, Candidates),
    lists:filter(fun(X) -> map_chars(X) == SubjectMap end, Items).

map_chars(String) ->
    lists:foldl(fun(C, Acc) -> maps:update_with(C, fun(V) -> V + 1 end, 1, Acc) end,
                #{},
                string:lowercase(String)).
