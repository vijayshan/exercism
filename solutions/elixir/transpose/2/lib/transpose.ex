defmodule Transpose do
  @doc """
  Given an input text, output it transposed.

  Rows become columns and columns become rows. See https://en.wikipedia.org/wiki/Transpose.

  If the input has rows of different lengths, this is to be solved as follows:
    * Pad to the left with spaces.
    * Don't pad to the right.

  ## Examples
  iex> Transpose.transpose("ABC\nDE")
  "AD\nBE\nC"

  iex> Transpose.transpose("AB\nDEF")
  "AD\nBE\n F"
  """

  @spec transpose(String.t()) :: String.t()
  def transpose(input) do
    lines = input |> String.split("\n")
    maxlength = lines |> Enum.max_by(fn x -> String.length(x) end) |> String.length()

    lines
    |> Enum.map(fn x -> x |> String.pad_trailing(maxlength, " ") |> String.split("") end)
    |> Enum.zip()
    |> Enum.map(fn x -> Tuple.to_list(x) |> Enum.join() end)
    |> Enum.join("\n")
    |> String.trim()
  end
end
