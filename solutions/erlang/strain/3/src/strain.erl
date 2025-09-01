-module(strain).

-export([keep/2, discard/2]).

-import(lists, [reverse/1]).

keep(Fn, List) ->
    fn_helper(fun(X) -> Fn(X) end, List, []).

discard(Fn, List) ->
    fn_helper(fun(X) -> not Fn(X) end, List, []).

fn_helper(_Fn, [], Items) ->
    reverse(Items);
fn_helper(Fn, [Head | Tail], Items) ->
    case Fn(Head) of
        true ->
            fn_helper(Fn, Tail, [Head | Items]);
        false ->
            fn_helper(Fn, Tail, Items)
    end.
