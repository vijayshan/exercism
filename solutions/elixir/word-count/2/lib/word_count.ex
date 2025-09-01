defmodule WordCount do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    #replace all characters that are not permissible
    String.downcase(sentence)
    |>String.split( ~r/[[:blank:][!!&@$%^&,:_]]*/, trim: true)
    |>Enum.frequencies
  end
end
