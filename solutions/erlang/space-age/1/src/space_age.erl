-module(space_age).

-export([age/2]).

age(earth, Seconds) ->
    helper(Seconds, 1);
age(mercury, Seconds) ->
    helper(Seconds, 0.2408467);
age(venus, Seconds) ->
    helper(Seconds, 0.61519726);
age(mars, Seconds) ->
    helper(Seconds, 1.8808158);
age(jupiter, Seconds) ->
    helper(Seconds, 11.862615);
age(saturn, Seconds) ->
    helper(Seconds, 29.447498);
age(uranus, Seconds) ->
    helper(Seconds, 84.016846);
age(neptune, Seconds) ->
    helper(Seconds, 164.79132).

helper(Age, Divisor) ->
    Age / Divisor / 31_557_600.
