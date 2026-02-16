import gleam/dict
import gleam/list
import gleam/result
import gleam/string

pub fn is_paired(value: String) -> Bool {
  let bracket_dict = dict.from_list([#("}", "{"), #("]", "["), #(")", "(")])
  value
  |> string.to_graphemes
  |> list.fold([], fn(acc, char) {
    case char {
      "(" | "[" | "{" -> [char, ..acc]
      ")" | "]" | "}" -> {
        case
          dict.get(bracket_dict, char) |> result.unwrap("")
          == list.first(acc) |> result.unwrap("")
        {
          True -> list.drop(acc, 1)
          False -> [char, ..acc]
        }
      }
      _ -> acc
    }
  })
  |> list.is_empty
}
