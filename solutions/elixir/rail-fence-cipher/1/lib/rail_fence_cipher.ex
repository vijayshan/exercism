defmodule RailFenceCipher do
  @doc """
  Encode a given plaintext to the corresponding rail fence ciphertext
  """
  # @separator_chr "*"
  @spec encode(String.t(), pos_integer) :: String.t()
  def encode(str, 1), do: str

  def encode(str, rails) do
    encode_helper(str, encode_item_list(String.length(str), rails), create_grid(rails))
    |> map_to_string
  end

  @spec encode_item_list(
          pos_integer(),
          pos_integer(),
          integer(),
          integer(),
          integer(),
          list(tuple())
        ) :: list(tuple())
  defp encode_item_list(length, rails, x \\ 0, y \\ 0, inc \\ 1, list \\ [])

  defp encode_item_list(0, _, _, _, _, list), do: Enum.reverse(list)

  defp encode_item_list(length, rails, x, y = 0, _inc, list) do
    encode_item_list(length - 1, rails, x + 1, y + 1, 1, [{x, y} | list])
  end

  defp encode_item_list(length, rails, x, y, _inc, list) when y == rails - 1 do
    encode_item_list(length - 1, rails, x + 1, y - 1, -1, [{x, y} | list])
  end

  defp encode_item_list(length, rails, x, y, inc, list) do
    encode_item_list(length - 1, rails, x + 1, y + inc, inc, [{x, y} | list])
  end

  @spec map_to_string(map) :: String.t()
  defp map_to_string(map) do
    map
    |> Map.to_list()
    |> Enum.reduce("", fn {_i, list}, acc -> acc <> to_string(list) end)
  end

  @spec encode_helper(String.t(), any, map()) :: map()
  defp encode_helper("", _, map) do
    map
    |> reverse_strings_in_map
  end

  defp encode_helper(<<first, rest::binary>> = _str, [{_x, y} | tail] = _pos, map) do
    encode_helper(rest, tail, %{map | y => [first | Map.get(map, y)]})
  end

  # @doc """
  # Decode a given rail fence ciphertext to the corresponding plaintext
  # """
  @spec decode(String.t(), pos_integer) :: String.t()
  def decode(str, 1), do: str

  def decode(str, rails) do
    item_list = encode_item_list(String.length(str), rails)

    map =
      construct_list(
        str,
        item_list |> Enum.sort_by(fn {_x, y} -> y end),
        create_grid(rails)
      )

    decode_helper(item_list, map, [])
    |> to_string
  end

  @spec decode_helper([{integer(), integer()}], map(), list(binary())) :: list(binary())
  defp decode_helper([], _, acc), do: Enum.reverse(acc)

  defp decode_helper([{_x, y} | tail], map, acc) do
    {item, map_new} = Map.get_and_update(map, y, fn [head1 | tail1] -> {head1, tail1} end)
    decode_helper(tail, map_new, [item | acc])
  end

  @spec construct_list(String.t(), list(tuple()), map) :: map()
  defp construct_list("", _, map), do: map |> reverse_strings_in_map

  defp construct_list(<<first, rest::binary>>, [{_x, y} | tail], map) do
    construct_list(rest, tail, %{map | y => [first | Map.get(map, y)]})
  end

  @spec create_grid(pos_integer()) :: map()
  defp create_grid(rails) do
    []
    |> List.duplicate(rails)
    |> Stream.with_index()
    |> Enum.to_list()
    |> Enum.map(fn {x, y} -> {y, x} end)
    |> Map.new()
  end

  @spec reverse_strings_in_map(map()) :: map()
  defp reverse_strings_in_map(map) do
    map
    |> Enum.map(fn {key, v} -> {key, Enum.reverse(v)} end)
    |> Map.new()
  end
end
