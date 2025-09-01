-module(accumulate).

-export([accumulate/2]).
-import(lists,[reverse/1]).

% accumulate(_Fn, []) -> [];
% accumulate(Fn, [Head|Tail]) -> [Fn(Head)|accumulate(Fn,Tail)].

accumulate(Fn, List) -> accumulate(Fn, List, []).
accumulate(_Fn, [], Acc) ->  reverse(Acc);
accumulate(Fn, [Head|Tail], Acc) -> accumulate(Fn, Tail,[Fn(Head)|Acc]).
