-module(robot_simulator).

-export([advance/1, create/0, direction/1, left/1, place/3, position/1, right/1,
         robot_state/1]).

advance(Robot) ->
    Robot ! advance.

create() ->
    Id = spawn(robot_simulator, robot_state, [#{"position" => {0, 0}, "direction" => north}]),
    Id.

direction(Robot) ->
    Robot ! {direction, self()},
    receive
        V ->
            V
    end.

left(Robot) ->
    Robot ! left.

place(Robot, Direction, Position) ->
    Robot ! {place, #{"position" => Position, "direction" => Direction}}.

position(Robot) ->
    Robot ! {position, self()},
    receive
        V ->
            V
    end.

right(Robot) ->
    Robot ! right.

robot_state(Robot_state) ->
    receive
        left ->
            Dir = maps:get("direction", Robot_state),
            case Dir of
                north ->
                    robot_state(maps:update("direction", west, Robot_state));
                east ->
                    robot_state(maps:update("direction", north, Robot_state));
                south ->
                    robot_state(maps:update("direction", east, Robot_state));
                west ->
                    robot_state(maps:update("direction", south, Robot_state))
            end;
        right ->
            Dir = maps:get("direction", Robot_state),
            case Dir of
                north ->
                    robot_state(maps:update("direction", east, Robot_state));
                east ->
                    robot_state(maps:update("direction", south, Robot_state));
                south ->
                    robot_state(maps:update("direction", west, Robot_state));
                west ->
                    robot_state(maps:update("direction", north, Robot_state))
            end;
        advance ->
            Position = maps:get("position", Robot_state),
            Direction = maps:get("direction", Robot_state),
            case Direction of
                north ->
                    robot_state(maps:update("position",
                                            {element(1, Position), element(2, Position) + 1},
                                            Robot_state));
                east ->
                    robot_state(maps:update("position",
                                            {element(1, Position) + 1, element(2, Position)},
                                            Robot_state));
                south ->
                    robot_state(maps:update("position",
                                            {element(1, Position), element(2, Position) - 1},
                                            Robot_state));
                west ->
                    robot_state(maps:update("position",
                                            {element(1, Position) - 1, element(2, Position)},
                                            Robot_state))
            end;
        {place, Robot_state_new} ->
            robot_state(Robot_state_new);
        {direction, From} ->
            From ! maps:get("direction", Robot_state);
        {position, From} ->
            From ! maps:get("position", Robot_state)
    end,
    robot_state(Robot_state).
