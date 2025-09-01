defmodule ResistorColor do
  @moduledoc false

  @spec colors() :: list(String.t())
  def colors do
    for x <- 0..9, do: code(x)
  end

  @spec code(String.t()) :: integer()
  def code(color) do
    case color do
      "black" ->
        0

      "brown" ->
        1

      "red" ->
        2

      "orange" ->
        3

      "yellow" ->
        4

      "green" ->
        5

      "blue" ->
        6

      "violet" ->
        7

      "grey" ->
        8

      "white" ->
        9
    end
  end
end
