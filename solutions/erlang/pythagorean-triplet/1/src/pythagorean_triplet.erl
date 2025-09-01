-module(pythagorean_triplet).

-export([triplets_with_sum/1]).

triplets_with_sum(Limit) -> 

    lists:foldl(fun(Item, Acc)-> 
            lists:foldl(
            fun(Item1, Acc1) ->
                A = Item,
                B = Item1,
                C = Limit-(Item1+Item),
                if 
                    A*A+B*B =:= C*C -> [{A,B,C}|Acc1];
                    true -> Acc1
                end
                % [{A,B,C}|Acc1]
            end,
            Acc,lists:seq(Limit div 2, Item+1, -1))
        end
        , [],lists:seq(Limit div 3,1, -1)).

