defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  # same list
  def compare(a, a), do: :equal

  # superlist
  def compare(a, b) when length(a) > length(b),
    do: if(compare(b, a) == :sublist, do: :superlist, else: :unequal)

  # sublist
  def compare([], _b), do: :sublist

  def compare(a, b) do
    Stream.chunk_every(b, length(a), 1)
    |> Enum.any?(&(&1 === a))
    |> (fn x -> if x, do: :sublist, else: :unequal end).()
  end

end
