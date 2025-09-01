defmodule WordCount do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    #replace all characters that are not permissible
    String.replace(sentence, ~r/[^[a-z 0-9A-Z\-_äöüÄÖÜß]]*/,"")
    #replace multiple spaces and underscores with one space.
    |>String.replace(~r/[ _]+/, " ")
    #convert all words to lower case
    |>String.downcase()
    #split string
    |>String.split(" ")
    #count the number of occurences
    |>Enum.frequencies
  end
end
