defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(string) do
    Regex.scan(~r/(.)\1*/, string)
    |> Enum.reduce("", fn [pattern, letter] = _x, acc ->
      if (len = String.length(pattern)) > 1,
        do: acc <> to_string(len) <> letter,
        else: acc <> letter
    end)
  end

  @spec decode(String.t()) :: String.t()
  def decode(string) do
    Regex.scan(~r/([0-9]*)(.){1}/, string)
    |> Enum.reduce("", fn [_, number, letter] = _x, acc ->
      if number == "",
        do: acc <> letter,
        else: acc <> String.duplicate(letter, String.to_integer(number))
    end)
  end
end
