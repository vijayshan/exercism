defmodule Bob do
  def hey(input) do
    trimmed = String.trim(input)
    upcase = String.upcase(input)
    lowcase = String.downcase(input)
    yelled = upcase == input && lowcase != input
    question = String.ends_with?(trimmed, "?")

    cond do
      # upper
      yelled && question ->
        "Calm down, I know what I'm doing!"

      yelled ->
        "Whoa, chill out!"

      question ->
        "Sure."

      trimmed == "" ->
        "Fine. Be that way!"

      true ->
        "Whatever."
    end
  end
end
