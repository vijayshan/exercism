defmodule LanguageList do
  def new(), do: []

  def add(list, language), do: [language|list]

  def remove([_|tail]), do: tail

  def first([first|_]), do: first

  def count([_head|tail]), do: 1 + count(tail)
  def count([]), do: 0

  def exciting_list?(["Elixir"|_]), do: true
  def exciting_list?([_|tail]), do: exciting_list?(tail)
  def exciting_list?([]), do: false

end
