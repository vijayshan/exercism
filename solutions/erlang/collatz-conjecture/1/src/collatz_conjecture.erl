-module(collatz_conjecture).

-export([steps/1]).

% public function should only allow positive numbers greater than 0
steps(N) when (N>0) and is_integer(N) -> steps(N,0);
steps(_N) -> erlang:error(badarg).

% Private function which accumulates the steps and does the division
% by 2 if even and multiplies by 3 and adds one if odd
steps(N, Acc) when N==1 -> Acc;
steps(N, Acc) when (N rem 2) ==0 -> steps(N div 2, Acc+1);
steps(N, Acc) -> steps(((N*3)+1), Acc+1).
