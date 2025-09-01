-module(diamond).

-export([rows/1]).

-define(A, 65).
-define(Space, " ").

rows([Head]) when Head >= 65; Head =< 90 ->
    Spaces = (Head - ?A + 1) * 2 div 2,
    TopTriangle =
        [rowMap(?A + X - 1, Spaces - X, Spaces - (Spaces - X) - 1)
         || X <- lists:seq(1, Head - ?A + 1)],
    rowConstruct(TopTriangle).

rowMap(Letter, Left, Right) ->
    LeftList = string:copies(?Space, Left) ++ [Letter] ++ string:copies(?Space, Right),
    rowConstruct(LeftList).

rowConstruct(List) ->
    lists:append(List, lists:nthtail(1, lists:reverse(List))).
