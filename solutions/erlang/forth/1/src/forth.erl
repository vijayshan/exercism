-module(forth).

-include_lib("eunit/include/eunit.hrl").

-export([evaluate/1, check_legal/1, replace_custom_words/2, process_substitution/3]).

evaluate(InstructionList) ->
    evaluate([], [], #{}, InstructionList).

% handle recursion
evaluate([], Stack, _KeywordMap, []) ->
    lists:reverse(Stack);

% Before Splitting see if the line is a definition or calculation
evaluate([], Stack, KeywordMap, [Word = [First | _Rem] | Instructions])
    when ":" =:= [First] ->
    evaluate(re:split(
                 string:lowercase(Word), "[ ]+", [{return, list}]),
             Stack,
             KeywordMap,
             Instructions);
evaluate([], Stack, KeywordMap, [Word | Instructions]) ->
    evaluate(re:split(replace_custom_words(string:lowercase(Word), KeywordMap),
                      "[ ]+",
                      [{return, list}]),
             Stack,
             KeywordMap,
             Instructions);

% handle +,-,*
evaluate(["+" | Tail], [Num1, Num2 | StackTail], KeywordMap, Instructions) ->
    evaluate(Tail, [Num1 + Num2 | StackTail], KeywordMap, Instructions);
evaluate(["-" | Tail], [Num1, Num2 | StackTail], KeywordMap, Instructions) ->
    evaluate(Tail, [Num2 - Num1 | StackTail], KeywordMap, Instructions);
evaluate(["*" | Tail], [Num1, Num2 | StackTail], KeywordMap, Instructions) ->
    evaluate(Tail, [Num2 * Num1 | StackTail], KeywordMap, Instructions);
evaluate(["/" | Tail], [Num1, Num2 | StackTail], KeywordMap, Instructions)
    when Num1 =/= 0 ->
    evaluate(Tail, [Num2 div Num1 | StackTail], KeywordMap, Instructions);

% handle other operations
evaluate(["dup" | Tail], Orig = [Num1 | _StackTail], KeywordMap, Instructions) ->
    evaluate(Tail, [Num1 | Orig], KeywordMap, Instructions);
evaluate(["drop" | Tail], [_Num1 | StackTail], KeywordMap, Instructions) ->
    evaluate(Tail, StackTail, KeywordMap, Instructions);
evaluate(["swap" | Tail], [Num1, Num2 | StackTail], KeywordMap, Instructions) ->
    evaluate(Tail, [Num2, Num1 | StackTail], KeywordMap, Instructions);
evaluate(["over" | Tail], Orig = [_Num1, Num2 | _StackTail], KeywordMap, Instructions) ->
    evaluate(Tail, [Num2 | Orig], KeywordMap, Instructions);

% if its a definition statement process it word by word and add it to the keywordmap to
% be used for substitution later
evaluate([":", Word | Tail], Stack, KeywordMap, Instructions) ->
    LegalName = can_be_number(Word),
    if not LegalName ->
           Km = maps:put(Word, process_substitution(Tail, [], KeywordMap), KeywordMap),
           evaluate([], Stack, Km, Instructions);
       true ->
           erlang:error(badarg, [Word, Tail, Stack, KeywordMap, Instructions])
    end;

% check if its legal Word, if at this point we still have anything other than a number
% it is an invalid Word
evaluate([Word | Tail], Stack, KeywordMap, Instructions) ->
    Legal = can_be_number(Word),
    if Legal ->
           {Num, _N} = string:to_integer(Word),
           evaluate(Tail, [Num | Stack], KeywordMap, Instructions);
       true ->
           erlang:error(badarg, [Word, Tail, Stack, KeywordMap, Instructions])
    end;

% catch all to throw error.
evaluate(Lis, Stack, KeywordMap, Instructions) ->
    erlang:error(badarg, [Lis, Stack, KeywordMap, Instructions]).

% This function is used to build the substitution map
process_substitution([], _Acc, _KeywordMap) ->
    erlang:error(badarg);
process_substitution([";"], Acc, _KeywordMap) ->
    string:join(
        lists:reverse(Acc), " ");
process_substitution([Word | Tail], Acc, KeywordMap) ->
    MappedWord = replace_custom_words(Word, KeywordMap),
    Legal_Word = check_legal(MappedWord),
    Legal_Number = can_be_number(MappedWord),
    if Legal_Word or Legal_Number ->
           process_substitution(Tail, [MappedWord | Acc], KeywordMap);
       true ->
           erlang:error(badarg, [Word, Tail, Acc, KeywordMap])
    end.

% allowed legal words.
check_legal(Word) ->
    lists:member(Word, ["dup", "drop", "swap", "over", "-", "+", "/", "*"]).

% replace custom words
replace_custom_words(String, Map) ->
    maps:fold(fun(Key, Value, Acc) -> replace_helper(Key, Value, Acc) end, String, Map).

% helper function to replace Words, Primarily used because of the
% need to escape * and + in regexes
replace_helper("*", Value, Acc) ->
    re:replace(Acc, "\\*", Value, [{return, list}, global]);
replace_helper("+", Value, Acc) ->
    re:replace(Acc, "\\+", Value, [{return, list}, global]);
replace_helper(Key, Value, Acc) ->
    re:replace(Acc, Key, Value, [{return, list}, global]).

% function to check if a string can be converted into a number
can_be_number(Word) ->
    case re:run(Word, "[0-9]+") of
        {match, _Item} ->
            true;
        nomatch ->
            false
    end.
