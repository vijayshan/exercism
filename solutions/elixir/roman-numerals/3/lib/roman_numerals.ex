defmodule RomanNumerals do
  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    case number do
      number when number >= 1000 ->
        String.duplicate("M", trunc(number / 1000)) <>
          numeral(number - trunc(number / 1000) * 1000)

      number when number >= 900 ->
        "CM" <> numeral(number - 900)

      number when number >= 500 ->
        "D" <>
          String.duplicate("C", trunc(number / 100) - 5) <>
          numeral(number - trunc(number / 100) * 100)

      number when number >= 400 ->
        "CD" <> numeral(number - 400)

      number when number >= 100 ->
        String.duplicate("C", trunc(number / 100)) <> numeral(number - trunc(number / 100) * 100)

      number when number >= 90 ->
        "XC" <> numeral(number - 90)

      number when number >= 50 ->
        "L" <>
          String.duplicate("X", trunc(number / 10) - 5) <>
          numeral(number - trunc(number / 10) * 10)

      number when number >= 40 ->
        "XL" <> numeral(number - 40)

      number when number >= 10 ->
        String.duplicate("X", trunc(number / 10)) <> numeral(number - trunc(number / 10) * 10)

      number when number >= 9 ->
        "IX"

      number when number >= 5 ->
        "V" <> String.duplicate("I", number - 5)

      number when number >= 4 ->
        "IV"

      number when number >= 1 ->
        String.duplicate("I", number)

      _ ->
        ""
    end
  end
end
