-module(accumulate).

-export([accumulate/2]).

accumulate(_Fn, []) -> [];
accumulate(Fn, [Head|Tail]) -> [Fn(Head)|accumulate(Fn,Tail)].
