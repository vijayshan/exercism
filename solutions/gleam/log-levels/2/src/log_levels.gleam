import gleam/string

pub fn message(log_line: String) -> String {
  case log_line {
    "[_]: " <> rest -> rest |> string.trim_left |> string.trim_right
    "[ERROR]: " <> rest -> rest |> string.trim_left |> string.trim_right
    "[WARNING]: " <> rest -> rest |> string.trim_left |> string.trim_right
    _ -> ""
  }
}

pub fn log_level(log_line: String) -> String {
  case log_line {
    "[_]: " as first <> _ -> first
    "[ERROR]: " <> _ -> "error"
    "[WARNING]: " <> _ -> "warning"
    _ -> ""
  }
}

pub fn reformat(log_line: String) -> String {
  message(log_line) <> " (" <> log_level(log_line) <> ")"
}
