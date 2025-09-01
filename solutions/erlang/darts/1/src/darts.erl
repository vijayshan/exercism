-module(darts).

-export([score/2]).

score(X, Y) ->
    Distance = math:sqrt(math:pow(X, 2) + math:pow(Y, 2)),
    if Distance =< 1.0 ->
           10;
       Distance =< 5.0 ->
           5;
       Distance =< 10.0 ->
           1;
       true ->
           0
    end.
