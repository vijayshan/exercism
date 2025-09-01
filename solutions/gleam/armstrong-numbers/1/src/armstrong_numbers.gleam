import gleam/int
import gleam/list
import gleam/string

pub fn is_armstrong_number(number: Int) -> Bool {
  number >= 0
  && number
  == int.to_string(number)
  |> string.split("")
  |> list.try_map(int.parse)
  |> fn(x) {
    let digits = case x {
      Ok(digits) -> digits
      Error(_) -> []
    }
    let length = list.length(digits)
    digits |> list.map(fn(y) { power(y, length) })
  }
  // |> list.map(fn(x) { list.fold(x, 1, fn(acc, x) { acc * x }) })
  |> list.fold(0, fn(acc, x) { acc + x })
}

fn power(base: Int, exponent: Int) -> Int {
  case exponent {
    0 -> 1
    1 -> base
    _ -> base * power(base, exponent - 1)
  }
}
