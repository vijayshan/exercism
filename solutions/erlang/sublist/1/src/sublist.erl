-module(sublist).

-export([is_equal/2, is_sublist/2, is_superlist/2, is_unequal/2, relation/2,
         chunk_every/3]).

is_equal(L1, L1) ->
    true;
is_equal(_L1, _L2) ->
    false.

is_sublist(L1, L2) when length(L1) < length(L2) ->
    Chunks = chunk_every(L2, length(L1), []),
    lists:member(L1, Chunks);
is_sublist(L1, L2) when length(L1) == length(L2) ->
    is_equal(L1, L2);
is_sublist(_, _) ->
    false.

is_superlist(L1, L2) when length(L1) >= length(L2) ->
    is_sublist(L2, L1);
is_superlist(_, _) ->
    false.

is_unequal(L1, L1) ->
    false;
is_unequal(_, _) ->
    true.

relation([], L2) when length(L2) > 0 ->
    sublist;
relation(L1, []) when length(L1) > 0 ->
    superlist;
relation(L1, L2) ->
    Equal = is_equal(L1, L2),
    Sublist = is_sublist(L1, L2),
    Superlist = is_superlist(L1, L2),
    if Equal ->
           equal;
       Sublist ->
           sublist;
       Superlist ->
           superlist;
       true ->
           unequal
    end.

chunk_every([_ | Tail] = L, Num, Acc) when length(L) >= Num ->
    {Sub, _Rem} = lists:split(Num, L),
    chunk_every(Tail, Num, [Sub | Acc]);
chunk_every(_, _, Acc) ->
    lists:reverse(Acc).
