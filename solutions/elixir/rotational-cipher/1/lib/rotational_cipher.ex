defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    String.to_charlist(text)
    |> Enum.map(fn x -> map_char(x, shift) end)
    |> to_string
  end

  """
  cipher implementation for a single character
  """

  @spec map_char(chr :: integer, shift :: integer) :: integer
  defp map_char(chr, shift) do
    case chr do
      chr when chr >= 65 and chr <= 90 ->
        rem(chr - 65 + shift, 26) + 65

      chr when chr >= 97 and chr <= 122 ->
        rem(chr - 97 + shift, 26) + 97

      chr ->
        chr
    end
  end
end
