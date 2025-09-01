-module(difference_of_squares).

-export([difference_of_squares/1, square_of_sum/1, sum_of_squares/1]).


difference_of_squares(Number) -> square_of_sum(Number) - sum_of_squares(Number).

square_of_sum(Number) ->  Temp = sum_helper(Number, 0, fun(X)-> X end ), Temp*Temp.

sum_of_squares(Number) -> sum_helper(Number, 0, fun(X)-> X*X end).

sum_helper(0, Acc, _Transform_fn) -> Acc;
sum_helper(Number, Acc, Transform_fn) -> sum_helper( Number-1, Acc + Transform_fn(Number), Transform_fn ).