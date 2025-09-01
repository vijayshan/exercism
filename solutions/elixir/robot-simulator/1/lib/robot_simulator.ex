defmodule RobotSimulator do
  @directions %{:north => 0, :east => 1, :south => 2, :west => 3}
  defstruct position: {0, 0}, direction: :north

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: {integer, integer}) :: %RobotSimulator{}
  def create(direction \\ :north, position \\ {0, 0}) do
    cond do
      not Map.has_key?(@directions, direction) ->
        {:error, "invalid direction"}

      not is_tuple(position) or tuple_size(position) != 2 or
          not (fn {a, b} -> is_integer(a) and is_integer(b) end).(position) ->
        {:error, "invalid position"}

      true ->
        %RobotSimulator{direction: direction, position: position}
    end
  end

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, instructions) do
    simulate_helper(robot, to_charlist(instructions))
  end

  defp simulate_helper(robot, []), do: robot

  defp simulate_helper(robot, [head | tail]) do
    case head do
      ?R ->
        simulate_helper(
          %{
            robot
            | direction: enum_map_helper(@directions, rem(@directions[robot.direction] + 1, 4))
          },
          tail
        )

      ?L ->
        simulate_helper(
          %{
            robot
            | direction:
                enum_map_helper(@directions, rem(4 + @directions[robot.direction] - 1, 4))
          },
          tail
        )

      ?A ->
        simulate_helper(advance_helper(robot), tail)

      _ ->
        {:error, "invalid instruction"}
    end
  end

  defp enum_map_helper(map, val) do
    {key, _} = Enum.find(map, fn {_, value} -> val == value end)
    key
  end

  defp advance_helper(robot) do
    {posx, posy} = robot.position

    case robot.direction do
      :north ->
        %{robot | position: {posx, posy + 1}}

      :east ->
        %{robot | position: {posx + 1, posy}}

      :south ->
        %{robot | position: {posx, posy - 1}}

      :west ->
        %{robot | position: {posx - 1, posy}}
    end
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: %RobotSimulator{}) :: atom
  def direction(robot) do
    robot.direction
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: %RobotSimulator{}) :: {integer, integer}
  def position(robot) do
    robot.position
  end
end
