defmodule ETL do
  @doc """
  Transform an index into an inverted index.

  ## Examples

  iex> ETL.transform(%{"a" => ["ABILITY", "AARDVARK"], "b" => ["BALLAST", "BEAUTY"]})
  %{"aardvark" => "a", "ability" => "a", "ballast" => "b", "beauty" => "b"}
  """
  @spec transform(map) :: map
  def transform(input) do
    Enum.map(input, fn {k, v} ->
      Enum.reduce(v, %{}, fn x, acc -> Map.put(acc, String.downcase(x), k) end)
    end)
    |> Enum.reduce(%{}, fn x, acc -> Map.merge(acc, x) end)
  end

end
