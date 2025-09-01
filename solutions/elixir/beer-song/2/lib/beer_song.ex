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

  defp bottles(0), do: "No more bottles"
  defp bottles(1), do: "1 bottle"
  defp bottles(number), do: "#{number} bottles"

  @doc """
  Get the entire beer song for a given range of numbers of bottles.
  """
  @spec lyrics(Range.t()) :: String.t()
  def lyrics(first..last \\ 99..0) do
    Enum.reduce(first-1..last, verse(first), fn x, acc -> acc <>"\n"<> verse(x) end)
  end
end
