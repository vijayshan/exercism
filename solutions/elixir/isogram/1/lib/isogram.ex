defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t()) :: boolean
  def isogram?(sentence) do
    not (String.downcase(sentence)
         |> to_charlist
         |> Enum.filter(fn x -> x >= 97 and x <= 122 end)
         |> Enum.reduce(%{}, fn x, acc -> Map.update(acc, x, 1, fn y -> y + 1 end) end)
         |> Map.values()
         |> Enum.any?(fn x -> x > 1 end))
  end
end
