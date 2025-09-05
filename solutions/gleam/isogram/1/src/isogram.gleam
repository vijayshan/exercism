import gleam/list
import gleam/string

pub fn is_isogram(phrase phrase: String) -> Bool {
  phrase
  |> string.lowercase
  |> string.to_graphemes
  |> list.filter(fn(x) { x != " " && x != "-" })
  |> fn(filtered_list) {
    filtered_list |> string.join("")
    == filtered_list |> list.unique |> string.join("")
  }
}
