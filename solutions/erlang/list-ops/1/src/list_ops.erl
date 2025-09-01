-module(list_ops).

-export([append/2, concat/1, filter/2, length/1, map/2, foldl/3, foldr/3, reverse/1]).

append(List1, List2) ->
    append(List1, List2, []).

append([], [], Acc) ->
    reverse(Acc);
append([], [Head | Tail], Acc) ->
    append([], Tail, [Head | Acc]);
append([Head | Tail], List2, Acc) ->
    append(Tail, List2, [Head | Acc]).

concat(List) ->
    concat(List, []).

concat([], Acc) ->
    Acc;
concat([Head | Tail], Acc) ->
    concat(Tail, append(Acc, Head)).

filter(Function, List) ->
    filter(Function, List, []).

filter(_Function, [], Acc) ->
    reverse(Acc);
filter(Function, [Head | Tail], Acc) ->
    case Function(Head) of
        true ->
            filter(Function, Tail, [Head | Acc]);
        false ->
            filter(Function, Tail, Acc)
    end.

length(List) ->
    length(List, 0).

length([], Sum) ->
    Sum;
length([_Head | Tail], Sum) ->
    length(Tail, Sum + 1).

map(Function, List) ->
    map(Function, List, []).

map(_Function, [], Acc) ->
    reverse(Acc);
map(Function, [Head | Tail], Acc) ->
    map(Function, Tail, [Function(Head) | Acc]).

foldl(_Function, Start, []) ->
    Start;
foldl(Function, Start, [Head | Tail]) ->
    foldl(Function, Function(Head, Start), Tail).

foldr(Function, Start, List) ->
    foldl(Function, Start, reverse(List)).

reverse(List) ->
    reverse(List, []).

reverse([], Acc) ->
    Acc;
reverse([Head | Tail], Acc) ->
    reverse(Tail, [Head | Acc]).
