pub type Error {
  NonPositiveNumber
}

pub fn steps(number: Int) -> Result(Int, Error) {
  case number > 0 {
    True -> Ok(steps_(number, 0))
    False -> Error(NonPositiveNumber)
  }
}

fn steps_(number, step) {
  case number {
    1 -> step
    n if n % 2 == 0 -> steps_(number / 2, step + 1)
    _ -> steps_(number * 3 + 1, step + 1)
  }
}
