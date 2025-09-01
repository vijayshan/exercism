-module(queen_attack).

-export([can_attack/2]).

can_attack({X, _Y}, {X, _Y1}) ->
    true;
can_attack({_X, Y}, {_X1, Y}) ->
    true;
can_attack({X, Y}, {X1, Y1}) when abs(X - X1) =:= abs(Y - Y1) ->
    true;
can_attack(_A, _B) ->
    false.
