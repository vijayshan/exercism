import gleam/int
import gleam/list
import gleam/string

pub fn largest_product(digits: String, span: Int) -> Result(Int, Nil) {
  let split = digits |> string.to_graphemes
  case split, list.length(split), span {
    _, _, y if y < 0 -> Error(Nil)
    _, x, y if y > x -> Error(Nil)
    _, _, 0 -> Ok(1)
    sp, _, _ ->
      case sp |> list.try_map(int.parse) {
        Error(_) -> Error(Nil)
        Ok(l) ->
          l
          |> list.window(span)
          |> list.map(fn(lis) { list.fold(lis, 1, fn(a, b) { a * b }) })
          |> list.max(int.compare)
      }
  }
}
