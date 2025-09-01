defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance('AAGTCATA', 'TAGCGATC')
  {:ok, 4}
  """
  @spec hamming_distance([char], [char], non_neg_integer) ::
          {:ok, non_neg_integer} | {:error, String.t()}

  def hamming_distance(strand1, strand2, count \\ 0)

  def hamming_distance(strand1, strand2, _count) when length(strand1) != length(strand2),
    do: {:error, "Lists must be the same length"}

  def hamming_distance([], [], count), do: {:ok, count}

  def hamming_distance([head | rest1], [head | rest2], count),
    do: hamming_distance(rest1, rest2, count)

  def hamming_distance([_head1 | rest1], [_head2 | rest2], count),
    do: hamming_distance(rest1, rest2, count + 1)
end

# {:error, "Lists must be the same length"}
