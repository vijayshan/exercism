-module(rail_fence_cipher).

-export([decode/2, encode/2, repeat/2]).

decode(Message, 1) ->
    Message;
decode(Message, Rails) ->
    RailY =
        repeat(lists:append(
                   lists:seq(1, Rails - 1), lists:seq(Rails, 2, -1)),
               length(Message)),
    RailX = lists:seq(1, length(Message)),
    ZippedList = lists:zip(RailX, RailY),
    PlacedList =
        lists:zip(Message, lists:sort(fun({_A, A1}, {_B, B1}) -> A1 =< B1 end, ZippedList)),
    DecodedList = lists:sort(fun({_S, {X, _Y}}, {_S1, {X1, _Y1}}) -> X =< X1 end, PlacedList),
    lists:map(fun({A, _B}) -> A end, DecodedList).

encode(Message, 1) ->
    Message;
encode(Message, Rails) ->
    RailY =
        repeat(lists:append(
                   lists:seq(1, Rails - 1), lists:seq(Rails, 2, -1)),
               length(Message)),
    ZippedList = lists:zip(Message, RailY),
    SortZipped = lists:sort(fun({_A, A1}, {_B, B1}) -> A1 =< B1 end, ZippedList),
    lists:map(fun({A, _B}) -> A end, SortZipped).

repeat(List, Count) ->
    Dup = Count div length(List) + 1,
    lists:sublist(
        lists:append(
            lists:duplicate(Dup, List)),
        Count).
