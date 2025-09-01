defmodule RomanNumerals do
  @digits ['M', 'D', 'C', 'L', 'X', 'V', 'I']
  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    list =
      case number do
        num when num >= 1000 ->
          Enum.concat(
            List.duplicate('M', trunc(num / 1000)),
            roman_numerals(rem(num, 1000), @digits, 100)
          )

        num ->
          roman_numerals(num, @digits, 100)
      end

    to_string(list)
  end

  # for anything less than 1000, the pattern repeats with different characters.
  # This function handles that through recursion 
  @spec roman_numerals(pos_integer, charlist(), pos_integer) :: charlist()
  defp roman_numerals(number, rep_list, place) do
    [tens, fives | [ones | _] = tail] = rep_list
    # the mapping is based in simple rules
    # the special cases are mapped here
    ret_list =
      case trunc(number / place) do
        # 0
        digit when digit == 0 ->
          []

        # less 1,2,3
        digit when digit < 4 ->
          Enum.map(1..trunc(digit), fn _ -> ones end)

        # digit is 4
        digit when digit == 4 ->
          [ones, fives]

        # digit is 5
        digit when digit == 5 ->
          [fives]

        # digit is 6,7,8
        digit when digit > 5 and digit < 9 ->
          [fives | Enum.map(1..(trunc(digit) - 5), fn _ -> ones end)]

        # digit is 9
        digit when digit == 9 ->
          [ones, tens]
      end

    # check if number needs to be further reduced 
    # and proceed to recurse after reducing the 
    # character list
    if rem(number, place) != 0 and place >= 10 do
      Enum.concat(ret_list, roman_numerals(rem(number, place), tail, trunc(place / 10)))
    else
      ret_list
    end
  end
end
