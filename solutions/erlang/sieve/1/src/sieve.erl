-module(sieve).

-export([primes/1]).

primes(Limit) ->
    Seq = lists:seq(2, Limit),
    sieve(Seq, Limit, 1).

sieve(List, _, Cur_location) when length(List) =< Cur_location ->
    List;
sieve(List, Limit, Cur_location) ->
    Prime = lists:nth(Cur_location, List),
    Curr_seq = lists:seq(Prime * 2, Limit, Prime),
    Filtered_list = lists:filter(fun(X) -> not lists:member(X, Curr_seq) end, List),
    sieve(Filtered_list, Limit, Cur_location + 1).
