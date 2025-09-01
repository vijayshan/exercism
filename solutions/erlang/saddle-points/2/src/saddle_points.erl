-module(saddle_points).

-export([saddle_points/1, transpose/3]).

saddle_points([Head | _Tail] = Matrix) when length(Matrix) > 0 andalso length(Head) > 0 ->
    Transposed = transpose(Matrix),
    RowHigh =
        sets:from_list(row_traverse_map(Matrix, fun(X) -> index_of(X, lists:max(X)) end)),
    ColumnLow =
        sets:from_list(
            lists:map(fun({A, B}) -> {B, A} end,
                      row_traverse_map(Transposed, fun(X) -> index_of(X, lists:min(X)) end))),
    lists:sort(intersection(RowHigh, ColumnLow));
saddle_points(_) ->
    [].

intersection(A, B) ->
    sets:to_list(
        sets:intersection(A, B)).

row_traverse_map(List, Fn) ->
    row_traverse_map(List, Fn, 0, []).

row_traverse_map([], _, _, Acc) ->
    lists:flatten(
        lists:reverse(Acc));
row_traverse_map([Head | Tail], Fn, RowNum, Acc) ->
    row_traverse_map(Tail,
                     Fn,
                     RowNum + 1,
                     [lists:map(fun(X) -> {RowNum, X} end, Fn(Head)) | Acc]).

transpose([Head | _Tail] = Matrix) ->
    RowLength = length(Head),
    transpose(Matrix, RowLength, []).

transpose(_Matrix, 0, Acc) ->
    Acc;
transpose(Matrix, RowLength, Acc) ->
    transpose(Matrix,
              RowLength - 1,
              [lists:map(fun(Y) -> lists:nth(RowLength, Y) end, Matrix) | Acc]).

index_of(List, Item) ->
    index_of(List, Item, [], 0).

index_of([], _, Acc, _) ->
    Acc;
index_of([Item | Tail], Item, Acc, ColumnCounter) ->
    index_of(Tail, Item, [ColumnCounter | Acc], ColumnCounter + 1);
index_of([_ | Tail], Item, Acc, ColumnCounter) ->
    index_of(Tail, Item, Acc, ColumnCounter + 1).
