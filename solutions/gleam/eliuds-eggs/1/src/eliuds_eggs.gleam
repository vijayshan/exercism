import gleam/int
import gleam/list
import gleam/string

pub fn egg_count(number: Int) -> Int {
  number |> int.to_base2 |> string.to_graphemes |> list.fold(0, count_ones)
}

fn count_ones(acc: Int, char: String) -> Int {
  case char {
    "1" -> acc + 1
    _ -> acc
  }
}
