defmodule Bob do
  def hey(input) do
    cond do
      # caps
      # contains only upper case letters
      String.upcase(input) == input && String.downcase(input) != input ->
        # upper
        checkQuestion(input, "Calm down, I know what I'm doing!", "Whoa, chill out!")

      # contains lowercase letters
      # special case for numbers alone
      # question mark with special characters qualifies too
      String.upcase(input) != input ||
        String.contains?(input, Enum.to_list(0..9 |> Enum.map(fn x -> to_string(x) end))) ||
          String.trim(input) |> String.ends_with?("?") ->
        # lower
        checkQuestion(input, "Sure.", "Whatever.")

      true ->
        "Fine. Be that way!"
    end
  end

  defp checkQuestion(input, true_str, false_str) do
    if String.trim(input) |> String.ends_with?("?"), do: true_str, else: false_str
  end
end
