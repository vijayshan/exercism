defmodule GuessingGame do

  def compare(a,b\\:no_guess)
  def compare(secret_number, secret_number), do: "Correct"
  def compare(secret_number, guess) when guess == secret_number+1, do: "So close"
  def compare(secret_number, guess) when guess == secret_number-1, do: "So close"
  def compare(secret_number, guess) when guess>secret_number, do: "Too high"
  def compare(secret_number, guess) when guess<secret_number, do: "Too low"
  # def compare(_, :no_guess), do: "Make a guess"

end
