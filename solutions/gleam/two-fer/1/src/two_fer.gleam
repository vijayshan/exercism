import gleam/option.{type Option, Some}

pub fn two_fer(name: Option(String)) -> String {
  case name {
    Some(x) -> "One for " <> x <> ", one for me."
    option.None -> "One for you, one for me."
  }
}
