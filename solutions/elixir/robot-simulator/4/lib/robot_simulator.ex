defmodule RobotSimulator do
  @directions %{:north => 0, :east => 1, :south => 2, :west => 3}
  defstruct position: {0, 0}, direction: :north

  @spec in_map(any) ::
          {:__block__ | {:., [], [:erlang | :not, ...]}, [],
           [{:= | {any, any, any}, [], [...]}, ...]}
  defguard in_map(direction)
           when direction in [:north, :south, :east, :west]

  defguard is_valid_position_tuple(position)
           when (is_tuple(position) and tuple_size(position) == 2)

  defguard is_valid_position_integer(a, b) when (is_integer(a) and is_integer(b))

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: {integer, integer}) :: %RobotSimulator{}
  def create(direction \\ :north, position \\ {0, 0})
  def create(direction, _position) when not in_map(direction), do: {:error, "invalid direction"}

  def create(_direction, position) when not is_valid_position_tuple(position),
    do: {:error, "invalid position"}

  def create(_direction, {a, b} = _position) when not is_valid_position_integer(a, b),
    do: {:error, "invalid position"}

  def create(direction, position) do
    %RobotSimulator{direction: direction, position: position}
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

  defp simulate_helper(robot, [?R | tail] = _instructions),
    do:
      simulate_helper(
        %{
          robot
          | direction: enum_map_helper(robot.direction, ?R)
        },
        tail
      )

  defp simulate_helper(robot, [?L | tail] = _instructions),
    do:
      simulate_helper(
        %{
          robot
          | direction: enum_map_helper(robot.direction, ?L)
        },
        tail
      )

  defp simulate_helper(robot, [?A | tail] = _instructions),
    do: simulate_helper(advance_helper(robot), tail)

  defp simulate_helper(_robot, _instructions), do: {:error, "invalid instruction"}

  defp enum_map_helper(direction, ?R) do
    key_find(rem(@directions[direction] + 1, 4))
  end

  defp enum_map_helper(direction, ?L) do
    key_find(rem(@directions[direction] + -1 + 4, 4))
  end

  defp key_find(val) do
    {key, _} = Enum.find(@directions, fn {_, value} -> val == value end)
    key
  end

  defp advance_helper(%RobotSimulator{direction: :north, position: {posx, posy}} = robot),
    do: %{robot | position: {posx, posy + 1}}

  defp advance_helper(%RobotSimulator{direction: :east, position: {posx, posy}} = robot),
    do: %{robot | position: {posx + 1, posy}}

  defp advance_helper(%RobotSimulator{direction: :south, position: {posx, posy}} = robot),
    do: %{robot | position: {posx, posy - 1}}

  defp advance_helper(%RobotSimulator{direction: :west, position: {posx, posy}} = robot),
    do: %{robot | position: {posx - 1, posy}}

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
