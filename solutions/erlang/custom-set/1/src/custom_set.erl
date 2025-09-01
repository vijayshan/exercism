-module(custom_set).

-export([add/2, contains/2, difference/2, disjoint/2, empty/1, equal/2, from_list/1,
         intersection/2, subset/2, union/2]).

-record(set, {list}).

add(Elem, Set) ->
    In_set = contains(Elem, Set),
    if not In_set ->
           #set{list = [Elem | Set#set.list]};
       true ->
           Set
    end.

contains(Elem, #set{list = List}) ->
    lists:member(Elem, List).

difference(Set1, Set2) ->
    filter_helper(Set1, Set2, [], fun(X, Y) -> not contains(X, Y) end).

disjoint(_Set1, #set{list = []}) ->
    true;
disjoint(#set{list = []}, _Set2) ->
    true;
disjoint(Set1, Set2) ->
    Intersection = intersection(Set1, Set2),
    length(Intersection#set.list) == 0.

empty(#set{list = []}) ->
    true;
empty(_Set1) ->
    false.

equal(Set1, Set2) ->
    Equal_elems = length(Set1#set.list) == length(Set2#set.list),
    if Equal_elems ->
           subset_helper(Set1, Set2);
       true ->
           false
    end.

from_list(List) ->
    from_list(List, #set{list = []}).

from_list([], Rec) ->
    Rec;
from_list([Head | Tail], Rec) ->
    In_list = contains(Head, Rec),
    if not In_list ->
           from_list(Tail, #set{list = [Head | Rec#set.list]});
       true ->
           from_list(Tail, Rec)
    end.

intersection(Set1, Set2) ->
    filter_helper(Set1, Set2, [], fun contains/2).

subset(Set1, Set2) ->
    subset_helper(Set1, Set2).

union(Set1, Set2) ->
    from_list(Set1#set.list, from_list(Set2#set.list, #set{list = []})).

filter_helper(#set{list = []}, _Item, IntList, _Fn) ->
    #set{list = IntList};
filter_helper(#set{list = [Head | Tail]}, Set2, IntList, Fn) ->
    In_Set = Fn(Head, Set2),
    if In_Set ->
           filter_helper(#set{list = Tail}, Set2, [Head | IntList], Fn);
       true ->
           filter_helper(#set{list = Tail}, Set2, IntList, Fn)
    end.

subset_helper(#set{list = []}, _Set2) ->
    true;
subset_helper(#set{list = [Head | Tail]}, Set2) ->
    In_set = contains(Head, Set2),
    if In_set ->
           subset_helper(#set{list = Tail}, Set2);
       true ->
           false
    end.
