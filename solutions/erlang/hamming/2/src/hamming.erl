-module(hamming).

-export([distance/2]).

distance(Strand1, Strand2) ->
    distance(Strand1, Strand2, 0).

distance([], [], Count) ->
    Count;
distance([Head1 | Tail1], [Head1 | Tail2], Count) ->
    distance(Tail1, Tail2, Count);
distance([_Head1 | Tail1], [_Head2 | Tail2], Count) ->
    distance(Tail1, Tail2, Count + 1);
distance(_Strand1, _Strand2, _Count) ->
    {error, "left and right strands must be of equal length"}.
