defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()], [String.t()]) :: [String.t()]
  def match(base, candidates, matches \\ [])

  def match(_base, [], matches) do
    Enum.reverse(matches)
  end

  def match(base, [head | candidates], matches) do
    if convertAndOrder(base) == convertAndOrder(head) and
         String.downcase(base) != String.downcase(head) do
      match(base, candidates, [head | matches])
    else
      match(base, candidates, matches)
    end
  end

  defp convertAndOrder(s) do
    s |> String.downcase() |> String.to_charlist() |> Enum.sort()
  end
end
