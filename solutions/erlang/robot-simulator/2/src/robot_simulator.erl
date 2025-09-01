-module(robot_simulator).

-export([advance/1, create/0, direction/1, left/1, place/3, position/1, right/1]).

advance(Robot) ->
    gen_server:call(Robot,advance).

create() ->
   {ok, Id} = gen_server:start(robot_state_server, [#{"position" => {0, 0}, "direction" => north}], []),
   Id.

direction(Robot) ->
    gen_server:call(Robot,direction).

left(Robot) ->
    gen_server:call(Robot,left).

place(Robot, Direction, Position) ->
    gen_server:call(Robot, {place, #{"position" => Position, "direction" => Direction}}).

position(Robot) ->
    gen_server:call(Robot,position).

right(Robot) ->
    gen_server:call(Robot,right).

