defmodule RailFenceCipher do
  @doc """
  Encode a given plaintext to the corresponding rail fence ciphertext
  """
  @spec encode(String.t(), pos_integer) :: String.t()
  def encode(str, 1), do: str

  def encode(str, rails) do
    generate_rail_stream(rails)
    |> Stream.zip(String.codepoints(str))
    |> Enum.sort_by(fn {a, _b} -> a end)
    |> Enum.map_join("", fn {_a, b} -> b end)
  end

  @spec decode(String.t(), pos_integer) :: String.t()
  def decode(str, 1), do: str

  def decode(str, rails) do
    generate_rail_stream(rails)
    |> Stream.zip(1..String.length(str))
    |> Enum.sort_by(fn {a, _b} -> a end)
    |> Enum.zip(String.codepoints(str))
    |> Enum.sort_by(fn {{_a, b}, _s} -> b end)
    |> Enum.map_join("", fn {_a, b} -> b end)
  end

  defp generate_rail_stream(rails) do
    Enum.concat(1..(rails - 1), rails..2)
    |> Stream.cycle()
  end
end
