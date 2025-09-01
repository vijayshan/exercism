import gleam/list
import gleam/string

pub fn find_anagrams(word: String, candidates: List(String)) -> List(String) {
  let sorted = fn(str) {
    str |> string.lowercase |> string.to_graphemes |> list.sort(string.compare)
  }
  let split_string = word |> sorted
  candidates
  |> list.filter(fn(str) {
    sorted(str) == split_string
    && { string.lowercase(word) != string.lowercase(str) }
  })
}
