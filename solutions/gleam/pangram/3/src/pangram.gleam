import gleam/list.{all}
import gleam/string.{contains, lowercase, to_graphemes}

pub fn is_pangram(sentence: String) -> Bool {
  let sentence = sentence |> lowercase
  "abcdefghijklmnopqrstuvwxyz"
  |> to_graphemes
  |> all(contains(sentence, _))
}
