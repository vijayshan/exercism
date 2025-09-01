-module(sieve).

-export([primes/1]).

primes(Limit) ->
    Seq = lists:seq(2, Limit),
    sieve(Seq, Limit, 1).

sieve(List, _, Cur_location) when length(List) =< Cur_location ->
    List;
sieve(List, Limit, Cur_location) ->
    Prime = lists:nth(Cur_location, List),
    sieve(List -- lists:seq(Prime * 2, Limit, Prime), Limit, Cur_location + 1).
