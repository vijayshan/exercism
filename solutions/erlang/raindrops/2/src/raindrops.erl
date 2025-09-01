-module(raindrops).

-export([convert/1]).


convert(Number) -> convert(Number, [{3, "Pling"}, {5, "Plang"}, {7, "Plong"}], "").

convert(Number, [], "") -> integer_to_list(Number);
convert(_Number, [] , Acc) -> Acc;
convert(Number, [{Num, Term}|Tail], Acc) when (Number rem Num)==0 -> 
    convert(Number, Tail, Acc ++ Term);
convert(Number, [_Head|Tail], Acc) -> 
    convert(Number, Tail, Acc).
