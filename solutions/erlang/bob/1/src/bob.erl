-module(bob).

-export([response/1]).

response(String) ->
    Trimmed = string:trim(String),
    Upcase = string:uppercase(String),
    Locase = string:lowercase(String),
    Yelled = (Upcase == String) and (Locase /= String),
    Question =
        length(Trimmed) andalso string:slice(Trimmed, string:length(Trimmed) - 1, 1) == "?",
    response(String, Trimmed, Upcase, Locase, Yelled, Question).

response(_String, _Trimmed, _Upcase, _Locase, true, true) ->
    "Calm down, I know what I'm doing!";
response(_String, _Trimmed, _Upcase, _Locase, true, _Question) ->
    "Whoa, chill out!";
response(_String, _Trimmed, _Upcase, _Locase, _Yelled, true) ->
    "Sure.";
response(_String, "", _Upcase, _Locase, _Yelled, _Question) ->
    "Fine. Be that way!";
response(_String, _Trimmed, _Upcase, _Locase, _Yelled, _Question) ->
    "Whatever.".
