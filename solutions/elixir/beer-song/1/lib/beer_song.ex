defmodule BeerSong do
  @doc """
  Get a single verse of the beer song
  """
  @spec verse(integer) :: String.t()
  def verse(number) do
    on_wall = bottles(number)
    after_take = bottles(number - 1)

    cond do
      number == 0 ->
        """
        No more bottles of beer on the wall, no more bottles of beer.
        Go to the store and buy some more, 99 bottles of beer on the wall.
        """

      number == 1 ->
        """
        #{on_wall} of beer on the wall, #{on_wall} of beer.
        Take it down and pass it around, no more bottles of beer on the wall.
        """

      number > 1 ->
        """
        #{on_wall} of beer on the wall, #{on_wall} of beer.
        Take one down and pass it around, #{after_take} of beer on the wall.
        """
    end
  end

  defp bottles(number) do
    cond do
      number > 1 -> "#{number} bottles"
      number == 1 -> "1 bottle"
      number == 0 -> "No more bottles"
      true-> ""
    end
  end

  @doc """
  Get the entire beer song for a given range of numbers of bottles.
  """
  @spec lyrics(Range.t()) :: String.t()
  def lyrics(range \\ 99..0) do
    Enum.reduce(range, "", fn x, acc -> acc <>"\n"<> verse(x) end)
    |>String.slice(1..-1)
  end
end
