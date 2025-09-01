defmodule CollatzConjecture do
  @doc """
  calc/1 takes an integer and returns the number of steps required to get the
  number to 1 when following the rules:
    - if number is odd, multiply with 3 and add 1
    - if number is even, divide by 2
  """
  @spec calc(input :: pos_integer()) :: non_neg_integer()
  def calc(input, steps \\ 0)

  def calc(input, _steps) when not is_integer(input) or input <= 0 do
    raise FunctionClauseError
  end

  def calc(1, steps) do
    steps
  end

  def calc(current, steps) when rem(current, 2) == 0 do
    calc(div(current, 2), steps + 1)
  end

  def calc(current, steps) do
    calc(3 * current + 1, steps + 1)
  end
end
