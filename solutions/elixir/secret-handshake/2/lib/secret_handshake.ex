defmodule SecretHandshake do
  @handshake_list [[1, "wink"], [2, "double blink"], [4, "close your eyes"], [8, "jump"]]
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    if(Bitwise.band(code, 16) != 0, do: Enum.reverse(@handshake_list), else: @handshake_list)
    |> Enum.filter(fn [x, _y] -> Bitwise.band(code, x) != 0 end)
    |> Enum.map(fn [_x, y] -> y end)
  end
end
