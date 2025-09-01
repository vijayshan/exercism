import gleam/dict.{type Dict}
import gleam/list
import gleam/string

pub fn transform(legacy: Dict(Int, List(String))) -> Dict(String, Int) {
  legacy
  |> dict.to_list
  |> list.flat_map(fn(tup) {
    tup.1
    |> list.map(fn(letter) { #(letter |> string.lowercase, tup.0) })
  })
  |> dict.from_list
}
