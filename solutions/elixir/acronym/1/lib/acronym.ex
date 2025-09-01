defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    String.split(string, ~r/[^[:alnum:]\']+/, trim: true)
    |> Enum.map(fn x -> String.upcase(String.first(x)) <> String.slice(x, 1..-1) end)
    |> Enum.map(fn x -> Regex.scan(~r/[A-Z]+[a-z]*/, x) end)
    |> List.flatten()
    |> Enum.map(fn x -> String.first(x) end)
    |> Enum.reduce(fn x, acc -> acc <> x end)
  end
end
