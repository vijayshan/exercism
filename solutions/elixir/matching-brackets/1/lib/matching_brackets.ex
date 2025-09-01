defmodule MatchingBrackets do
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t(), list(any())) :: boolean
  def check_brackets(str, acc \\ [])

  def check_brackets("", []), do: true

  def check_brackets("", [_head | _tail]), do: false

  def check_brackets(<<?{, rest::binary>>, acc), do: check_brackets(rest, [?{ | acc])

  def check_brackets(<<?(, rest::binary>>, acc), do: check_brackets(rest, [?( | acc])

  def check_brackets(<<?[, rest::binary>>, acc), do: check_brackets(rest, [?[ | acc])

  def check_brackets(<<?}, rest::binary>>, [?{ | tail]), do: check_brackets(rest, tail)

  def check_brackets(<<?), rest::binary>>, [?( | tail]), do: check_brackets(rest, tail)

  def check_brackets(<<?], rest::binary>>, [?[ | tail]), do: check_brackets(rest, tail)

  def check_brackets(<<_head, rest::binary>> = str, acc) do
    cond do
      Regex.match?(~r/^([\{\}\[\]\(\)]){1,}.*/, str) -> false
      true -> check_brackets(rest, acc)
    end
  end
end
