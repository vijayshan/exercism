import gleam/string

pub fn extract_error(problem: Result(a, b)) -> b {
  let assert Error(x) = problem
  x
}

pub fn remove_team_prefix(team: String) -> String {
  let assert [_h, ..t] = string.split(team, " ")
  string.concat(t)
}

pub fn split_region_and_team(combined: String) -> #(String, String) {
  let assert [h, ..t] = string.split(combined, ",")
  #(h, t |> string.concat |> remove_team_prefix)
}
