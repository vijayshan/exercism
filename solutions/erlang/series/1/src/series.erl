-module(series).

-export([slices/2]).

% only calculate series when the parameters meet length criterion
slices(SliceLength, Series) when (SliceLength > 0) andalso (SliceLength =< length(Series)) -> slices(SliceLength,Series, []);
slices(_SliceLength, _Series) -> erlang:error(badarg).

% The actual calculation
slices(SliceLength, Series, Acc) when (length(Series) < SliceLength) -> Acc;
slices(SliceLength, Series, Acc) when (length(Series) == SliceLength) -> lists:reverse([Series|Acc]);
slices(SliceLength, Series, Acc) when (length(Series)) > SliceLength -> 
    % tail optimized list creation
    slices(SliceLength, string:slice(Series,1),  [string:slice(Series,0,SliceLength)|Acc]).
