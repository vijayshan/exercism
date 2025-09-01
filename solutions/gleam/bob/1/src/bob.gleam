import gleam/regex
import gleam/string

pub fn hey(remark: String) -> String {
  let sanitized_remark = remark |> string.trim_left |> string.trim_right

  let last = string.last(sanitized_remark)

  let is_caps = string.uppercase(sanitized_remark) == sanitized_remark

  let options = regex.Options(case_insensitive: True, multi_line: True)
  let assert Ok(re) = regex.compile("[a-z]", with: options)
  let contains_characters = regex.check(re, sanitized_remark)

  case sanitized_remark, contains_characters && is_caps, last {
    "", _, _ -> "Fine. Be that way!"
    _, True, Ok("?") -> "Calm down, I know what I'm doing!"
    _, _, Ok("?") -> "Sure."
    _, True, _ -> "Whoa, chill out!"
    _, _, _ -> "Whatever."
  }
}
