import gleam/list
import gleam/string

pub fn is_pangram(sentence: String) -> Bool {
  let sentence_normal = sentence |> string.lowercase
  "abcdefghijklmnopqrstuvwxyz"
  |> string.to_graphemes
  |> list.all(fn(x) { string.contains(sentence_normal, x) })
}
