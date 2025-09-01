import gleam/list
import gleam/string

pub fn reverse(value: String) -> String {
  string.split(value, "") |> reverse_string() |> string.join("")
}

fn reverse_string(vals: List(String)) {
  case vals {
    [h, ..t] -> list.append(reverse_string(t), [h])
    _ -> []
  }
}
