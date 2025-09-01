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
      chr when chr >= ?A and chr <= ?Z ->
        rotate(chr, shift, ?A)

      chr when chr >= ?a and chr <= ?z ->
        rotate(chr, shift, ?a)

      chr ->
        chr
    end
  end

  """
  function to rotate a character based on the pivot provided
  """

  defp rotate(chr, shift, pivot) do
    rem(chr - pivot + shift, 26) + pivot
  end
end
