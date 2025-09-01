defmodule ETL do
  @doc """
  Transform an index into an inverted index.

  ## Examples

  iex> ETL.transform(%{"a" => ["ABILITY", "AARDVARK"], "b" => ["BALLAST", "BEAUTY"]})
  %{"aardvark" => "a", "ability" => "a", "ballast" => "b", "beauty" => "b"}
  """
  @spec transform(map) :: map
  def transform(input) do
    Enum.map(input, fn x -> horizontal_split(x, %{}) end)
    |> Enum.reduce(%{}, fn x, acc -> Map.merge(acc, x) end)
  end

  def horizontal_split({_a, []}, map), do: map

  def horizontal_split({a, [head | tail]}, map) do
    horizontal_split({a, tail}, Map.put(map, String.downcase(head), a))
  end
end
