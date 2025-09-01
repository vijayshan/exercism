-module(satellite).

-export([tree_from_traversals/2]).

tree_from_traversals([], []) ->
    #{};
tree_from_traversals(PreOrder = [Head], InOrder)
    when length(PreOrder) == length(InOrder) ->
    #{v => Head,
      l => #{},
      r => #{}};
tree_from_traversals(PreOrder = [Head | Tail], InOrder)
    when length(PreOrder) == length(InOrder) ->
    PreOrderLength = length(PreOrder),
    PreOrderSetLength =
        sets:size(
            sets:from_list(PreOrder)),
    if PreOrderLength == PreOrderSetLength ->
           {Left, [Head | Right]} = lists:splitwith(fun(X) -> X =/= Head end, InOrder),
           {ILeft, IRight} = lists:split(length(Left), Tail),
           #{v => Head,
             l => tree_from_traversals(ILeft, Left),
             r => tree_from_traversals(IRight, Right)};
       true ->
           erlang:error("Repeating items", [])
    end.
