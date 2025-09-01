defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    String.split(phrase, " ")
    |> Enum.map(&map_to_piglatin/1)
    |> Enum.join(" ")
  end

  # have the helper function match the character patterns and return the respective
  # translated words
  defp map_to_piglatin(s) do
    cond do
      (_list = Regex.run(~r/^[x|y]+[b-df-hj-np-tv-zB-DF-HJ-NP-TV-Z]+/, s)) != nil ->
        construction_helper(["", "", s])

      (list = Regex.run(~r/^([b-df-hj-np-tv-zB-DF-HJ-NP-TV-Z]{1}qu)([a-zA-z]*)/, s)) != nil ->
        construction_helper(list)

      (list = Regex.run(~r/^(ch|qu|th+r*|sch)([a-zA-Z]*)/, s)) != nil ->
        construction_helper(list)

      (list = Regex.run(~r/^([b-df-hj-np-tv-zB-DF-HJ-NP-TV-Z]{1,})([a-zA-Z]*)/, s)) != nil ->
        construction_helper(list)

      (_match = Regex.run(~r/^[aeiouAEIOU]{1}[a-zA-Z]+/, s)) != nil ->
        construction_helper(["", "", s])
    end
  end

  # construction helper helps in construction the individual strings

  defp construction_helper(list) do
    [_match, capt1, capt2] = list
    capt2 <> capt1 <> "ay"
  end
end
