const correct_guess: Int = 42

pub fn reply(guess: Int) -> String {
  case guess - correct_guess {
    0 -> "Correct"
    i if i == 1 || i == -1 -> "So close"
    i if i < -1 -> "Too low"
    i if i > 1 -> "Too high"
    _ -> ""
  }
}
