defmodule ProteinTranslation do
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {atom, list(String.t())}
  def of_rna(""), do: {:ok, []}

  def of_rna(rna) do
    if String.length(rna) < 3 do
      {:error, "invalid RNA"}
    end

    {head, tail} = String.split_at(rna, 3)

    case of_codon(head) do
      {:ok, "STOP"} ->
        {:ok, []}

      {:ok, codon} ->
        construct_codon_list(tail, codon)

      {:error, _} ->
        {:error, "invalid RNA"}
    end
  end

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @spec of_codon(String.t()) :: {atom, String.t()}
  def of_codon(codon) do
    case codon do
      x when x in ["UGU", "UGC"] -> {:ok, "Cysteine"}
      x when x in ["UUA", "UUG"] -> {:ok, "Leucine"}
      x when x in ["UUU", "UUC"] -> {:ok, "Phenylalanine"}
      x when x in ["UCU", "UCC", "UCA", "UCG"] -> {:ok, "Serine"}
      x when x in ["UAU", "UAC"] -> {:ok, "Tyrosine"}
      "AUG" -> {:ok, "Methionine"}
      "UGG" -> {:ok, "Tryptophan"}
      x when x in ["UAA", "UAG", "UGA"] -> {:ok, "STOP"}
      _ -> {:error, "invalid codon"}
    end
  end

  # Helper function to construct codon list

  defp construct_codon_list(list, codon) do
    case of_rna(list) do
      {:ok, codon_list} ->
        {:ok, Enum.concat([codon], codon_list)}

      {:error, _} ->
        {:error, "invalid RNA"}
    end
  end
end
