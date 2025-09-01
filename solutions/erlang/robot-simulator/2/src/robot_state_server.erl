-module(robot_state_server).
-behaviour(gen_server).

-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

%server methods
init([Robot_state|_Tail]) -> 
    {ok,Robot_state}.

handle_call(left, _From, Robot_state) ->
    Dir = maps:get("direction", Robot_state),
        case Dir of
            north ->
                {reply,ok, maps:update("direction", west, Robot_state)};
            east ->
                {reply,ok, maps:update("direction", north, Robot_state)};
            south ->
               {reply,ok, maps:update("direction", east, Robot_state)};
            west ->
                {reply,ok, maps:update("direction", south, Robot_state)}
        end; 

handle_call(right, _From, Robot_state) ->
    Dir = maps:get("direction", Robot_state),
        case Dir of
            north ->
                    {reply,ok, maps:update("direction", east, Robot_state)};
                east ->
                    {reply,ok, maps:update("direction", south, Robot_state)};
                south ->
                    {reply,ok, maps:update("direction", west, Robot_state)};
                west ->
                    {reply,ok, maps:update("direction", north, Robot_state)}
        end;
handle_call(advance, _From, Robot_state) ->
    Position = maps:get("position", Robot_state),
    Direction = maps:get("direction", Robot_state),
        case Direction of
            north ->
                {reply,ok, maps:update("position",
                                        {element(1, Position), element(2, Position) + 1},
                                        Robot_state)};
            east ->
                {reply,ok, maps:update("position",
                                        {element(1, Position) + 1, element(2, Position)},
                                        Robot_state)};
            south ->
                {reply,ok, maps:update("position",
                                        {element(1, Position), element(2, Position) - 1},
                                        Robot_state)};
            west ->
                {reply,ok, maps:update("position",
                                        {element(1, Position) - 1, element(2, Position)},
                                        Robot_state)}
        end;


handle_call({place, Robot_state_new},_From, _Robot_state)->
    {reply,ok,Robot_state_new};

handle_call(direction,_From, Robot_state)->
    {reply,maps:get("direction", Robot_state), Robot_state};

handle_call(position,_From, Robot_state)->
    {reply,maps:get("position", Robot_state), Robot_state}.

%handle other messages.
handle_cast(_Msg, N) ->
  {noreply, N}.
handle_info(_Msg, N) ->
  {noreply, N}.
code_change(_OldVsn, N, _Other) ->
  {ok, N}.
terminate(_Reason, _N) ->
  ok.
