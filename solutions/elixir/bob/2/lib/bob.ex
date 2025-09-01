defmodule Bob do
  def hey(input) do
    cond do
      Regex.run(~r/^[\p{Lu}' ]*\?[ ]*$/u, input) != nil ->
        # yelled questions
        "Calm down, I know what I'm doing!"

      Regex.run(~r/^(?=.*\p{Lu}{1,})[\p{Lu}0-9![:punct:] ]*$/u, input) != nil ->
        # shouting
        "Whoa, chill out!"

      Regex.run(~r/^[\p{L}[:punct:]0-9 ]*\?[ ]*$/u, input) != nil ->
        # questions
        "Sure."

      Regex.run(~r/^[\n\r \t]*$/u, input) != nil ->
        # Exclamation
        "Fine. Be that way!"

      true ->
        "Whatever."
    end
  end
end
