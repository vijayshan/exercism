defmodule RnaTranscription do
  @doc """
  Guard for empty list
  """
  def to_rna([]) do
    []
  end

  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RnaTranscription.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    IO.puts(dna)
    [head|tail] = dna
    rev_head =
      case head do
        71 -> 
          67
        67 ->
          71
        84 ->
          65
        65 ->
          85
      end
    [rev_head|RnaTranscription.to_rna(tail)]
  end
end
