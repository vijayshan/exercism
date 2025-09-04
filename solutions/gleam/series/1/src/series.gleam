import gleam/list
import gleam/string

pub type Error {
  SliceLengthZero
  SliceLengthTooLarge
  SliceLengthNegative
  EmptySeries
  Nil
}

pub fn slices(input: String, size: Int) -> Result(List(String), Error) {
  case string.length(input), size {
    0, _ -> Error(EmptySeries)
    _, 0 -> Error(SliceLengthZero)
    _, size if size < 0 -> Error(SliceLengthNegative)
    len, size if size > len -> Error(SliceLengthTooLarge)
    len, size if size <= len ->
      input
      |> string.to_graphemes
      |> list.window(size)
      |> list.map(string.join(_, ""))
      |> Ok

    _, _ -> Error(Nil)
  }
}
