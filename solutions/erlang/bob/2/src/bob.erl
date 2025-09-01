-module(bob).

-export([response/1]).

response(String) ->
    Trimmed = string:trim(String),
    Upcase = string:uppercase(String),
    Locase = string:lowercase(String),
    Yelled = (Upcase == String) and (Locase /= String),
    Question =
        length(Trimmed) andalso string:slice(Trimmed, string:length(Trimmed) - 1, 1) == "?",
    response(Trimmed, Yelled, Question).

response(_Trimmed, true, true) ->
    "Calm down, I know what I'm doing!";
response(_Trimmed, true, _Question) ->
    "Whoa, chill out!";
response(_Trimmed, _Yelled, true) ->
    "Sure.";
response("", _Yelled, _Question) ->
    "Fine. Be that way!";
response(_Trimmed, _Yelled, _Question) ->
    "Whatever.".
