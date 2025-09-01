-module(triangle).

-export([kind/3]).

kind(A, B, C) when (A =< 0) or (B =< 0) or (C =< 0) ->
    {error, "all side lengths must be positive"};
kind(A, B, C) when (A + B < C) or (B + C < A) or (A + C < B) ->
    {error, "side lengths violate triangle inequality"};
kind(A, A, A) when A > 0 ->
    equilateral;
kind(A, A, _B) ->
    isosceles;
kind(_A, B, B) ->
    isosceles;
kind(A, _B, A) ->
    isosceles;
kind(_A, _B, _C) ->
    scalene.
