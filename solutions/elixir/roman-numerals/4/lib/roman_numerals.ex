defmodule RomanNumerals do
  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    numeral_construct(number, "")
  end

  defp numeral_construct(number, agg) do
    case number do
      number when number >= 1000 ->
        String.duplicate("M", div(number, 1000))
        numeral_construct(rem(number, 1000), agg <> String.duplicate("M", div(number, 1000)))

      number when number >= 900 ->
        numeral_construct(number - 900, agg <> "CM")

      number when number >= 500 ->
        numeral_construct(
          rem(number, 100),
          agg <>
            "D" <>
            String.duplicate("C", trunc(number / 100) - 5)
        )

      number when number >= 400 ->
        numeral_construct(number - 400, agg <> "CD")

      number when number >= 100 ->
        numeral_construct(rem(number, 100), agg <> String.duplicate("C", div(number, 100)))

      number when number >= 90 ->
        numeral_construct(number - 90, agg <> "XC")

      number when number >= 50 ->
        numeral_construct(
          rem(number, 10),
          agg <>
            "L" <>
            String.duplicate("X", div(number, 10) - 5)
        )

      number when number >= 40 ->
        numeral_construct(number - 40, agg <> "XL")

      number when number >= 10 ->
        numeral_construct(rem(number, 10), agg <> String.duplicate("X", div(number, 10)))

      number when number >= 9 ->
        agg <> "IX"

      number when number >= 5 ->
        agg <> "V" <> String.duplicate("I", number - 5)

      number when number >= 4 ->
        agg <> "IV"

      number when number >= 1 ->
        agg <> String.duplicate("I", number)

      _ ->
        agg
    end
  end
end
