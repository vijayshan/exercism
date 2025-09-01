defmodule TwelveDays do
  @doc """
  Given a `number`, return the song's verse for that specific day, including
  all gifts for previous days in the same line.
  """

  # @spec verse(number :: integer) :: String.t()
  # def verse(number) do
  #   verse(number, "")
  # end

  @spec verse(number :: integer) :: String.t()
  def verse(number) do
    verse_val =
      case number do
        1 ->
          "On the first day of Christmas my true love gave to me:"

        2 ->
          "On the second day of Christmas my true love gave to me:"

        3 ->
          "On the third day of Christmas my true love gave to me:"

        4 ->
          "On the fourth day of Christmas my true love gave to me:"

        5 ->
          "On the fifth day of Christmas my true love gave to me:"

        6 ->
          "On the sixth day of Christmas my true love gave to me:"

        7 ->
          "On the seventh day of Christmas my true love gave to me:"

        8 ->
          "On the eighth day of Christmas my true love gave to me:"

        9 ->
          "On the ninth day of Christmas my true love gave to me:"

        10 ->
          "On the tenth day of Christmas my true love gave to me:"

        11 ->
          "On the eleventh day of Christmas my true love gave to me:"

        12 ->
          "On the twelfth day of Christmas my true love gave to me:"

        _ ->
          ""
      end

    verse_val <> " " <> verses_helper(number)
  end

  defp verses_helper(number, acc \\ "")

  defp verses_helper(1, "") do
    "a Partridge in a Pear Tree."
  end

  defp verses_helper(1, acc) do
    acc <> "and a Partridge in a Pear Tree."
  end

  defp verses_helper(number, acc) do
    verse_val =
      case number do
        2 ->
          "two Turtle Doves"

        3 ->
          "three French Hens"

        4 ->
          "four Calling Birds"

        5 ->
          "five Gold Rings"

        6 ->
          "six Geese-a-Laying"

        7 ->
          "seven Swans-a-Swimming"

        8 ->
          "eight Maids-a-Milking"

        9 ->
          "nine Ladies Dancing"

        10 ->
          "ten Lords-a-Leaping"

        11 ->
          "eleven Pipers Piping"

        12 ->
          "twelve Drummers Drumming"

        _ ->
          ""
      end

    verses_helper(number - 1, acc <> verse_val <> ", ")
  end

  @doc """
  Given a `starting_verse` and an `ending_verse`, return the verses for each
  included day, one per line.
  """
  @spec verses(starting_verse :: integer, ending_verse :: integer, acc :: String.t()) ::
          String.t()
  def verses(starting_verse, ending_verse, acc \\ "")

  def verses(starting_verse, ending_verse, acc) when ending_verse > 12 do
    verses(starting_verse, 12, acc)
  end

  def verses(starting_verse, ending_verse, acc) when starting_verse < 1 do
    verses(0, ending_verse, acc)
  end

  def verses(starting_verse, ending_verse, acc) when starting_verse > ending_verse do
    String.trim(acc)
  end

  def verses(starting_verse, ending_verse, acc) do
    verses(starting_verse + 1, ending_verse, acc <> verse(starting_verse) <> "\n")
  end

  @doc """
  Sing all 12 verses, in order, one verse per line.
  """
  @spec sing() :: String.t()
  def sing do
    verses(1, 12)
  end
end
