defmodule StringSeries do
  @doc """
  Given a string `s` and a positive integer `size`, return all substrings
  of that size. If `size` is greater than the length of `s`, or less than 1,
  return an empty list.
  """
  @spec slices(s :: String.t(), size :: integer) :: list(String.t())
  def slices(s, size) do
    slice_compute(s, size, [])
  end

  # A helper function to recursively build the necessary list
  # with a guard function for size less than or equal to
  # Zero
  defp slice_compute(_s, size, _acc) when size <= 0, do: []

  defp slice_compute(s, size, acc) do
    case String.length(s) do
      len when len < size ->
        acc

      len when len == size ->
        List.insert_at(acc, -1, s)

      len when len > size ->
        {head, tail} = String.split_at(s, 1)
        item = String.slice(s, 0, size)
        slice_compute(tail, size, List.insert_at(acc, -1, item))
    end
  end
end
