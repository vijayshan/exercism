import gleam/list
import gleam/result

pub type Error {
  InvalidSquare
}

pub fn square(squarenum: Int) -> Result(Int, Error) {
  case squarenum {
    s if s < 1 -> Error(InvalidSquare)
    s if s > 64 -> Error(InvalidSquare)
    1 -> Ok(1)
    s -> Ok(2 * result.unwrap(square(s - 1), 1))
  }
}

pub fn total() -> Int {
  list.range(1, 64)
  |> list.map(square)
  |> list.map(result.unwrap(_, 0))
  |> list.fold(0, fn(a, b) { a + b })
}
