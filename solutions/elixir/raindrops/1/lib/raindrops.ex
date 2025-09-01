defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t()
  def convert(number) do
    val =
      convert_helper("", 3, number, "Pling")
      |> convert_helper(5, number, "Plang")
      |> convert_helper(7, number, "Plong")

    if val == "" do
      to_string(number)
    else
      val
    end
  end

  # a helper function that checks if num is divisible by factor_check and
  # appends ret_append_value to start_value else returns the start_value

  defp convert_helper(start_value, factor_check, num, ret_append_value) do
    if rem(num, factor_check) == 0 do
      start_value <> ret_append_value
    else
      start_value
    end
  end
end
