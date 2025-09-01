-module(acronym).

-export([abbreviate/1]).

abbreviate(Phrase) ->
    Tokens = re:split(Phrase,"[ -]+",[{return,list}]),
    lists:filtermap(
        fun(X) ->
            Clean = string:strip(X, both, $_),
            [H|_T] = Clean,
            case re:run([H], "^[A-Za-z]") of
                {match, _} ->  {true,string:to_upper(H)};
                nomatch -> false
            end
        end,
        Tokens
    ).
