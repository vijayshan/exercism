-module(hamming).

-export([distance/2]).

distance(Strand1, Strand2) when length(Strand1) =/= length(Strand2) ->
    {error, "left and right strands must be of equal length"};
distance(Strand1, Strand2) ->
    distance(Strand1, Strand2, 0).

distance([], [], Count) ->
    Count;
distance([Head1 | Tail1], [Head1 | Tail2], Count) ->
    distance(Tail1, Tail2, Count);
distance([_Head1 | Tail1], [_Head2 | Tail2], Count) ->
    distance(Tail1, Tail2, Count + 1).
