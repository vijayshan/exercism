import gleam/list
import gleam/string

pub fn distance(strand1: String, strand2: String) -> Result(Int, Nil) {
  case strand1 |> string.length() == strand2 |> string.length() {
    True ->
      strand1
      |> string.to_graphemes
      |> list.zip(strand2 |> string.to_graphemes)
      |> list.filter(fn(k) { k.0 != k.1 })
      |> list.length
      |> Ok
    False -> Error(Nil)
  }
}
