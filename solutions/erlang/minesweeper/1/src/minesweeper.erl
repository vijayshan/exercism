-module(minesweeper).

-export([annotate/1, count/1, countColumn/4, surround/3, cell/2]).

annotate(Minefield) ->
    Dict = count(Minefield),
    annotate(Minefield, Dict, [], 0).

annotate([], _, Acc, _) ->
    lists:reverse(Acc);
annotate([Head | Tail], Dict, Acc, Row) ->
    annotate(Tail, Dict, [annotate(Head, Dict, "", Row, 0) | Acc], Row + 1).

annotate([], _, Acc, _, _) ->
    string:reverse(Acc);
annotate([42 | Tail], Dict, Acc, Row, Col) ->
    annotate(Tail, Dict, [42 | Acc], Row, Col + 1);
annotate([_ | Tail], Dict, Acc, Row, Col) ->
    Val = maps:get({Row, Col}, Dict, 0),
    if Val =/= 0 ->
           annotate(Tail, Dict, [integer_to_list(Val) | Acc], Row, Col + 1);
       true ->
           annotate(Tail, Dict, [" " | Acc], Row, Col + 1)
    end.

count(List) ->
    count(List, 0, #{}).

count([], _, Dict) ->
    Dict;
count([Head | Tail], CurrentRow, Dict) ->
    count(Tail, CurrentRow + 1, countColumn(Head, CurrentRow, 0, Dict)).

countColumn([], _, _, Dict) ->
    Dict;
countColumn([42 | Tail], CurrentRow, CurrentColumn, Dict) ->
    countColumn(Tail,
                CurrentRow,
                CurrentColumn + 1,
                surround(CurrentRow, CurrentColumn, Dict));
countColumn([_ | Tail], CurrentRow, CurrentColumn, Dict) ->
    countColumn(Tail, CurrentRow, CurrentColumn + 1, Dict).

surround(Row, Column, Dict) ->
    Cells =
        [{X + Row, Y + Column} || X <- [-1, 0, 1], Y <- [-1, 0, 1], (X =/= 0) or (Y =/= 0)],
    lists:foldl(fun(X, Acc) -> cell(X, Acc) end, Dict, Cells).

cell({Row, Column}, Dict) ->
    Init = maps:get({Row, Column}, Dict, 0),
    maps:put({Row, Column}, Init + 1, Dict).
