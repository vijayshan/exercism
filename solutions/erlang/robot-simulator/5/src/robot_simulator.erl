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

handle_call(left, _From, RobotState = #{direction := north}) ->
    {reply, ok, RobotState#{direction := west}};
handle_call(left, _From, RobotState = #{direction := east}) ->
    {reply, ok, RobotState#{direction := north}};
handle_call(left, _From, RobotState = #{direction := south}) ->
    {reply, ok, RobotState#{direction := east}};
handle_call(left, _From, RobotState = #{direction := west}) ->
    {reply, ok, RobotState#{direction := south}};
handle_call(right, _From, RobotState = #{direction := north}) ->
    {reply, ok, RobotState#{direction := east}};
handle_call(right, _From, RobotState = #{direction := east}) ->
    {reply, ok, RobotState#{direction := south}};
handle_call(right, _From, RobotState = #{direction := south}) ->
    {reply, ok, RobotState#{direction := west}};
handle_call(right, _From, RobotState = #{direction := west}) ->
    {reply, ok, RobotState#{direction := north}};
handle_call(advance, _From, RobotState = #{direction := north, position := {X, Y}}) ->
    {reply, ok, RobotState#{position := {X, Y + 1}}};
handle_call(advance, _From, RobotState = #{direction := east, position := {X, Y}}) ->
    {reply, ok, RobotState#{position := {X + 1, Y}}};
handle_call(advance, _From, RobotState = #{direction := south, position := {X, Y}}) ->
    {reply, ok, RobotState#{position := {X, Y - 1}}};
handle_call(advance, _From, RobotState = #{direction := west, position := {X, Y}}) ->
    {reply, ok, RobotState#{position := {X - 1, Y}}};
handle_call({place, RobotState}, _From, _RobotStateOld) ->
    {reply, ok, RobotState};
handle_call(direction, _From, RobotState) ->
    {reply, maps:get(direction, RobotState), RobotState};
handle_call(position, _From, RobotState) ->
    {reply, maps:get(position, RobotState), RobotState}.

%handle other messages.
handle_cast(_Msg, N) ->
    {noreply, N}.
