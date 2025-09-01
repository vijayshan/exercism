defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, factors) do
    for(x <- 1..(limit - 1), do: x)
    |> Enum.filter(fn x -> Enum.any?(factors, fn y -> rem(x, y) == 0 end) end)
    |> Enum.reduce(0, fn x, acc -> acc + x end)
  end
end
