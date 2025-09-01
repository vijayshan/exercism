defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  # same list
  def compare(a, a), do: :equal

  # superlist
  def compare(a, b) when length(a) > length(b),
    do: if(is_sublist?(b, a), do: :superlist, else: :unequal)

  # sublist
  def compare(a, b), do: if(is_sublist?(a, b), do: :sublist, else: :unequal)

  defp is_sublist?(_a, []), do: false

  defp is_sublist?(a, [_head | tail] = b) do
    if is_sublist_helper(a, b) do
      true
    else
      is_sublist?(a, tail)
    end
  end

  def is_sublist_helper([], _b), do: true
  def is_sublist_helper(_a, []), do: false
  def is_sublist_helper([head | tail], [head | tail1]), do: is_sublist_helper(tail, tail1)
  def is_sublist_helper(_a, _b), do: false
end
