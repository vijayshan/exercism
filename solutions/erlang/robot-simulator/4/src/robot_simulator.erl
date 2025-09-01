-module(robot_simulator).

-behaviour(gen_server).

-export([init/1, handle_call/3, handle_cast/2]).
-export([advance/1, create/0, direction/1, left/1, place/3, position/1, right/1]).

advance(Robot) ->
    gen_server:call(Robot, advance).

create() ->
    {ok, Id} = gen_server:start(?MODULE, [#{position => {0, 0}, direction => north}], []),
    Id.

direction(Robot) ->
    gen_server:call(Robot, direction).

left(Robot) ->
    gen_server:call(Robot, left).

place(Robot, Direction, Position) ->
    gen_server:call(Robot, {place, #{position => Position, direction => Direction}}).

position(Robot) ->
    gen_server:call(Robot, position).

right(Robot) ->
    gen_server:call(Robot, right).

%server methods
init([RobotState | _Tail]) ->
    {ok, RobotState}.

handle_call(left, _From, RobotState) ->
    case maps:get(direction, RobotState) of
        north ->
            {reply, ok, maps:update(direction, west, RobotState)};
        east ->
            {reply, ok, maps:update(direction, north, RobotState)};
        south ->
            {reply, ok, maps:update(direction, east, RobotState)};
        west ->
            {reply, ok, maps:update(direction, south, RobotState)}
    end;
handle_call(right, _From, RobotState) ->
    case maps:get(direction, RobotState) of
        north ->
            {reply, ok, maps:update(direction, east, RobotState)};
        east ->
            {reply, ok, maps:update(direction, south, RobotState)};
        south ->
            {reply, ok, maps:update(direction, west, RobotState)};
        west ->
            {reply, ok, maps:update(direction, north, RobotState)}
    end;
handle_call(advance, _From, RobotState) ->
    {X, Y} = maps:get(position, RobotState),
    case maps:get(direction, RobotState) of
        north ->
            {reply, ok, maps:update(position, {X, Y + 1}, RobotState)};
        east ->
            {reply, ok, maps:update(position, {X + 1, Y}, RobotState)};
        south ->
            {reply, ok, maps:update(position, {X, Y - 1}, RobotState)};
        west ->
            {reply, ok, maps:update(position, {X - 1, Y}, RobotState)}
    end;
handle_call({place, RobotState_new}, _From, _RobotState) ->
    {reply, ok, RobotState_new};
handle_call(direction, _From, RobotState) ->
    {reply, maps:get(direction, RobotState), RobotState};
handle_call(position, _From, RobotState) ->
    {reply, maps:get(position, RobotState), RobotState}.

%handle other messages.
handle_cast(_Msg, N) ->
    {noreply, N}.
