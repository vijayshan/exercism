-module(strain).

-export([keep/2, discard/2]).
-import(lists, [reverse/1]).

keep(Fn, List) ->
    fn_helper(Fn, List, [], fun(X) -> X end).

discard(Fn, List) ->
    fn_helper(Fn, List, [], fun(X) -> not X end).

fn_helper(_Fn, [], Items, _TransformFn) ->
    reverse(Items);
fn_helper(Fn, [Head | Tail], Items, TransformFn) ->
    Result = TransformFn(Fn(Head)),
    if Result == true ->
           fn_helper(Fn, Tail, [Head | Items], TransformFn);
       true ->
           fn_helper(Fn, Tail, Items, TransformFn)
    end.
