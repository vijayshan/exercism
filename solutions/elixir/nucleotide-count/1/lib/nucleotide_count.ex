defmodule NucleotideCount do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Guard for empty list 

  """
  def count([], _) do
    0
  end

  @doc """
  Counts individual nucleotides in a DNA strand.

  ## Examples

  iex> NucleotideCount.count('AATAA', ?A)
  4

  iex> NucleotideCount.count('AATAA', ?T)
  1
  """
  @spec count(charlist(), char()) :: non_neg_integer()
  def count(strand, nucleotide) do
    [head|tail] = strand
    rev_head =
      case head do
        ^nucleotide -> 
          1
        _ ->
          0
      end
    rev_head + count(tail, nucleotide)
  end

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram(charlist()) :: map()
  def histogram(strand) do
    
    hist = Enum.reduce @nucleotides , %{},   fn x, acc ->
      Map.put(acc, x, count(strand, x))
    end
    hist
  end
end
