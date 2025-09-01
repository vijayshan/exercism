-module(saddle_points).

-export([saddle_points/1, transpose/3]).

saddle_points([Head | _Tail] = Matrix) when length(Matrix) > 0 andalso length(Head) > 0 ->
    RowLength = length(lists:nth(1, Matrix)),
    Transposed = transpose(Matrix, RowLength, []),
    RowHigh =
        sets:from_list(row_traverse_map(Matrix,
                                        fun(X) -> index_of(X, lists:max(X), [], 0) end,
                                        0,
                                        [])),
    ColumnLow =
        sets:from_list(
            lists:map(fun({A, B}) -> {B, A} end,
                      row_traverse_map(Transposed,
                                       fun(X) -> index_of(X, lists:min(X), [], 0) end,
                                       0,
                                       []))),
    lists:sort(
        sets:to_list(
            sets:intersection(RowHigh, ColumnLow)));
saddle_points(_) ->
    [].

row_traverse_map([], _, _, Acc) ->
    lists:flatten(
        lists:reverse(Acc));
row_traverse_map([Head | Tail], Fn, RowNum, Acc) ->
    row_traverse_map(Tail,
                     Fn,
                     RowNum + 1,
                     [lists:map(fun(X) -> {RowNum, X} end, Fn(Head)) | Acc]).

transpose(_Matrix, 0, Acc) ->
    Acc;
transpose(Matrix, RowLength, Acc) ->
    transpose(Matrix,
              RowLength - 1,
              [lists:map(fun(Y) -> lists:nth(RowLength, Y) end, Matrix) | Acc]).

index_of([], _, Acc, _) ->
    Acc;
index_of([Head | Tail], Item, Acc, ColumnCounter) ->
    if Head == Item ->
           index_of(Tail, Item, [ColumnCounter | Acc], ColumnCounter + 1);
       true ->
           index_of(Tail, Item, Acc, ColumnCounter + 1)
    end.
