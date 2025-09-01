import gleam/option.{None, Some}
import gleam/regex

pub fn is_valid_line(line: String) -> Bool {
  let assert Ok(re) =
    regex.from_string("\\[DEBUG\\]|\\[INFO\\]|\\[WARNING\\]|\\[ERROR\\].*")
  regex.check(re, line)
}

pub fn split_line(line: String) -> List(String) {
  let assert Ok(re) = regex.from_string("<[*|~+=-]*>")
  regex.split(with: re, content: line)
}

pub fn tag_with_user_name(line: String) -> String {
  let assert Ok(re) = regex.from_string("User[ \t\n]+([^ \t\n]*)")
  case regex.scan(re, line) {
    [match, ..] -> {
      case match.submatches {
        [name, ..] -> {
          case name {
            Some(user_name) -> "[USER] " <> user_name <> " " <> line
            None -> line
          }
        }
        [] -> line
      }
    }
    [] -> line
  }
}
