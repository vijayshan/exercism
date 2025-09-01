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

# He answers 'Whoa, chill out!' if you yell at him.

# He answers 'Calm down, I know what I'm doing!' if you yell a question at him.

# He says 'Fine. Be that way!' if you address him without actually saying anything.

# He answers 'Whatever.' to anything else.
