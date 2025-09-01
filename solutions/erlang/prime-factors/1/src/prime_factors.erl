-module(prime_factors).

-export([factors/1, isPrime/1, identifyNextPrime/2]).

factors(Value) ->
    factors(Value, [], [2]).

factors(Value, Factors, [NextPrime | _Tail] = Primes) when Value rem NextPrime == 0 ->
    factors(Value div NextPrime, [NextPrime | Factors], Primes);
factors(Value, Factors, [NextPrime | _Tail] = Primes)
    when Value >= NextPrime * NextPrime ->
    factors(Value, Factors, [identifyNextPrime(NextPrime + 1, Value) | Primes]);
factors(1, Factors, _) ->
    Factors;
factors(Value, Factors, _) ->
    [Value | Factors].

identifyNextPrime(Number, Number) ->
    Number;
% identifyNextPrime()
identifyNextPrime(Start, Number) ->
    Identified = isPrime(Start),
    if Identified ->
           Start;
       true ->
           identifyNextPrime(Start + 1, Number)
    end.

isPrime(Number) when Number =< 1 ->
    false;
isPrime(Number) when Number =< 3 ->
    true;
isPrime(Number) when (Number rem 2 == 0) or (Number rem 3 == 0) ->
    false;
isPrime(Number) ->
    isPrime(Number, lists:seq(5, trunc(math:sqrt(Number)) + 1, 6)).

isPrime(_, []) ->
    true;
isPrime(Number, [Head | Tail]) when Number rem Head =/= 0 ->
    isPrime(Number, Tail);
isPrime(_, _) ->
    false.
